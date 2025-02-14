;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; The stos instruction ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; stos is the opposite of lods - it takes the data
; from a register and stores it into memory sequentially.

; stos works with the AL register - just like lods - 
; and it copies the contents of that register into a 
; memory address using the DI (destination index) pointer
; to keep track of where in the memory the data is being
; stored. This is another difference vs lods, where SI
; (source index) is used. This is done on purpose so that
; we can use lods and stos in conjunction to read out an 
; array of data into a register, do something with it,
; and store it back into memory

; Some dummy data
db [0x01, 0xf]
string: db "I'm a little string." db 0x00
db [0x01, 0xf]

; Allocating an empty chunk of memory and making sure
; it's empty by zeroing it out. 
string2: db [0x00, 0xe]

start:
mov AH, 0x13