; Write a program to store the string "Don't Print This. Print This."
; starting at 0x20000.

; The program should then print out only the "Print This." portion
; of the string.
set 0x2000              ; Set DS to start at 0x20000

string: db "Don't Print This. Print This."

start:
mov AH, 0x13            ; Subfunction to print multiple characters
mov CX, 11              ; The number of characters to print.

mov BX, 0x2000
mov ES, BX              ; Set ES to where in memory the string starts.

mov BP, 18              ; Set BP to the offset where we're actually starting to print
                        ; (i.e. 18 bytes away from the beginning of the string)

int 0x10                ; Interrupt to print on screen