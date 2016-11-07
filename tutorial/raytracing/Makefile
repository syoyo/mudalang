MUDAMU = isect.mu
MUDAC  = $(MUDAMU:.mu=.c)

SRCS   = main.c $(MUDAC)
OBJS   = $(SRCS:.c=.o)

CC = gcc

CFLAGS += -msse2
CFLAGS += -I.
CFLAGS += -g
CFLAGS += -I../../include

LDFLAGS += -L../../libmuda
LIBS    += -lmuda

all: $(OBJS)
	$(CC) -o rayt $(CFLAGS) $(OBJS) $(LDFLAGS) $(LIBS)


gen:
	../../mudah --sse $(MUDAMU) > $(MUDAC)

$(MUDAC): $(MUDAMU)
	$(MAKE) gen	

.c.o:
	$(CC) $(CFLAGS) -c $<

