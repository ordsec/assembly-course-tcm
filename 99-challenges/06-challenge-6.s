; ------------------------------------------
; ;;;;;;;;;;;;; Adding numbers ;;;;;;;;;;;;;
; - Ask the user for two inputs between
;   0 and 9999
; - Accept the two inputs
; - Add the two inputs together
;   >>> Remember that they're first stored
;       in ASCII!
; ;;;;;;;;; Unsolved :( code from video
;-------------------------------------------

;;;;; Store the necessary data
value1: db 0x04 db [0x00, 0x05] ; buffers for the two user inputs
value2: db 0x04 db [0x00, 0x05]
greeting: db "I can add any two numbers from 0-9999!"
prompt1: db "Gimme a number (0-9999): "
prompt2: db "Gimme another number (0-9999): "
null: db 0x0
sum: dw 0x0000                  ; important! sum is in hex
                                ; and we need a word to store it

start:

;;;;; Print the greeting
mov AH, 0x13
mov CX, offset prompt1
sub CX, offset greeting
mov BP, offset greeting
int 0x10

;;;;; Print the first message
xor AH, AH
mov AH, 0x13
mov CX, offset prompt2
sub CX, offset prompt1
mov BP, offset prompt1
int 0x10

;;;;; Accept the first value
xor AH, AH
mov AH, 0xa
mov DX, offset value1
int 0x21

;;;;; Print the second message
xor AH, AH
mov AH, 0x13
mov CX, offset null
sub CX, offset prompt2
mov BP, offset prompt2
int 0x10

;;;;; Accept the second value
xor AH, AH
mov AH, 0xa
mov DX, offset value2
int 0x21

;;;;; Convert value 1 contents from ASCII
;     to raw number, add them to the sum

; For instance, if the user entered 4321, the ASCII is
; 0x34, 0x33, 0x32, 0x31. 
; 1. Subtract 0x30 from each byte
; 2. 4000 + 300 + 20 + 1
; 3. 4*10^3 + 3*10^2 + 2*10^1 + 1*10^0
; There's no exponent in 8086, but we can replicate it
; using multiplication.

; To do this, we need two loops. 
; The outer loop will convert ASCII to numbers. 
; The inner loop will perform the actual multiplication.

;;;;; Process the first value
mov BL, offset value1               ; Grab the first value's address
mov CL, byte [BX, 1]                ; We need its second byte as that's the
                                    ; actual length of value1. This is the iterator
mov SI, offset value1               ; SI -> the beginning of value1 for lods
add SI, 0x02                        ; (shift 2 bytes forward)

; The outer loop
convert_to_decimal_1:
lods byte                           ; Load the byte into AL
sub AL, 0x30                        ; ASCII to raw
push CX                             ; Preserve CX for outer loop because 
                                    ; there will be another counter for inner loop
dec CX                              ; Counter needs to decrement to account for
                                    ; the first number being in 0 position (N^3).
                                    ; In other words, we're starting with len(N)-1
xor AH, AH                          ; Empty out AH for the math
mov BX, AX                          ; AX -> BX because we need AL to hold the 
                                    ; smaller operand to multiply by (mul of 10)
cmp CX, 0x00                        ; If CX is 0, we're on the last iteration
                                    ; and we want to skip over it because 
                                    ; we don't need N*10^0 - it's just N
je after_exp_1                      ; Jump over the exponent loop

; The inner loop is entered if the exp (CX) is > 0
; E.g. 4^10 is 40, then 40^10 is 400, then 400^10 is 4000
exp_loop_1:
mov AX, 10                          ; AL <- 10 to multiply BX by
; Since we can only multiply by a byte, it should be in AX and the bigger number
; should be in BX (the number we're working on)
mul BX                              ; AL <- AL * BL
mov BX, AX                          ; Move the result back to BX to multiply
                                    ; again if needed
loop exp_loop_1                     ; dec CX; cmp CX, 0; jne exp_loop_1 if the
                                    ; exponent (iterator) is > 0

after_exp_1:
; Currently in BX, there's the result of going through the exponent
; process, e.g. 4000. We can add it to the total sum in memory, e.g.
;;; Value 1
; sum += 4000 
; sum += 300
; sum += 20
; sum += 1
; After the second value is processed, it can be added to this.
add word sum, BX
pop CX                              ; CX <- the initial iterator/exponent
loop convert_to_decimal_1           ; dec CX; cmp CX, 0; jne convert_etc

;;;;; Convert value 2 the same way
mov BL, offset value2
mov CL, byte [BX, 1]
mov SI, offset value2
add SI, 0x02

convert_to_decimal_2:
lods byte
sub AL, 0x30
push CX
dec CX
xor AH, AH
mov BX, AX
cmp CX, 0x00
je after_exp_2

exp_loop_2:
mov AX, 10
mul BX
mov BX, AX
loop exp_loop_2

after_exp_2:
add word sum, BX
pop CX
loop convert_to_decimal_2

; To print the number out, we need to convert hex to dec. Someday. :)