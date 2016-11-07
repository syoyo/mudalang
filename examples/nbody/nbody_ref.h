#ifndef NBODY_REF_H
#define NBODY_REF_H

#ifdef __cplusplus
extern "C" {
#endif

extern void
computeRef(
    float *force_x,
    float *force_y,
    float *force_z,
    float *pos_x,
    float *pos_y,
    float *pos_z,
    float *mass,
    const unsigned int numBodies,
    float softeningSquared);

#ifdef __cplusplus
}
#endif

#endif  /* NBODY_REF_H */
