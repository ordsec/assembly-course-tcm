; ---------------------------------------------------
; ;;;;;;;;;;;;;;; Number guesser v2! ;;;;;;;;;;;;;;;;
; - Hardcode a number between 0-9
; - Hardcode a number of guesses
; - Print a welcome message (only once)
; - Ask the user to enter a number between 0-9 
; - If it's correct, say it's correct and exit
; - If it's within 1, say "Close but not quite..."
; - Otherwise, print "That's not it."
; - Until the number is guessed right or the number of
;   guesses runs out:
;   - Print "Try again. Number of guesses left: N"
;     where N is added to the end of the string
; - When no more guesses are left, print a goodbye
;   message and exit.
; ---------------------------------------------------

number:         db 0x07
welcome:        db "I'm thinking of a number, can you guess it?"
welcomenull:    db 0x00
prompt:         db "Please enter a number between 0-9: "
promptnull:     db 0x00
msg1:           db "You're a mind reader, that's correct!"
msg1null:       db 0x00
msg2:           db "Close but not quite..."
msg2null:       db 0x00
msg3:           db "That's not it son."
msg3null:       db 0x00
msg4:           db "Try again. Number of guesses left: "
num_guesses:    db 0x33             ; in ascii!
msg4null:       db 0x00
msg5:           db "You're out of guesses, better luck next time!"
msg5null:       db 0x00

start:

; the loop
; for (i = 3, i > 0, i--) {
;     get_input();
;     if (AL == number) {
;         print(msg1);
;         exit;
;     } else if (AL == number + 1 || AL == number - 1) {
;         print(msg2);
;         print(msg4);
;     } else {
;         print(msg3);
;         print(msg4);
;     }
; }

; print the welcome message
mov AH, 0x13
mov CX, offset welcomenull
sub CX, offset welcome
mov BP, offset welcome
int 0x10

mov CL, byte [offset num_guesses]
sub CL, 0x30            ; get the actual number

guess_loop:
push CX                 ; iterator -> stack

; print the prompt
xor AH, AH
mov AH, 0x13
mov CX, offset promptnull
sub CX, offset prompt
mov BP, offset prompt
int 0x10

; get user input
xor AH, AH
mov AH, 0x1
int 0x21

sub AL, 0x30            ; convert user input to ascii

; run checks
cmp AL, byte [offset number]

; if correct
je printmsg1

; if within 1
sub AL, 1
cmp AL, byte [offset number]
je printmsg2
add AL, 2
cmp AL, byte [offset number]
je printmsg2

; if incorrect, print "that's not it"
xor AH, AH
mov AH, 0x13
mov CX, offset msg3null
sub CX, offset msg3
mov BP, offset msg3
int 0x10
jmp try_again

; print "you're close"
printmsg2:
xor AH, AH
mov AH, 0x13
mov CX, offset msg2null
sub CX, offset msg2
mov BP, offset msg2
int 0x10

; print "try again"
try_again:
pop CX
dec CX
cmp CX, 0x00
je printmsg5

push CX

dec byte [offset num_guesses]
xor AH, AH
mov AH, 0x13
mov CX, offset msg4null
sub CX, offset msg4
mov BP, offset msg4
int 0x10

; decrement the iterator, loop around
; pop CX
; dec CX
; cmp CX, 0x00
jmp guess_loop

; print "you're out of attempts"
; we only get here if the iterator in the loop
; gets down to zero (never got the right guess)
printmsg5:
xor AH, AH
mov AH, 0x13
mov CX, offset msg5null
sub CX, offset msg5
mov BP, offset msg5
jmp end

; print correct guess msg
printmsg1:
xor AH, AH
mov AH, 0x13
mov CX, offset msg1null
sub CX, offset msg1
mov BP, offset msg1
int 0x10

end:
xor AX, AX