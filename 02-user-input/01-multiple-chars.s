;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; Accepting multiple characters from user input ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; The int 0x21 subfunciton for this is 0xa.

; First, we set up a buffer for where the string
; from user input is to be written.

; Boilerplate data directive to create a buffer:

; buffer: db N db [<value>, N+2]

; N is how many characters we want to fit in the buffer.
; <value> is a placeholder that will initially fill up reserved bytes.
; The N+2 number is how much memory we're actually allocating.
; This number is specified with a couple of "special bytes" 
; in mind, with the following arrangement for any buffer:
; - Byte 0 will contain the maximum number of chars.
; - Byte 1 is where int 0x21 stores the ACTUAL number 
;   of chars that are brought in - and now we don't have to
;   calculate the length of the string.
; - Byte 2 is the start of the actual data we're saving 
;   into the buffer.
; - The last byte of the buffer is an optional, but highly 
;   recommended, byte that will hold the null terminator, C style

; Therefore, the total number of bytes the system will actually allocate
; is N+3. 

; The price to pay for breaking this rule is buffer overflow!
; The string will spill out into the following memory locations,
; erasing what's already there. Remember that any change to
; the contents of a memory location is destructive, with no
; checks and "are-you-sure's" in place.

; Here, 12 is the size of the buffer and 14 is how much memory we are
; allocating with the special bytes in mind. The total amount of 
; allocated memory will be 15 bytes. The first byte of the buffer
; holds the length value, which is in this case 0x0c (12)
buffer: db 12 db [0x00, 14]

start:
mov AH, 0xa                     ; Subfunction for int 0x21 to accept
                                ; user input of multiple characters
mov DX, offset buffer           ; DX <- beginning address of the buffer
                                ; for 0x21 to store the chars.
int 0x21

; Now if the user enters, for instance, "Hello world!", byte 0 of the
; allocated buffer will still hold 0x0c, byte 1 will hold the length
; of the char sequence (also 0x0c), and the rest will be the sequence
; itself, represented by ASCII numbers in hex. The last byte (or few,
; if the string is shorter than the max of 12) will be a 00, which is
; our null terminator.

; To prevent bugs, after the value in DX is no longer needed after
; int 0x21 runs, we should zero out DX.
xor DX, DX

; We can then output the string that was entered.
mov AH, 0x13                    ; int 0x10 subfunction for output

; Below, we dynamically calculate the length of the string to be printed
; (it's already in byte 1 of the buffer) and get the location of where
; to start printing (byte 2 of the buffer).
mov BL, offset buffer           ; BL <- beginning address of the buffer

; We need a memory location regardless of where it is. To do this, 
; we treat the value in BX as a memory address. However, because we need
; to start from byte 1 not byte 0, the second value in the brackets
; is what tells the assembler how many bytes to shift over. 
; This is equivalent to [BX + 1] in a lea instruction.
; IMPORTANT: because of a limitation of the 8086 processor,
; this can only be done with BX.
; In other words, BX is the only register that can be used to store a 
; value that can be dereferenced as a pointer.
mov CL, byte [BX, 1]

xor BX, BX                      ; Zero out BX as a good practice
mov ES, BX                      ; We're in the 0x00000 segment
mov BP, offset buffer           ; BP <- address of byte 0 of the buffer
add BP, 2                       ; Add 2 in order to shift over to byte 2
int 0x10

; All of the above will work regardless of where the string is in memory
; and regardless of the length of the string as long as it's within the
; limit imposed by the buffer size (12 in this case).
; We can use the db directive to occupy a few starting memory locations
; with some random data, then place the buffer, and int 0x10 will still
; work from the correct position because it's no longer confined to
; hardcoded locations and string lengths.