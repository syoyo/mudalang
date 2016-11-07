MUDAH = ../../mudah
CC    = gcc-4.2.1
CXX   = llvm-g++

SDL_CFLAGS = `sdl-config --cflags`
SDL_LIBS   = `sdl-config --libs`

ENABLE_SDL = 1
# ENABLE_SDL = 0
DEFS  = 
# DEFS  =  -DPERF

CFLAGS = -ffast-math -msse2 -g -O3

ifeq ($(ENABLE_SDL), 1)
 
  DEFS     = -DUSE_SDL
  CFLAGS  += $(SDL_CFLAGS)
  MY_LIBS += $(SDL_LIBS) -framework OpenGL

endif

all:
	$(MAKE) mnoise
	$(MAKE) snoise
	$(MAKE) mnoise_cpu
	$(MAKE) pnoise

mnoise: modifiednoise.c mmain.c
	$(CC) $(DEFS) $(SDL_CFLAGS) $(CFLAGS) -c  -I../../include -I. mmain.c
	$(CC) $(DEFS) $(SDL_CFLAGS) $(CFLAGS) -c -I../../include -I. modifiednoise.c
	$(CC) $(DEFS) $(CFLAGS) -o mnoise -msse2 -I../../include -I. mmain.o modifiednoise.o -L../../libmuda -lmuda $(MY_LIBS)

snoise: snoise_cpu.c snoise.c smain.c
	$(CC) $(DEFS) $(SDL_CFLAGS) $(CFLAGS) -c  -I../../include -I. smain.c
	$(CC) $(DEFS) $(SDL_CFLAGS) $(CFLAGS) -c  -I../../include -I. snoise.c
	$(CC) $(DEFS) $(SDL_CFLAGS) $(CFLAGS) -c -I../../include -I. snoise_cpu.c
	$(CC) $(DEFS) $(CFLAGS) -o snoise -msse2 -I../../include -I. smain.o snoise.o snoise_cpu.o -L../../libmuda -lmuda $(MY_LIBS) -lm


modifiednoise.c: modifiednoise.mu
	$(MUDAH) --sse $< > $@

snoise.c: snoise.mu
	$(MUDAH) --sse $< > $@

mnoise_cpu: mnoise_cpu.c mnoise.c
	$(CC) $(DEFS) -ffast-math -m64 -msse2 -mfpmath=sse -o mnoise_cpu -O3 mnoise_cpu.c mnoise.c

pnoise: noise1234.cpp pmain.cpp
	$(CXX) $(DEFS) $(SDL_CFLAGS) $(CFLAGS) -o pnoise noise1234.cpp pmain.cpp $(MY_LIBS)



clean:
	rm -rf mnoise mnoise_cpu pnoise snoise
