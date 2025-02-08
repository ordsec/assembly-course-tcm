; ---------------------------------------------------
; ;;;;;;;;;;;;; Basic number guesser! ;;;;;;;;;;;;;;
; - Hardcode a number between 0-9
; - Ask the user to enter a number between 0-9
; - If it's correct, say it's correct
; - If it's within 1, say "Close but not quite..."
; - Otherwise, say "That's not it."
; ---------------------------------------------------

number:         db 0x07
prompt:         db "I'm thinking of a number, guess it! 0-9: "
promptnull:     db 0x00
msg1:           db "You're a mind reader, that's correct!"
msg1null:       db 0x00
msg2:           db "Close but not quite..."
msg2null:       db 0x00
msg3:           db "That's not it son."
msg3null:       db 0x00

start:

;;;;; Prompt for user input
mov AH, 0x13
mov CX, offset promptnull
sub CX, offset prompt
mov BP, offset prompt
int 0x10

;;;;; Collect user input via int 0x21
xor AH, AH
mov AH, 0x1
int 0x21                            ; Stored in AL

;;;;; Convert it ASCII -> integer
sub AL, 0x30

;;;;; Compare vs stored number
cmp AL, byte [offset number]
je printmsg1

; Is the input within 1 of the stored number?
sub byte [offset number], 1         ; AL == number - 1?
cmp AL, byte [offset number]
je printmsg2
add byte [offset number], 2         ; AL == number + 1?
cmp AL, byte [offset number]
je printmsg2
 
;;;;; Output messages based on comparison

; else case - not equal and too far off
; we'll jump over this in all other cases
xor AH, AH
mov AH, 0x13
mov CX, offset msg3null
sub CX, offset msg3
mov BP, offset msg3
int 0x10
jmp end

; if they're equal
printmsg1:
xor AH, AH
mov AH, 0x13
mov CX, offset msg1null
sub CX, offset msg1
mov BP, offset msg1
int 0x10
jmp end

; if they're within 1
printmsg2:
xor AH, AH
mov AH, 0x13
mov CX, offset msg2null
sub CX, offset msg2
mov BP, offset msg2
int 0x10

; end of the program
end:
xor AX, AX                  ; just set AX to 0