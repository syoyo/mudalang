CC  = llvm-gcc

OPTFLAGS   = -g -m64 -msse2 -O3 -ffast-math -mfpmath=sse

MY_INCS    = -I../include -I.
MY_LDFLAGS = -L../libmuda 

TARGET = mudabench
SRCS   = BlackScholesReference.c BlackScholesMUDA.c main.c
OBJS   = ${SRCS:.c=.o}

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) $(OPTFLAGS) -o $(TARGET) $(OBJS) $(MY_LDFLAGS) -lmuda -lm

.c.o:
	$(CC)  $(OPTFLAGS) -c $(MY_INCS) $<

gen:
	../mudah BlackScholesMUDA.mu > BlackScholesMUDA.c

clean:
	rm -rf $(TARGET) $(OBJS)
