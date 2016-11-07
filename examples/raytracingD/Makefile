MUDAH=../../mudah

CFLAGS = -O2 -g -I. -I../../include -mavx
LDFLAGS = -L../../libmuda

CC=gcc-4.5

all:
	$(CC) $(CFLAGS) -o main.o -c main.c
	$(CC) $(CFLAGS) -o isect.o -c isect.c
	$(CC) -g -o render isect.o main.o $(LDFLAGS) -lmuda


gen:
	$(MUDAH) --avx isect.mu > isect.c
	gcc-avx $(CFLAGS) -S isect.c
	yasm -f elf -p gas isect.s -o isect.o


