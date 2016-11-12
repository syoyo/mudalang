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
void add_func(out vec c, vec a, vec b)
{
	c = a + b;
}
