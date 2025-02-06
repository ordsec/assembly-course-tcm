;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; Math - addition ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;

start:
mov AL, 0xab

; The sum is stored in the destination
; AL + 0x01, result 0xac stored in AL
add AL, 0x01

; We can add a word too
mov BX, 0xabcd
add BX, 0x0003              ; BX + 0x0003, stored in BX

; We can do all this in memory too - the result of the addition
; will be stored at the specified address.
mov byte [0x00], 0x0f
add byte [0x00], 0x01

mov word [0x01], 0x206f
add word [0x01], 0x0001

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; Addition with carry flag ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Sometimes the result of adding things together is too large
; to store in a register or a specified memory location. 
; This involves the use of flags. Flags are another register,
; but we don't use them the same way as we do other registers.
; Instead, we treat each bit in the register as its own separate
; flag, with boolean values, and there are 9 flags that are used
; on the 8086. We don't set the flags ourselves, rather they're
; set by CPU instructions when a certain condition is met. 
; Flags are relied upon when writing control flow logic and
; many other things.

; The CF is used in addition/subtraction instructions. For ADD,
; it's set to 1 when the sum of the addition is too big to fit
; into a register or a memory location provided for the result.
; Setting the CF to 1 means: the result is not completely true,
; we have to add the carryover to continue with the operation.
; We can purposely use it to perform arithmetic operations that
; exceed the limitations of register sizes.

mov AL, 250             ; 0xfa
add AL, 200             ; AL + 200, stored in AL

; 450 is 0x1c2. The result will be 0xc2 in AL and CF set to 1.
; In other words, we've gone over what AL can hold, and we have to
; carry 1 over, getting 0x1c2 as a result. What we can do now
; is use memory to get more room or expand out to a word register
; rather than a byte. This can be done using conditional logic.

;;;;; Clearing the CF ;;;;;

; mov AH, 20            ; Here the CF is still set
; add AH, 30            ; CF is reset to 0 only when an operation
                        ; not relying on it is run.

clc                     ; Specific instruction to clear CF.
mov AH, 20              ; The rest works as intended without
add AH, 30              ; any potential surprises.

;;;;; Word addition with the CF ;;;;;

mov BX, 0xfff0
add BX, 0x0011          ; BX + 0x0011, stored in BX

; The result of this is 0x10001. BX is 0001, CF is set to 1 
; for the carryover.

; The bottom line is, the carry must be handled so that the program
; can reliably work as intended.