.PHONY: gen clean all

all: gen
	
	gcc -I../../../libmuda -O2  -msse2 powmu.c test_powmu.c -lm

gen:
	../../../mudah ../../../libm/pow.mu > powmu.c
	python ./gen.py



