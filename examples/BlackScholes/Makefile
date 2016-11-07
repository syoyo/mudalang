CXX = g++
CC  = gcc

OPTFLAGS   = -g -msse2 -O3 -ffast-math

MY_INCS    = -I../../include -I.
MY_LDFLAGS = -L../../libmuda 

all: gen
	$(CC)  $(OPTFLAGS) -c $(MY_INCS) BlackScholesMUDA.c
	$(CXX) $(OPTFLAGS) -c $(MY_INCS) BlackScholes_gold.cpp	
	$(CXX) $(OPTFLAGS) -c $(MY_INCS) main.cpp	
	$(CXX) $(OPTFLAGS) -o bs main.o BlackScholesMUDA.o BlackScholes_gold.o $(MY_LDFLAGS) -lmuda

gen:
	../../mudah --sse BlackScholesMUDA.mu > BlackScholesMUDA.c
