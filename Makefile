.PHONY: doc clean

all:
	ghc -o mudah --make Main.hs
#	ghc -o bora --make IR.hs

gen:
	bnfc MUDA.cf
	alex LexMUDA.x
	happy ParMUDA.y

test:
	(cd t; $(MAKE))

example:
	(cd examples; $(MAKE))

doc:
	(cd doc; $(MAKE))

clean:
	rm -rf *.o
	(cd examples; $(MAKE) clean)
	(cd t; $(MAKE) clean)


