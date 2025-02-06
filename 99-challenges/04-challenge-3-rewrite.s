; The program should ask the user to input a number from 0-9,
; then it should output this number on the screen. 
; The output should be: "The number you have entered is: <number>"
; (in one line, printed with one interrupt).
; No sanity checks just yet, we're trusting the user... :D

; Additional condition: no hard-coding string lengths,
; i.e. they have to be calculated dynamically.

;-----------------------------------------------------------------

; Set up the labels, load strings into memory
string1: db "Please enter a number (0-9): "
string2: db "The number you have entered is: "
number: db 0xff                                     ; 0xff is a placeholder

start:

;;;;; Prompt for user input
mov AH, 0x13                            ; int 0x10 subfunction to print multiple chars
mov CX, offset string2                  ; CX <- memory offset of where string2 starts
sub CX, offset string1                  ; CX - the offset where string1 starts = 
                                        ; = how many characters to print for string1

; This prep is not entirely necessary as we're already at the beginning of the 0x00000
; part of the DS, but being explicit is better in assembly.
mov BX, 0                               
mov ES, BX                              ; ES starts at 0x00000
mov BP, offset string1                  ; BP is at the beginning of string1 (0x00 in this case)
int 0x10

;;;;; Accept user input
xor AH, AH
mov AH, 0x01                            ; int 0x21 subfunction to accept a single char
int 0x21                                ; The char that is entered is stored in AL
mov byte [offset number], AL            ; Store it in memory where `number` is

;;;;; Output the resulting string
xor AH, AH
mov AH, 0x13
mov CX, offset number                   ; The number is in memory immediately after string2.
sub CX, offset string2                  ; CX - the offset where string2 starts = 
                                        ; = length of string2
add CX, 1                               ; Extra character to print for the number
mov BX, 0                               ; Prep and print starting from the beginning of string2
mov ES, BX
mov BP, offset string2
int 0x10