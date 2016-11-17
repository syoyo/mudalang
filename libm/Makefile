SRCS  = exp.mu sqrt.mu log.mu
MUDAH = ../mudah

all:
	$(MAKE) sse
	$(MAKE) neon

sse:
	@rm -rf mudamath_sse.h
	@touch mudamath_sse.h
	@for f in $(SRCS); do \
	  echo "Translating $$f ..."; \
	  $(MUDAH) --sse --noheader --nointrinheader $$f >> mudamath_sse.h; \
	done
	@mv mudamath_sse.h ../include
	@echo "Emitted mudamath_sse.h to ../include"
	
neon:
	@rm -rf mudamath_neon.h
	@touch mudamath_neon.h
	@for f in $(SRCS); do \
	  echo "Translating $$f ..."; \
	  $(MUDAH) --neon --noheader --nointrinheader $$f >> mudamath_neon.h; \
	done
	@mv mudamath_neon.h ../include
	@echo "Emitted mudamath_neon.h to ../include"
	
