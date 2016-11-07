static void bodyBodyInteraction(
	out vec ai_x,
	out vec ai_y,
	out vec ai_z,
	vec bi_x,
	vec bi_y,
	vec bi_z,
	vec bj_x,
	vec bj_y,
	vec bj_z,
	vec bj_w,
	vec softheningSquared)
{
	vec r_x, r_y, r_z;

	// [4 x 3 flops]
	r_x = bi_x - bj_x;
	r_y = bi_y - bj_y;
	r_z = bi_z - bj_z;

	vec distSqr;

	// [4 x 6 flops] 
	distSqr = r_x * r_x + r_y * r_y + r_z * r_z + softheningSquared;

	// [4 x 4 flops]
	vec invDist = rsqrt(distSqr);
	vec invDistCube = invDist * invDist * invDist;

	// [4 x 1 flops]
	vec s = bj_w  * invDistCube;

	// [4 x 6 flops]
	ai_x = ai_x + r_x * s;
	ai_y = ai_y + r_y * s;
	ai_z = ai_z + r_z * s;

	// 80 flops total.
}

void computeMUDA(
    out array vec force_x,
    out array vec force_y,
    out array vec force_z,
    array vec     pos_x,
    array vec     pos_y,
    array vec     pos_z,
    array vec     mass,
    array vec     invmass,

    array vec     next_pos_x,
    array vec     next_pos_y,
    array vec     next_pos_z,
    array vec     next_mass,

    array vec     next_vel_x,
    array vec     next_vel_y,
    array vec     next_vel_z,
    array vec     next_invmass,

    int           numBodies4,
    vec           softeningSquared,
    vec           delta_time,
    vec           damping)
{
    int i, j;

    vec acc_x, acc_y, acc_z;

    i = 0;
    while (i < numBodies4) {
        force_x[i] = 0.0;
        force_y[i] = 0.0;
        force_z[i] = 0.0;
    }

    i = 0;
    while (i < numBodies4) {
        
        j = 0;
        while (j < numBodies4) {

            bodyBodyInteraction(
                acc_x,
                acc_y,
                acc_z,
                pos_x[j],
                pos_y[j],
                pos_z[j],
                pos_x[i],
                pos_y[i],
                pos_z[i],
                mass[i],
                softeningSquared);

            force_x[i] = force_x[i] + acc_x;
            force_y[i] = force_y[i] + acc_y;
            force_z[i] = force_z[i] + acc_z;
        }
    
    }

    //
    // Integrate
    //
    vec v_x, v_y, v_z;
    vec p_x, p_y, p_z;

    i = 0;
    while (i < numBodies4) {

        v_x = (force_x[i] * invmass[i]) * delta_time * damping;
        v_y = (force_y[i] * invmass[i]) * delta_time * damping;
        v_z = (force_z[i] * invmass[i]) * delta_time * damping;

        p_x = pos_x[i] + v_x * delta_time;
        p_y = pos_y[i] + v_y * delta_time;
        p_z = pos_z[i] + v_z * delta_time;

        next_pos_x[i] = p_x;
        next_pos_y[i] = p_y;
        next_pos_z[i] = p_z;
        next_mass [i] = mass[i];

        next_vel_x  [i] = v_x;
        next_vel_y  [i] = v_y;
        next_vel_z  [i] = v_z;
        next_invmass[i] = invmass[i];
        
    }

}
