#include <stdio.h>
#include <assert.h>
#include <math.h>

#include "muda.h"

#include "nbody_ref.h"

int numBodies = 1024;
//int numBodies = 16384;

int numIterations = 100; // run until exit

float softening = 1.0f;

static float *posRef[2][3];     // double buffer * xyz
static float *velRef[2][3];
static float *forceRef[3];
static float *massRef[2];
static float *invmassRef[2];

static float *posMUDA[2][3];
static float *velMUDA[2][3];
static float *forceMUDA[3];
static float *massMUDA[2];
static float *invmassMUDA[2];

void init(int numBodies)
{
    int i, j;
 
    for (i = 0; i < 3; i++) {
        posRef[0][i]  = mudaAlloc(numBodies * sizeof(float), 16);
        posRef[1][i]  = mudaAlloc(numBodies * sizeof(float), 16);
        velRef[0][i]  = mudaAlloc(numBodies * sizeof(float), 16);
        velRef[1][i]  = mudaAlloc(numBodies * sizeof(float), 16);
        forceRef [i]  = mudaAlloc(numBodies * sizeof(float), 16);

        posMUDA[0][i] = mudaAlloc(numBodies * sizeof(float), 16);
        posMUDA[1][i] = mudaAlloc(numBodies * sizeof(float), 16);
        velMUDA[0][i] = mudaAlloc(numBodies * sizeof(float), 16);
        velMUDA[1][i] = mudaAlloc(numBodies * sizeof(float), 16);
        forceRef  [i] = mudaAlloc(numBodies * sizeof(float), 16);
    }


    for (i = 0; i < 2; i++) {
        massRef [i]      = mudaAlloc(numBodies * sizeof(float), 16);
        invmassRef [i]   = mudaAlloc(numBodies * sizeof(float), 16);
        massMUDA [i]     = mudaAlloc(numBodies * sizeof(float), 16);
        invmassMUDA [i]  = mudaAlloc(numBodies * sizeof(float), 16);
    }


    for (i = 0; i < numBodies; i++) {
        for (j = 0; j < 3; j++) {

            posRef[0][j][i]  = rand() / (float)RAND_MAX * 2.0f - 1.0f;
            posRef[1][j][i]  = rand() / (float)RAND_MAX * 2.0f - 1.0f;
            velRef[0][j][i]  = rand() / (float)RAND_MAX * 2.0f - 1.0f;
            velRef[1][j][i]  = rand() / (float)RAND_MAX * 2.0f - 1.0f;
            forceRef [j][i]  = rand() / (float)RAND_MAX * 2.0f - 1.0f;

            posMUDA[0][j][i] = rand() / (float)RAND_MAX * 2.0f - 1.0f;
            posMUDA[1][j][i] = rand() / (float)RAND_MAX * 2.0f - 1.0f;
            velMUDA[0][j][i] = rand() / (float)RAND_MAX * 2.0f - 1.0f;
            velMUDA[1][j][i] = rand() / (float)RAND_MAX * 2.0f - 1.0f;
            forceRef  [j][i] = rand() / (float)RAND_MAX * 2.0f - 1.0f;
        }
    }
}

#if 0
void compareResults(bool regression, int numBodies)
{
    nbodyCUDA->update(0.001f);

    // check result
    if(regression) 
    {
        // write file for regression test
        CUT_SAFE_CALL( cutWriteFilef( "./data/regression.dat",
            nbodyCUDA->getArray(BodySystem::BODYSYSTEM_POSITION), 
            numBodies, 0.0));
    }
    else
    {
        nbodyCPU = new BodySystemCPU(numBodies);

        nbodyCPU->setArray(BodySystem::BODYSYSTEM_POSITION, hPos);
        nbodyCPU->setArray(BodySystem::BODYSYSTEM_VELOCITY, hVel);

        nbodyCPU->update(0.001f);

        float* cudaPos = nbodyCUDA->getArray(BodySystem::BODYSYSTEM_POSITION);
        float* cpuPos  = nbodyCPU->getArray(BodySystem::BODYSYSTEM_POSITION);

        // custom output handling when no regression test running
        // in this case check if the result is equivalent to the expected 
	    // solution
        CUTBoolean res = cutComparefe( cpuPos, cudaPos, numBodies, .001f);
        printf( "Test %s\n", (1 == res) ? "PASSED" : "FAILED");
    }
}
#endif

void runBenchmark(int iterations)
{

#if 1
    computeRef(
        forceRef[0],
        forceRef[1],
        forceRef[2],
        posRef[0][0],
        posRef[0][1],
        posRef[0][2],
        velRefPosRef[0][2],
    float *mass,
    const unsigned int numBodies,
    float softeningSquared) 
#endif
    
#if 0
    float milliseconds = cutGetTimerValue(timer);
    double interactionsPerSecond = 0;
    double gflops = 0;
    computePerfStats(interactionsPerSecond, gflops, milliseconds, iterations);
    
    printf("%d bodies, total time for %d iterations: %0.3f ms\n", 
           numBodies, iterations, milliseconds);
    printf("= %0.3f billion interactions per second\n", interactionsPerSecond);
    printf("= %0.3f GFLOP/s at %d flops per interaction\n", gflops, 20);   
#endif
}


//////////////////////////////////////////////////////////////////////////////
// Program main
//////////////////////////////////////////////////////////////////////////////
int
main( int argc, char** argv) 
{

    init(numBodies);

    runBenchmark(numIterations);

    return 0;
}
