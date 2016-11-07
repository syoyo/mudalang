SRCS = main.c layout.c
OBJS = $(SRCS:.c=.o)

CC = gcc

CFLAGS += -msse2 -O3
CFLAGS += -I.
CFLAGS += -I../../include

LDFLAGS += -L../../libmuda
LIBS    += -lmuda

all: $(OBJS)
	$(CC) -o layout $(OBJS) $(LDFLAGS) $(LIBS)


gen:
	../../mudah --sse layout.mu > layout.c

clean:
	rm -rf $(OBJS) layout.c

layout.c: layout.mu
	$(MAKE) gen	

main.o: layout.o

.c.o:
	$(CC) $(CFLAGS) -c $<
