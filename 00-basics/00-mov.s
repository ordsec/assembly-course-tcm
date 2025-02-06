; Demo of the MOV instruction

start:          ; Entry point of the program
mov AH, 0x15    ; Move hex 15 into AH 
mov AL, 15      ; Move decimal 15 into AL. Do NOT use 0d, decimal is decimal
mov BH, 0b1010  ; Move binary 1010 into BH
mov AX, 0xffff  ; Overwrite AX with hex ffff, which is decimal 65535 and is the
                ; max value a 16-bit register can hold
mov AH, BH      ; Move the contents of BH into AH (AL remains unchanged)