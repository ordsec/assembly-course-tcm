;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; How loops work ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;

; Well, it's simple really: a loop is a chunk of code
; that executes repeatedly until a certain condition is met.
; Thinking of it in terms of assembly, the condition can be
; a comparison of a value against some other value, and 
; we can simply keep jumping to the beginning of a chunk of 
; code until the comparison sets necessary flags that will
; break us out of the loop.

; First, a very basic example

; start:
; mov CX, 0x05                ; set up CX as the iterator
;                             ; starting at 5

; ; in our loop, we're gonna print the value of CX
; start_loop:                 
; mov AL, CL
; add AL, 0x30                ; convert to ASCII for the printing
; mov AH, 0xa                 ; int 0x10 subfunction to print
;                             ; the contents of AL (single char)
; int 0x10                    ; this will print "5" five times
;                             ; because int 0x10 uses CX to know
;                             ; how many characters to print

; So we can't really do much with the ghetto approach above
; because this is just a single character and we're using 
; int 0x10's native functionality to do the looping. Additionally,
; since CX is used as the iterator AND as the number of times
; something should be printed, we need to comehow decouple this
; to make more customizable loops. The stack comes in handy here.

; The following is a manual approach to looping. This is a `for`
; loop, which means we're using an iterator, which is set to
; a value that is either incremented or decremented until
; it hits a certain value - at which point we exit the loop.
; For the iterator, CX is normally used.

start:
mov CX, 0x05                ; this is the iterator
mov AH, 0xa                 ; set up for int 0x10

; This loop will print numbers from 5 to 1. This is the same as
; for (i = 5; i > 0; i--) { print(i); }
start_loop:
mov AL, CL                  ; AL <- current value to print
add AL, 0x30                ; convert AL to ASCII
push CX                     ; iterator -> stack
mov CX, 0x1                 ; CX <- how many characters to print
int 0x10
pop CX                      ; CX <- iterator
dec CX                      ; iterator - 1

; This is the condition. As long as CX isn't 0, we keep looping
cmp CX, 0x00                
jne start_loop

; The dec CX -- cmp CX, <value> -- jne pattern can be replaced with
; a shorthand instruction:

; loop start_loop

; This only works for decrementing, so for the opposite we should
; still use the manual approach.