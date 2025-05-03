# Commands:

build: 
	ghc --make -O -o war Main.hs

prof:
	ghc --make -prof -o war Main.hs

all: build test

# Cleaning commands:
clean:
	rm -f war
	rm -f *.hi
	rm -f *.o