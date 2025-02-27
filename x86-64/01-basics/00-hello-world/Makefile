syscall_helloworld.o: 00-write-syscall.s
	as -g -o syscall_helloworld.o 00-write-syscall.s

syscall_helloworld: syscall_helloworld.o
	gcc -o syscall_helloworld syscall_helloworld.o
	rm -f syscall_helloworld.o

all: syscall_helloworld syscall_helloworld.o