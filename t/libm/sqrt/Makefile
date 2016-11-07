.PHONY: gen clean all

OPTFLAG = -O2

all: gen
	
	gcc -I. -I../../../include -I../../../libmuda $(OPTFLAG)  -msse2 test_sqrtmu.c -lm

gen:
	# get mudaintrin_sse.h
	../../../mudah dummy.mu > /dev/null
	python ./gen.py



