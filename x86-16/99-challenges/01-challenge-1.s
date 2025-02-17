; Challenge 1: set registers as follows

; AX = 0ff0
; BX = f00f
; CX = 0ff0
; DX = f00f

; Restriction: you can only use one immediate in the code

start:
mov AX, 0x0ff0
mov BH, AL
mov BL, AH
mov CX, AX
mov DX, BX