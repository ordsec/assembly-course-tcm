;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; Hello, world! Finally... ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; As a recap, to print a single char we need three things:
; Prepare the subfunction of 0x0a for int 0x10 to know that a single char is to be printed
; Move the char to be printed into AL
; Set the number of times the char is to be printed in CX
; Printing a string works this way, but we'd have to loop around to keep 
; moving the next char to print into AL. This is too tedious.
; Here's how to print a string using the 0x13A subfunction of int 0x10

set 0x1000
hellostring: db "Hello, world!"         ; Store what we're printing in memory

start:
mov AH, 0x13                            ; Set the correct subfunction for int 0x10
mov CX, 13                              ; The number of characters to print - we're 
                                        ; hardcoding it now, but there's a dynamic way.

; Now we need to tell the assembler where in memory the string actually starts. 
; This is done using ES (extra segment) and BP (the base pointer). 
; Think of the memory as a grid. ES holds the row from whence we start, BP holds the 
; exact column, i.e. how far along into the row we're starting from.
; ES does not need to be set if the string to print is between 0x00000 and 0x0FFFF

; ES can only be set from a register, not directly with an immediate:
mov BX, 0x1000
mov ES, BX

; BP can be set with a mov, but the better way is to do it dynamically,
; referencing the offset of where hellostring starts. The assembler will
; calculate the starting address on its own!
; Worth mentioning that the offset is NOT the same as an address. The offset
; is a relative value that specifies the DISTANCE between two addresses.
; So in this case, BP needs to travel 0 bytes from the beginning of hellostring,
; so the offset, while addressed dynamically, is in this case zero.
; If we needed to start printing from somewhere in the middle of the string,
; we could hard-code the offset value (there are better ways), such as
; mov BP, 7, which would shift BP by 7 bytes and print 'world!'
mov BP, OFFSET hellostring

; Make the syscall to print using the 0x10 interrupt
int 0x10