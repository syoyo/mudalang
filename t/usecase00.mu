//
// SIMD Ray-triangle intersection code.
//

struct ray4
{

    vec rox;
    vec roy;
    vec roz;

    vec rdx;
    vec rdy;
    vec rdz;

};   // DO NOT forget to add ";" after struct definition!


//
// Setup functions
//
void setupRay4(
    out ray4    ray,
    array float rox,
    array float roy,
    array float roz,
    array float rdx,
    array float rdy,
    array float rdz,
    float       nOver4)
{

    vec i = 0.0;

    while (i < nOver4) {

        ray.rox = vec(rox[ftoi(i + 0.0)], rox[1], rox[2], rox[3]);

        i = i + 1.0;

    }

    return; 
}

