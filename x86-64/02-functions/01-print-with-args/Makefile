# THIS IS A BOILERPLATE! 
# Change SOURCEFILE, OBJFILE, and BINARY values 
# to the desired filenames.

02-objfile.o: 02-src.s
	as -g -o 02-objfile.o 02-src.s

print-with-args: 02-objfile.o
	gcc -o print-with-args 02-objfile.o
	rm -f 02-objfile.o

all: 02-objfile.o print-with-args

clean: 
	rm -f print-with-args