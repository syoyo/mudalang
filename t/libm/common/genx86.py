#!/usr/bin/env python

#
# test code gen for x86/SSE
#



from string import Template


def emitCornerTests(funcName, refName, corners):

    s = """
typedef union {
    float        f;
    unsigned int ui;
} mem;

mem m, mret, mref;

// NaN checker
int is_both_nan(unsigned int a, unsigned int b)
{
    unsigned int ea = (a & 0x7f800000) >> 23;
    unsigned int eb = (b & 0x7f800000) >> 23;
    unsigned int ma = (a & 0x007fffff);
    unsigned int mb = (b & 0x007fffff);

    if ((ea == eb) && (ea == 255)) {

        if ((ma != 0) && (mb != 0)) {
            return 1;
        }

    }

    return 0;

}
"""

    s += "void test_corner_%s() {\n" % funcName

    for i in range(len(corners)):

        showStr = corners[i][0]
        inVal   = corners[i][1]

        print corners[i]

        s += "float tmp_%d[8];\n" % i
        s += "m.ui = %sU;\n" % inVal
        s += "__m128 in_%d = _mm_set_ps1(m.f);\n" % (i)
        s += "__m128 ret_%d = %s((const float *)&in_%d);\n" % (i, funcName, i)
        s += "float ref_%d = %s(m.f);\n" % (i, refName)
        s += "_mm_storeu_ps(tmp_%d, ret_%d);\n" % (i, i)
        s += "mret.f = tmp_%d[0];\n" % i
        s += "mref.f = ref_%d;\n" % i
        s += "if (is_both_nan(mret.ui, mref.ui)) {\n"
        s += "  printf(\"# %s(%%f[=0x%%08x]) OK: libm = NaN[=0x%%08x], muda = NaN[=0x%%08x]\\n\", m.f, m.ui, mref.ui, mret.ui);\n" % (funcName)
        s += "} else if (mret.ui == mref.ui) {\n"
        s += "  printf(\"# %s(%%f[=0x%%08x]) OK: libm = %%f, muda = %%f\\n\", m.f, m.ui, ref_%d, tmp_%d[0]);\n" % (funcName, i, i)
        s += "} else {\n"
        s += "  printf(\"# %s(%%f[=0x%%08x]) Failed: Expected %%f[=0x%%08x], but got %%f[=0x%%08x]\\n\", m.f, m.ui, mref.f, mref.ui, mret.f, mret.ui);\n" % (funcName)
        s += "  exit(2);\n"
        s += "}\n\n"

    s += "}\n"

    return s

        

