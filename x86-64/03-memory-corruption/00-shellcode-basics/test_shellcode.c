#include <stdio.h>
#include <string.h>
#include <sys/mman.h>
#include <unistd.h>

// Basic C program to test shellcode, the program uses mprotect so that DEP doesn't block execution
// Compile with gcc -o test_shell test_shell.c
// TCM Security Assembly 101 - DigitalAndrew

// Shellcode to run goes here in this string
unsigned char shellcode[] = 
"\x48\xb9\x48\x45\x4c\x4c\x4f\x20\x20\x20\x51\x48\x31\xc0\xb0\x01\x48\x89\xc7\x48\x89\xe6\x48\x31\xd2\xb2\x05\x0f\x05"; 

int main() {
    // Get the page size
    size_t page_size = sysconf(_SC_PAGESIZE);

    // Align the shellcode array's memory address to the page boundary
    void *shellcode_page = (void *)((size_t)shellcode & ~(page_size - 1));

    // Mark the memory region as executable
    if (mprotect(shellcode_page, page_size, PROT_READ | PROT_WRITE | PROT_EXEC) != 0) {
        perror("mprotect");
        return 1;
    }

    printf("Shellcode length: %lu bytes\n", strlen(shellcode));

    // Cast the shellcode to a function pointer and execute it
    void (*shellcode_function)() = (void (*)())shellcode;
    shellcode_function();

    return 0;
}