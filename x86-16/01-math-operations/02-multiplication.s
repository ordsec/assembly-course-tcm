;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; Math - multiplication ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; This works a bit differently than add/sub. Multiplication is
; performed on an unsigned byte/word by the contents of AL. 
; This means we can do byte * byte or byte * word, but not word * word.
; There is no way to multiply by an immediate in 8086 - the number
; must first be moved to a register or a memory location.

start:

; Basic byte * byte multiplication
mov AL, 5
mov BL, 10
mul BL                  ; BL times the contents of AL, result stored in AX

mov BX, 10000
mul BX                  ; BX * AL, result stored in AX

; Now if we go over a word for the resulting value, the overflow will
; go to DL. For instance, 5 * 30000 = 0x249f0, so AX will be 49f0 and
; DL will be 0002. In other words, we can use three bytes to store the
; result of multiplication. When this happens, the Overflow Flag (OF)
; is set to 1. 

; Also, because we can only multiple AL * N, N can't be larger than 
; 0xffff. 
mov AL, 255             ; 0xff
mov BX, 0xffff
mul BX                  ; The result is 0xfeff01 or 16,711,425

; If OF is set to 1, that means the result in AX is not complete and
; we need to use conditional logic to move the result into memory as a
; three-byte value.