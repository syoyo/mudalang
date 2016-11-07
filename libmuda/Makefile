CFLAGS =
CFLAGS += -msse2

OPTFLAGS = -O2 -g

ENABLE_64BIT = 0

ifeq ($(ENABLE_64BIT), 1)

  OPTFLAGS += -m64

endif

all:
	gcc $(OPTFLAGS) $(CFLAGS) -c -I../include muda.c
	ar rcu libmuda.a muda.o	
