syscall_helloworld.o: 00-echo-hw.s
	as -g -o echo_hello_world.o 00-echo-hw.s

echo_hello_world: echo_hello_world.o
	gcc -o echo_hello_world echo_hello_world.o
	rm -f echo_hello_world.o

all: syscall_helloworld.o echo_hello_world

clean: 
	rm -f echo_hello_world