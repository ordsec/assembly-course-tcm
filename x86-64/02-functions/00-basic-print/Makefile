# THIS IS A BOILERPLATE! 
# Change SOURCEFILE, OBJFILE, and BINARY values 
# to the desired filenames.

00-objfile.o: 00-src.s
	as -g -o 00-objfile.o 00-src.s

print-with-func: 00-objfile.o
	gcc -o print-with-func 00-objfile.o
	rm -f 00-objfile.o

all: 00-objfile.o print-with-func

clean: 
	rm -f print-with-func