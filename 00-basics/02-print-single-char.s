; Printing out "H" on the screen, demonstrating interrupts (a legacy way to make syscalls)

start:
mov AH, 0x0a        ; Set up AX with hex 0a for int 0x10 to print a single char
mov AL, 0x48        ; "H" is ASCII 72 decimal, or 48h
mov CX, 0x1         ; Specify the number of times "H" is to be printed
int 0x10            ; Interrupt to print a single char