;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; Math - subtraction ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Subtraction works pretty much the same way as addition.
; With a single byte:
start:
mov AL, 250
sub AL, 200                 ; AL - 200, result stored in AL

; With a word:
mov BX, 25000
sub BX, 20000               ; BX - 20000, result stored in BX

; The second parameter does not have to be an immediate 
; (same with addition). 
mov word [0x00], 25000
sub word [0x00], BX         ; Subtract the value in BX (5000)
                            ; from the value at [0x00]

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; Subtraction with a negative result ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; A negative number has a minus next to it, such as -20.
; This minus is a sign, which makes the number a SIGNED integer.
; 20, on the other hand, is an UNSIGNED integer.

; The unsigned byte range is 0 - 255 / 0x00 - 0xff
; The signed byte range is -128 - 0 - 127. 
; This is because the leftmost bit becomes the sign flag. 
; When it's set to 0, the value is POSITIVE. When it's set to 1, it's NEGATIVE:
; 0b00110101 -> 53
; 0b10110101 -> -53

; This range is a strict constraint. -128 - 1 will not result in -129, 
; instead the bits will flip from 10000000 to 01111111, which is 127.

; There is a commonly agreed upon hex representation.
; Positive range: 0 - 127 / 0x00 - 0x7f
; Negative range: -128 - -1 / 0x80 - 0xff. -128 is 0x80 and -1 is 0xff

;;;;; Subtraction with the borrow flag ;;;;;

; mov AL, -128               ; Decimal notation is allowed, AL is now 0x80

; Side note: it's our responsibility to keep track what 1's and 0's represent. 
; 0x80 can be a character, a negative number, a positive number, or a pointer.
; In binary, there is no difference between the three. Knowing what exactly it is
; and writing code to make sure the behaviour is correct is our job.
; For instance, we may want to replace -128 with 128 in AL. It's still 0x80,
; so we want to be explicit:
; xor AL, AL                ; Zero out the register
; mov AL, 128               ; 0x80 again, but it's now 128 because we know it is.

mov AL, 200
sub AL, 250                 ; 200 - 250, AL is now 0xce, CF is set to 1

; In the context of subtraction, CF is referred to as the Borrow Flag.

; The signed word range is easier to represent in hex. 
; Positive side: 0x0000 - 0x7fff / 0 - 32,767
; Negative side: 0x8000 - 0xffff / -32,768 - -1
; The full range is therefore -32,768 - 0 - 32,767

mov BX, 20000
sub BX, 25000               ; 20000 - 25000, BX is now 0xec78, borrow is set to 1