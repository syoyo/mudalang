.PHONY: gen clean all

all: gen
	
#	gcc -I../../../libmuda -O2  -msse2 cosmu.c test_cosmu.c -lm
	gcc -I../../../libmuda -g  -msse2 cosmu.c test_cosmu.c -lm

gen:
	../../../mudah ../../../libm/cos.mu > cosmu.c
	python ./gen.py



