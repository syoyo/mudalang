//
// MUDA tutorial 1
//
//   Do simple addition.
//
// How to compile.
//
//   $ mudah tutorial1.mu > tutorial1.c
//   $ gcc -msse2 -c tutorial1.c
//
vec add_func(vec a, vec b)
{
	return a + b;
}
