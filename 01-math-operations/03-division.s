;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; Math - division ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;

; The division instruction is similar to multiplication - we can't
; pass in a hard-coded number, instead we have to pass in a register
; or a memory location. Here's how div works on 8086:

; When we divide by a byte: 
; AL = AX / operand
; AH = remainder

; When we divide by a word:
; AX = (DX AX) / operand
; DX = remainder

; Dividing by a byte

start:
mov AX, 1005
mov BL, 10                  
div BL                      ; AX is divided by BL, result stored in AL
                            ; remainder stored in AH. AL = 0x64, AH = 0x5

; The remainder is aka the modulus. In high-level languages, there is
; a modulus operator (%), so it's important that the remainder is
; easily accessible.

; Dividing by a word

mov AX, 0xabcd
mov DX, 0xa
mov BX, 0xabc3
div BX                      ; AX = (DX AX) / BX, remainder stored in DX.
                            ; (DX AX) is basically concatenation, here it's
                            ; 0xaabcd. AX is now 0xf, DX is 0x9b60