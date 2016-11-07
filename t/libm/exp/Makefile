.PHONY: gen clean all

FUNCNAME=exp

all: gen
	
	gcc -I. -I../../../libmuda -I../../../include -O2  -msse2 test_$(FUNCNAME)mu.c -lm

gen:
	# get mudaintrin_sse.h
	../../../mudah dummy.mu > /dev/null
	python ./gen.py


run:
	./a.out

