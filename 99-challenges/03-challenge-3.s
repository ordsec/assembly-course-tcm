; The program should ask the user to input a number from 0-9,
; then it should output this number on the screen. 
; The output should be: "The number you have entered is: <number>"
; (in one line, printed with one interrupt).
; No sanity checks just yet, we're trusting the user... :D

prompt: db "Please enter a number (0-9): "      ; 29 characters
result: db "The number you have entered is: "   ; 32 characters
number: db 0xff                                 ; 1 more character for the number

start:

; Prompt for user input
mov AH, 0x13                    ; Subfunction for output via int 0x10
mov CX, 29                      ; How many characters to print
int 0x10

; Accept user input
xor AH, AH
mov AH, 0x01                    ; Subfunction for accepting one char via int 0x21
int 0x21                        ; Accept user input
mov byte [offset number], AL    ; Store the number in memory

; Final output
xor AH, AH
mov AH, 0x13
mov CX, 33                      ; Print the result plus the number character
mov BP, offset result           ; Shift BP to where the result string begins
int 0x10