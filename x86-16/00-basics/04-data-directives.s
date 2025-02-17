;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; Data directives ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;

; What is instructions? What is data? It's all 1s and 0s, so we have to have a way
; to differentiate between the two.


; Hardcoded piece of data, nothing special about it, but this is not the most 
; efficient way to actually store data, plus most data is dynamic not static.
; start:
; mov byte [0x00], 0xff

; A better way is to tell the assembler to load in some data. 'b' = byte, 'w' = word.
; This data will be in memory before any instructions execute!

; First, an optional step to set the beginning of DS somewhere other than 0x0000
set 0x1000

; byte1 and word1 are labels - they're not executable instructions, just something
; for our convenience. They can be referenced in instructions instead of having to
; pluck the data from specific memory addresses every time.
byte1: db 0xab                     ; Store a byte - 0xab
word1: dw 0xcdef                   ; Store a word

; We can store a whole string this way too!
; This is done using 'db' so that the string can be stored as bytes.
string1: db "Hello World!"

start:
mov AH, byte [0x00]         ; The data now gets loaded into a register for whatever purpose
mov BX, word [0x01]         ; We don't have to account for endianness in that it'll still
                            ; be stored starting from 0x01, just in reverse (LSB first)
mov CH, byte byte1          ; Same thing, but using a label. No square brackets!
mov DX, word word1