all:
	# gcc -msse2 -g -c -I../../include -I. nbody_muda.c
	gcc -msse2 -g -c -I../../include -I. nbody_kernel.c
	gcc -g -I../../include nbody.c nbody_ref.c -L../../libmuda -lmuda -lm

gen:
	../../mudah --sse nbody_kernel.mu > nbody_kernel.c