def emitCodeBody(funcName, refName, (doFullTest, doNegTest), corners, (doRangeTest, startval, endval, stepval)):

    d = {}
    d["func"]  = funcName;
    d["ref"]   = refName;

    if doNegTest == True:
        d["doneg"] = 1;
    else:
        d["doneg"] = 0;

    if doFullTest == True:
        d["dofullcheck"] = 1;
    else:
        d["dofullcheck"]  = 0;

    if doRangeTest == True:
        d["dorangecheck"] = 1;
    else:
        d["dorangecheck"]  = 0;

    if len(corners) > 0:
        d["docornercheck"] = 1;
    else:
        d["docornercheck"]  = 0;

    d["startVal"]     = startval;
    d["endVal"]       = endval;
    d["stepVal"]      = stepval;

    hdr = Template("""
#include <stdio.h>
#include <math.h>
#include <float.h>
#include <xmmintrin.h>

#include "prof.h"

//#include "${func}.c"
#include "mudaintrin_sse.h"
""")

    ss = hdr.substitute(d)

    ss += emitCornerTests(funcName, refName, corners)

    s = Template("""

// extern __m128 ${func}(const __m128 *x);

//
// Measure error of ${func}() compared with ${ref}()
//
// I know some formal verificiation of floating point(e.g. gappa),
// but I don't know how to incorpolate with it yet. 
// Thus, do brute force checking as below.
//
//
//   for sign in [-1, 1]
//     for exp in [1 .. 254]
//       for mantissa in [0 .. 2**23]
//
//         fval = sign * itof((exp << 23) | mantissa)
//
//
void test_${func}(int doNegativeValueTest)
{
    float val[4];
    float refval;
    double diff;
    double maxdiff = DBL_MIN;
    double maxdiffval = 0.0;

    double relativediff;
    
    unsigned int bdiff;
    unsigned int maxbdiff = 0;
    unsigned int maxbdiffval = 0;

    unsigned int maxbdiffs[1024];   // save diffs for each exponent bands
    double       maxrelativediff[1024];
    double       maxrelativediff_bande = 0.0;

    __m128 ret;
    __m128 in;

    int sign;
    int exponent;
    int mantissa;
    int mbits = 8388608;    // 2**23
    int ebits = 255;        
    int sbits;

    unsigned int sbit;

    //
    // TODO: sign bit?
    //

    typedef union _fival {
        float        fval;
        unsigned int ival;

    } fival;

    fival d;
    fival refd;
    fival mudad;
    fival mdiffval;
    fival mrelativediffval;

    printf("# t muda libm diff\\n");

    // TODO: test +0, -0 case.

    if (doNegativeValueTest) {
        sbits = 2;
    } else {
        sbits = 1;
    }

    int i;
    for (i = 0; i < 1024; i++) {
        maxbdiffs[i] = 0;
        maxrelativediff[i] = 0.0;
    }


    for (sign = 0; sign < sbits; sign++) {

        // 0 = +, 1 = -.
        // first test positive case
        //
        if (sign == 1) {    
            sbit = 0x80000000;
        } else {
            sbit = 0x00000000;
        }

        for (exponent = 1; exponent < ebits; exponent++) {
        // for (exponent = 126; exponent < 130; exponent++) {

            printf("# testing s=%d, e=%d of %d\\n", sign == 0 ? 0 : -1, exponent, ebits-1);

            maxrelativediff_bande = 0.0;

            for (mantissa = 0; mantissa < mbits; mantissa++) {

                d.ival = 0;
                d.ival = sbit | (exponent << 23) | (mantissa & (mbits - 1));

                in = _mm_set1_ps(d.fval);

                ret = ${func}((const float *)&in);

                _mm_storeu_ps(val, ret);

                // reference
                refval = ${ref}(d.fval);

                diff = fabs((double)val[0] - (double)refval);

                refd.fval  = refval;
                mudad.fval = val[0];

                bdiff = abs(abs(refd.ival) - abs(mudad.ival));

                // if (bdiff > 32) {
                //     printf("in = %f, muda = %f(0x%08x), ref = %f(0x%08x), diff=%d\\n", d.fval, mudad.fval, mudad.ival, refd.fval, refd.ival, bdiff);
                // }

                relativediff = diff / (double)refval;

                if (bdiff > maxbdiff) {


                    maxbdiff    = bdiff;

                    // TODO: fixme
                    if (maxdiff < diff) {
                        maxdiff     = diff;
                    } 
                    maxdiffval  = (double)d.fval;
                    maxbdiffval = d.ival;


                    mrelativediffval.fval = (float)relativediff;

                    printf("# s=%d, e=%d, m=%d, maxrelativediff = %.23e,  maxabsdiff = %.23e(%d ulp) at arg %.23e(0x%08x) \\n", sign, exponent, mantissa, mrelativediffval.fval, maxdiff, maxbdiff, maxdiffval, maxbdiffval);
                    printf("on = %f, muda = %f(0x%08x), ref = %f(0x%08x), diff=%d\\n", d.fval, mudad.fval, mudad.ival, refd.fval, refd.ival, bdiff);
        
                }

                if (relativediff > maxrelativediff_bande) {
                    maxrelativediff[sign * 512 + exponent] = relativediff;
                    maxrelativediff_bande = relativediff;
                }

                if (bdiff > maxbdiffs[sign * 512 + exponent]) {
                    maxbdiffs[sign * 512 + exponent] = bdiff;
                }

            } // m

            if (maxbdiff > 0) {
                printf("# maxdiff = %.23e(%d ulp) at arg %.23e(0x%08x) \\n", maxdiff, maxbdiff, maxdiffval, maxbdiffval);
            } else {
                printf("# nodiff\\n");
            }


        } // e

    } // s

    printf("# e, relative diff ----------------------\\n");

    for (i = 1; i < 254; i++) {
        // printf("# maxdiff[e=%d] : %d ulp\\n", i, maxbdiffs[i]);    
        printf("%d %.23e\\n", i, maxrelativediff[i]);
    }

    if (maxbdiff > 0) {
        printf("# maxdiff = %.16f(%d ulp) at arg %.23e(0x%08x) \\n", maxdiff, maxbdiff, maxdiffval, maxbdiffval);
    } else {
        printf("# nodiff\\n");
    }



}

void test_range_${func}(float startVal, float endVal, float stepVal)
{
    float val[4];
    float refval;
    double diff;
    double maxdiff = DBL_MIN;
    double maxdiffval = 0.0;
    
    unsigned int bdiff;
    unsigned int maxbdiff = 0;
    unsigned int maxbdiffval = 0;

    __m128 ret;
    __m128 in;

    //
    // TODO: sign bit?
    //

    typedef union _fival {
        float        fval;
        unsigned int ival;

    } fival;

    fival d;
    fival refd;
    fival mudad;
    fival mdiffval;

    printf("# t muda libm diff\\n");

    // TODO: test +0, -0 case.

    float f;

    for (f = startVal; f < endVal; f += stepVal) {

        d.fval = f;

        in = _mm_set1_ps(d.fval);

        ret = ${func}((const float *)&in);

        _mm_storeu_ps(val, ret);

        // reference
        refval = ${ref}(d.fval);

        diff = fabs((double)val[0] - (double)refval);

        refd.fval  = refval;
        mudad.fval = val[0];

        bdiff = abs(abs(refd.ival) - abs(mudad.ival));

        // printf("in = %f, muda = %f(0x%08x), ref = %f(0x%08x), diff=%d\\n", d.fval, mudad.fval, mudad.ival, refd.fval, refd.ival, bdiff);

        if (bdiff > maxbdiff) {


            maxbdiff    = bdiff;

            maxdiffval  = (double)d.fval;
            maxbdiffval = d.ival;

            printf("in = %f, muda = %f(0x%08x), ref = %f(0x%08x), diff=%d\\n", d.fval, mudad.fval, mudad.ival, refd.fval, refd.ival, bdiff);

        }

        // TODO: fixme
        if (maxdiff < diff) {
            maxdiff = diff;

            printf("in = %f, muda = %f(0x%08x), ref = %f(0x%08x), diff=%d\\n", d.fval, mudad.fval, mudad.ival, refd.fval, refd.ival, bdiff);
        } 

        // if (maxbdiff > 0) {
        //     printf("# maxdiff = %.23e(%d ulp) at arg %.23e(0x%08x) \\n", maxdiff, maxbdiff, maxdiffval, maxbdiffval);
        // } else {
        //     printf("# nodiff\\n");
        // }

    } // f

    printf("# ----------------------\\n");

    if (maxbdiff > 0) {
        printf("# maxdiff = %.16f(%d ulp) at arg %.23e(0x%08x) \\n", maxdiff, maxbdiff, maxdiffval, maxbdiffval);
    } else {
        printf("# nodiff\\n");
    }



}

//
// measure performance of ${func}().
// x86 only
//
void prof_${func}()
{

    unsigned long long s, e, cycles;
    unsigned long long basecost;

    __m128 ret;
    __m128 in;
    __m128 in0;
    __m128 in1;
    __m128 in2;
    __m128 in3;

    // 
    // Heat run phsae
    //
    in  = _mm_set1_ps(1.3f);
    in0 = _mm_set1_ps(1.3f);
    in1 = _mm_set1_ps(2.3f);
    in2 = _mm_set1_ps(3.3f);
    in3 = _mm_set1_ps(4.3f);

    s = getcycle();
    e = getcycle();
    basecost = e - s;

    s = getcycle();
    e = getcycle();
    basecost = e - s;

    s = getcycle();
    e = getcycle();
    basecost = e - s;


    s = getcycle();
    ret = ${func}((const float *)&in);
    e = getcycle();

    //
    // Actual measurement phase
    //
    s = getcycle();
    ret = ${func}((const float *)&in0);
    ret = ${func}((const float *)&in1);
    ret = ${func}((const float *)&in2);
    ret = ${func}((const float *)&in3);
    e = getcycle();

    printf("# ret = %d\\n", *(unsigned int *)&ret);

    cycles = e - s;

    printf("# cycles = %lld, diff = %lld, basecost = %lld, s = %lld, e = %lld\\n", (cycles-basecost)/4, cycles, basecost, s, e);


}

void
disableDenormal()
{
    int oldMXCSR = _mm_getcsr(); //read the old MXCSR setting
    int newMXCSR = oldMXCSR | 0x8040; // set DAZ and FZ bits
    _mm_setcsr( newMXCSR ); //write the new MXCSR setting to the MXCSR
}

int
main(int argc, char **argv)
{
    disableDenormal();

    if (${docornercheck}) {
        test_corner_${func}();
    }

    prof_${func}();

    if (${dofullcheck}) {
        test_${func}(${doneg});
    }

    if (${dorangecheck}) {
        test_range_${func}(${startVal}, ${endVal}, ${stepVal});
    }


    return 0;
}
""");
	

    ss += s.substitute(d)

    return ss
    

#
# main
#

def emitTestCode(funcName, refName, (doFullTest, doNegTest), corners, rangeTestVal = None):

    doRangeTest = False
    startval = 0.0
    endval   = 0.0
    stepval  = 0.0

    if (rangeTestVal != None):
        doRangeTest = True
        startval = rangeTestVal[0]
        endval   = rangeTestVal[1]
        stepval  = rangeTestVal[2]
    

    s = emitCodeBody(funcName, refName, (doFullTest, doNegTest), corners, (doRangeTest, startval, endval, stepval))

    fname = "test_" + funcName + ".c"

    f = open(fname, "w")

    print >>f, s

    print "Gen OK"

    f.close()
