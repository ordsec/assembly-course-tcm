# THIS IS A BOILERPLATE! 
# Change SOURCEFILE, OBJFILE, and BINARY values 
# to the desired filenames.

01-objfile.o: 01-src.s
	as -g -o 01-objfile.o 01-src.s

print-with-args: 01-objfile.o
	gcc -o print-with-args 01-objfile.o
	rm -f 01-objfile.o

all: 01-objfile.o print-with-args

clean: 
	rm -f print-with-args