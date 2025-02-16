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