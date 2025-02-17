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
string1: db "I'm a little string." db 0x00
db [0x00, 0xf]                 

; Allocating a chunk of memory and making sure
; it's empty by zeroing it out. 
string2: db [0x00, 0x14]

start:
xor CX, CX                      ; zero out CX (counter) for sanity
mov SI, offset string1          ; SI -> beginning of the original string
mov DI, offset string2          ; DI -> beginning of the space 
                                ; allocated for the copied string (string2)
read_string:
lods byte                       ; load a byte pointed to by SI into AL
stos byte                       ; store the byte in AL into memory
                                ; where DI is pointing
cmp AL, 0x00                    ; are we at the null terminator yet?
je end                          ; if so, the string has been loaded
inc CX                          ; otherwise, increment the counter
jmp read_string                 ; and start the loop over

end:
mov AH, 0x13                    ; print the copied string
mov BP, offset string2
int 0x10


; The real power of stos is the flexibility it provides us with
; in order to manipulate the data being copied before storing it.
; Basic example (removing spaces from the string):

; read_string:
; lods byte

; Here, between lods and stos, we can write logic, if we so desire,
; that will perform some sort of a manipulation.

; cmp AL, 0x20                  ; does AL contain a space?
; je after_store                ; if so, don't store it

; stos byte                     ; store after the check
; inc CX                        ; make sure the length of string2
                                ; is calculated correctly
; after_store:                  ; the check against the null terminator
; cmp AL, 0x00                  ; is performed here now
; je end
; jmp read_string