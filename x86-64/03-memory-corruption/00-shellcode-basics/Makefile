# THIS IS A BOILERPLATE! 
# Change SOURCEFILE, OBJFILE, and BINARY values 
# to the desired filenames.

00-objfile.o: 00-src.s
	as -g -o 00-objfile.o 00-src.s

shellcode: 00-objfile.o
	ld -e _start -o shellcode 00-objfile.o
	rm -f 00-objfile.o

all: 00-objfile.o shellcode

clean: 
	rm -f shellcode