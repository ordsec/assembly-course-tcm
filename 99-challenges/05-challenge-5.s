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

;;;;; Add all data to memory (number, strings)
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

;;;;; Print the welcome message
mov AH, 0x13                ; int 0x10 subfunction for multiple char
mov CX, offset welcomenull
sub CX, offset welcome
mov BP, offset welcome
int 0x10

;;;;; Loop starts here
guess_loop:
mov CL, byte [offset num_guesses]
sub CL, 0x30                ; get the actual number
push CX                     ; iterator -> stack

;;;;; Print the prompt
xor AH, AH
mov AH, 0x13
mov CX, offset promptnull
sub CX, offset prompt
mov BP, offset prompt
int 0x10

;;;;; Get user input
xor AH, AH
mov AH, 0x1
int 0x21

sub AL, 0x30            ; convert user input to ascii

;;;;; Run checks
cmp AL, byte [offset number]

; If the guess is correct, get out of the loop
je printmsg1

; If we're within 1, jump to the corresponding
; message within the loop
mov BH, byte [offset number]
mov BL, byte [offset number]
add BH, 1
sub BL, 1
cmp AL, BH
je printmsg2
cmp AL, BL
je printmsg2

; Else, the guess is too far off
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
xor DX, DX              ; avoid unwanted whitespace
mov AH, 0x13
mov CX, offset msg2null
sub CX, offset msg2
mov BP, offset msg2
int 0x10

;;;;; We'll get here if the answer is incorrect
try_again:
pop CX                  ; pop the iterator from the stack
dec CX                  ; decrement it since we're thru 1 cycle
cmp CX, 0x00            ; if it's zero, get out of the loop
je printmsg5

;;;;; Output the number of guesses left
; num_guesses gets decremented at this point because we've
; already taken at least one guess. This is NOT the iterator,
; rather it's the number that we'll use to tell the user
; how many attempts are left. The loop does not depend on this value
dec byte [offset num_guesses]
xor AH, AH
mov AH, 0x13
mov CX, offset msg4null
sub CX, offset msg4
mov BP, offset msg4
int 0x10

; We'll only get here if we haven't broken out of the loop
; for some reason.
jmp guess_loop          

;;;;; Print "you're out of attempts"
; We only get here if the iterator in the loop
; gets down to zero (never got the right guess)
printmsg5:
xor AH, AH
mov AH, 0x13
mov CX, offset msg5null
sub CX, offset msg5
mov BP, offset msg5
int 0x10
jmp end

;;;;; Jump here if the guess is correct
printmsg1:
xor AH, AH
mov AH, 0x13
mov CX, offset msg1null
sub CX, offset msg1
mov BP, offset msg1
int 0x10

end:
xor AX, AX