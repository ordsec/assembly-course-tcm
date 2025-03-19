# THIS IS A BOILERPLATE! 
# Change SOURCEFILE, OBJFILE, and BINARY values 
# to the desired filenames.

03-objfile.o: 03-src.s
	as -g -o 03-objfile.o 03-src.s

print-with-args: 03-objfile.o
	gcc -o print-with-args 03-objfile.o
	rm -f 03-objfile.o

all: 03-objfile.o print-with-args

clean: 
	rm -f print-with-args