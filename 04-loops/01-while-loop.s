;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; Writing a `while` loop ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Number guesser, but with a loop. 

start:

start_loop:
mov AH, 0x1                 ; int 0x21 subfunction to accept 1 char from stdin
int 0x21
cmp AL, 0x35                ; does the entered number equal 5?
jne start_loop              ; if not, go back to the beginning