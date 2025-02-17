;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; Accepting a single char ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Interrupt 0x21 is involved in this, with two subfunctions:
; one for a single char (0x01), the other for multiple.

number: db 0x00

start:
mov AH, 0x01                    ; The subfunction ID lives in AH

; Once this line has executed, the program will hang until 
; user input is submitted. Once that's done (and it can only be
; one character, i.e. one byte), the submitted character will be
; stored in AL.
int 0x21

; What you want to do at this point is persist the value in memory
; before AL is overwritten, which it will be.
mov byte [offset number], AL