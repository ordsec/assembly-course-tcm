;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; The lods insturction ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; In brief, lods allows us to sequentially loop over
; memory and load the contents of each byte into a 
; register. This is good for reading through stored
; strings or iterating over an array of data where
; we need to access each individual piece.

; First, some dummy data:

; 0xf 01's
db [0x01, 0xf]

; a null-terminated string
string: db "I am a string, nothing special about me." db 0x00

; If we want to, we can take the manual approach: 
; set an iteration counter, load each byte, etc. - 
; the problem is that memory addresses will almost 
; always be different from the loop counter, so 
; there's gonna be a bunch of math and magic numbers
; involved to make them correct. We'd have to track
; both the memory addresses and the loop counter.

; lods is what helps us keep track of all these things.
; It looks at the SI (source index), so this needs to be
; set to point at the first byte that we want lods to
; start with. Then, with each iteration, SI will increment.
; Now all we need to control is the looping logic. 
; If we want to go back in the array we're iterating over,
; we can just set the SI.

start:
; The code below will print calculate the length of the string
; without knowing its offset, using a loop with lods,
; in other words we'll "load" the string, byte by byte, from
; memory and then print it.
; The null terminator in the string allows us to know
; when we've reached the end of the string.
; CX will be used as an increment counter. Whenever we read
; over a byte and it's not the null, we'll increment.
xor CX, CX                  ; zero out CX for safety
mov SI, offset string       ; SI -> beginning of the string

; The loop itself
read_string:
lods byte                   ; load a byte into AL, can be a word (AX)
cmp AL, 0x00                ; are we at the null yet?
je end                      ; if so, break out of the loop
inc CX                      ; otherwise, advance CX
jmp read_string             ; back to the beginning of the loop

end:
mov AH, 0x13
mov BP, offset string
; and now we don't need to set up CX
; because it's already counted for us!
int 0x10

; lods is very powerful because it opens up a lof of functionality
; that relies on iterating over an array of data.