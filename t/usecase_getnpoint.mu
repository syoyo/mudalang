// n-vertex : farthest vertex from the plane defined by `normal'
//
// Reference:
//
//   - http://www.cescg.org/CESCG-2002/DSykoraJJelinek/index.html

void getNPoint(
    out array vec nV,
    vec bmin,
    vec bmax,
    array vec normal)       // x, y and z
{

    nV[0] = sel(bmin.xxxx, bmax.xxxx, normal[0] > 0.0);
    nV[1] = sel(bmin.yyyy, bmax.yyyy, normal[1] > 0.0); 
    nV[2] = sel(bmin.zzzz, bmax.zzzz, normal[2] > 0.0);

}
