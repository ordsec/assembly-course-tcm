; ------------------------------------------
; ;;;;;;;;;;;;; Adding numbers ;;;;;;;;;;;;;
; - Ask the user for two inputs between
;   0 and 9999
; - Accept the two inputs
; - Add the two inputs together
;   >>> Remember that they're first stored
;       in ASCII!
; - Store the sum into a memory address
; - Output the sum
;-------------------------------------------

prompt1: db "Gimme a number (0-9999): "
prompt1null: db 0x00
prompt2: db "Gimme another number (0-9999): "
prompt2null: db 0x00
buf1: db 4 db [0x00, 0x6] db 0xff
num1: db [0x00, 0x4] db 0x00
num2: db [0x00, 0x4] db 0x00

start:
mov AH, 0x13
mov CX, offset prompt1null
sub CX, offset prompt1
mov BP, offset prompt1
int 0x10

; since it's a multi-char input, we need a buffer

xor AH, AH
mov AH, 0xa
mov DX, offset buf1
int 0x21

; process the first number from ascii

mov SI, offset buf1
add SI, 2                   ; number starts at byte 2 of buf
mov DI, offset num1

process_buf:
lods byte 
cmp AL, 0x00
je print_prompt2
sub AL, 0x30
stos byte
jmp process_buf

print_prompt2:
xor AH, AH
mov AH, 0x13

; 9999 = 9 x 1000 + 9 x 100 + 9 x 10 + 9
;        00         01        02       03
