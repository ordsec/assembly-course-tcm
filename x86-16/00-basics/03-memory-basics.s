;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; Moving to and from memory ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

start:
; First, specify how much space in memory the value will need
; Second, the memory location must be referenced with [square brackets]
; An immediate or a register can be used
mov byte [0x2c], 0xff
mov AH, 0xaa            ; Put 0xaa into AH
mov byte [0x3a], AH     ; Move the contents of AH into memory at 0x3a - AH can be freed up

; A word is two bytes
mov BX, 0xabcd
mov word [0x49], BX     ; Little-endian! Least significant byte will come first.
                        ; 0x49 will contain 'cd', then 0x4a will contain 'ab'
                        
; We can't move a data offset into DS as an immediate. 
; The following will throw a syntax error:
;;;; mov DS, 0x1000
; But we can copy it from a register
mov CX, 0x1000          
mov DS, CX

; What we've done above is moved the starting address/offset of the Data Segment (DS)
; from 0x00000 up to 0x10000 (0x00000 being the bottom and 0xFFFFF being the top)
; In the memory section of the emulator, the start address will have to be set to 0x10000
; in order to view the values in there.
mov byte [0x12], 0xdd
mov word [0x5a], 0xbeef

; Moving data from a memory address into a register works the opposite way.
; First, specify the destination (register)
; Second, how big the value being dereferenced is (byte or word)
; The value IN MEMORY is dereferenced using square brackets. So we're not moving the value
; 0x12 into AL below, we're moving what's IN MEMORY at the address of 0x12 - which is 0xdd
mov AL, byte [0x12]
mov DX, word [0x5a]     ; Still little-endian! Just looks the opposite, but the least
                        ; significant bit goes into DL
                        
; If need be, DS can be moved to a different location or back to 0x00000
mov CX, 0x0000          
mov DS, CX

; A note on endianness. A number such as '0x86fc' is a word (not a single byte), so it'll be
; stored in memory as 'fc 86' due to x86 being little-endian. However, this is a 16-bit,
; i.e. two-byte value, which is why the rules of endianness apply. A string will be stored
; IN ORDER because it's a selection of single bytes and there's no order to a single byte.