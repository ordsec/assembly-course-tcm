# THIS IS A BOILERPLATE! 
# Change SOURCEFILE, OBJFILE, and BINARY values 
# to the desired filenames.

00-objfile.o: 00-src.s
	as -g -o 00-objfile.o 00-src.s

BINARY: 00-objfile.o
	gcc -o BINARY 00-objfile.o
	rm -f 00-objfile.o

all: 00-objfile.o BINARY

clean: 
	rm -f BINARY