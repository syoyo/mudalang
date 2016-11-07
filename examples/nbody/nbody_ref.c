/*
 * Copyright 1993-2006 NVIDIA Corporation.  All rights reserved.
 *
 * NOTICE TO USER:   
 *
 * This source code is subject to NVIDIA ownership rights under U.S. and 
 * international Copyright laws.  
 *
 * NVIDIA MAKES NO REPRESENTATION ABOUT THE SUITABILITY OF THIS SOURCE 
 * CODE FOR ANY PURPOSE.  IT IS PROVIDED "AS IS" WITHOUT EXPRESS OR 
 * IMPLIED WARRANTY OF ANY KIND.  NVIDIA DISCLAIMS ALL WARRANTIES WITH 
 * REGARD TO THIS SOURCE CODE, INCLUDING ALL IMPLIED WARRANTIES OF 
 * MERCHANTABILITY, NONINFRINGEMENT, AND FITNESS FOR A PARTICULAR PURPOSE.   
 * IN NO EVENT SHALL NVIDIA BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL, 
 * OR CONSEQUENTIAL DAMAGES, OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS 
 * OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE 
 * OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE 
 * OR PERFORMANCE OF THIS SOURCE CODE.  
 *
 * U.S. Government End Users.  This source code is a "commercial item" as 
 * that term is defined at 48 C.F.R. 2.101 (OCT 1995), consisting  of 
 * "commercial computer software" and "commercial computer software 
 * documentation" as such terms are used in 48 C.F.R. 12.212 (SEPT 1995) 
 * and is provided to the U.S. Government only as a commercial end item.  
 * Consistent with 48 C.F.R.12.212 and 48 C.F.R. 227.7202-1 through 
 * 227.7202-4 (JUNE 1995), all U.S. Government End Users acquire the 
 * source code with only those rights set forth herein.
 */

#include <math.h>


static void
bodyBodyInteraction(
    float *accel_x,
    float *accel_y,
    float *accel_z,
    float posMass0_x,
    float posMass0_y,
    float posMass0_z,
    float posMass1_x,
    float posMass1_y,
    float posMass1_z,
    float mass,
    float softeningSquared)
{
    float r[3];

    // r_01  [3 FLOPS]
    r[0] = posMass0_x - posMass1_x;
    r[1] = posMass0_y - posMass1_y;
    r[2] = posMass0_z - posMass1_z;

    // d^2 + e^2 [6 FLOPS]
    float distSqr = r[0] * r[0] + r[1] * r[1] + r[2] * r[2];
    distSqr += softeningSquared;

    // invDistCube =1/distSqr^(3/2)  [4 FLOPS (2 mul, 1 sqrt, 1 inv)]
    float invDist = 1.0f / sqrtf(distSqr);
	float invDistCube =  invDist * invDist * invDist;

    // s = m_j * invDistCube [1 FLOP]
    float s = mass * invDistCube;

    // (m_1 * r_01) / (d^2 + e^2)^(3/2)  [6 FLOPS]
    (*accel_x) += r[0] * s;
    (*accel_y) += r[1] * s;
    (*accel_z) += r[2] * s;
}

void
computeRef(
    float *force_x,
    float *force_y,
    float *force_z,
    float *pos_x,
    float *pos_y,
    float *pos_z,
    float *mass,
    const unsigned int numBodies,
    float softeningSquared) 
{
    unsigned int i, j;
	float f_x, f_y, f_z;		

    for(i = 0; i < numBodies; ++i)
    {
        force_x[i] = 0;
		force_y[i] = 0;
		force_z[i] = 0;
    }

    for(i = 0; i < numBodies; ++i) 
    {
        for(j = 0; j < numBodies; ++j) 
	    {
	        bodyBodyInteraction(
                &f_x,
                &f_y,
                &f_z,
                pos_x[j],
                pos_y[j],
                pos_z[j],
                pos_x[i],
                pos_y[i],
                pos_z[i],
                mass[i],
                softeningSquared);

	        force_x[i] += f_x;
	        force_y[i] += f_y;
	        force_z[i] += f_z;
	    }
    }
}

