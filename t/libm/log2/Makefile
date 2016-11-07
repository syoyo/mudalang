.PHONY: gen clean all

all: gen
	
	gcc -I. -I../../../include -I../../../libmuda -O2 -msse2 test_log2mu.c -lm

gen:
	../../../mudah dummy.mu > /dev/null
	python ./gen.py

binstat:
	../../../tools/dumpfunc.py a.out log2mu




