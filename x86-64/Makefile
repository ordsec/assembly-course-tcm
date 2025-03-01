# THIS IS A BOILERPLATE! 
# Change SOURCEFILE, OBJFILE, and BINARY values 
# to the desired filenames.

OBJFILE.o: SOURCEFILE.s
	as -g -o OBJFILE.o SOURCEFILE.s

BINARY: OBJFILE.o
	gcc -o BINARY OBJFILE.o
	rm -f OBJFILE.o

all: OBJFILE.o BINARY

clean: 
	rm -f BINARY