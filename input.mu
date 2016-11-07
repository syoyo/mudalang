
void ray_aabb(
    dvec rayorg,        // xyz
    dvec raydir,        // xyz
    dvec rayinvdir,     // xyz
    dvec bmin,          // xyz
    dvec bmax)          // xyz
{
    dvec vzero = dvec(0.0);

    dvec raysign = raydir < vzero;

    dvec minval = sel(bmin, bmax, raysign);
    dvec maxval = sel(bmax, bmin, raysign);

    dvec tmin, tmax;

    tmin = (minval - rayorg) * rayinvdir;
    tmax = (maxval - rayorg) * rayinvdir;

    // Find max value in (tmin.x, tmin.y, tmin.z)
    // Find min value in (tmax.x, tmax.y, tmax.z)
    dvec tmin_max = max(tmin.xxxx, max(tmin.yyyy, tmin.zzzz));
    dvec tmax_min = min(tmax.xxxx, min(tmax.yyyy, tmax.zzzz));
    

}

