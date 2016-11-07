;; llvm-as max.ll; opt -std-compile-opts max.bc -f | llc -march=x86 -mcpu=penryn -f

define <4xfloat> @muda_maxf4(<4xfloat> %a, <4xfloat> %b)
{

	;; extract
	%a0 = extractelement <4xfloat> %a, i32 0
	%a1 = extractelement <4xfloat> %a, i32 1
	%a2 = extractelement <4xfloat> %a, i32 2
	%a3 = extractelement <4xfloat> %a, i32 3

	%b0 = extractelement <4xfloat> %b, i32 0
	%b1 = extractelement <4xfloat> %b, i32 1
	%b2 = extractelement <4xfloat> %b, i32 2
	%b3 = extractelement <4xfloat> %b, i32 3

	;; c[N] = a[N] > b[N]
	%c0 = fcmp ogt float %a0, %b0
	%c1 = fcmp ogt float %a1, %b1
	%c2 = fcmp ogt float %a2, %b2
	%c3 = fcmp ogt float %a3, %b3
		
	;; if %c[N] == 1 then %a[N] else %b[N]

	%r0 = select i1 %c0, float %a0, float %b0
	%r1 = select i1 %c1, float %a1, float %b1
	%r2 = select i1 %c2, float %a2, float %b2
	%r3 = select i1 %c3, float %a3, float %b3

	;; pack

	%tmp0 = insertelement <4xfloat> undef, float %r0, i32 0
	%tmp1 = insertelement <4xfloat> %tmp0, float %r1, i32 1
	%tmp2 = insertelement <4xfloat> %tmp1, float %r2, i32 2
	%r    = insertelement <4xfloat> %tmp2, float %r3, i32 3

	ret <4xfloat> %r
}
