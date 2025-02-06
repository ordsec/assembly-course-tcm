;;;;;;;;;;;;;;;;;;;;;;;
;;;;; Comparisons ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;

; In high-level languages, conditional logic is usually written
; as `if (<condition>) { doSomething(); } else { doTheOtherThing(); }

; At the core, these conditions are based on comparisons that evaluate
; to true or false. We can do similar stuff in Assembly, but there are
; more steps involved.

; First it's important to know the `cmp` instruction and how it works.
; cmp is very similar to add/sub - except it doesn't modify registers;
; all it does it set flags.

start:
; The following subtracts 5 from 10, CF (borrow) is not set as we're
; not getting into negative values, and ZF is not set because the result
; is not 0.
mov AL, 10
sub AL, 5                   ; AL <- AL - 5

; The above is already a comparison - we know that AL was bigger than 5,
; We know this based on the flags.
; If we sub'd 10 from AL, ZF would be set, meaning AL was equal to 10.
; If we sub'd 11 or more from AL, we would know based on CF that AL was
; less than 11.
; All these things are at the heart of cmp - except we're not performing
; the math (therefore not modifying registers). We're simply using flags
; in order to see how two values compare.

add AL, 5                   ; AL back to 10
cmp AL, 5                   ; No changes to flags
cmp AL, 10                  ; ZF -> 1, meaning they're equal
cmp AL, 11                  ; CF -> 1, meaning AL is less than 11

; There is no instruction to explicitly clear the ZF because the ZF
; is only set to 1 after the most recent instruction somehow results
; in 0. ZF itself is 0 at all times otherwise.

; We can compare register vs immediate, register vs register, and
; register vs memory location.
clc                         ; Clear CF
mov BL, 8
cmp AL, BL                  ; No ZF, no CF - AL > BL
mov byte [0x7f], 17
mov BL, 0x7f
cmp AL, byte [BX]           ; CF -> 1

; Say AL is 10 and BL is 3. Even though AL > BL means BL < AL, there is
; a subtle difference between the two in terms of flags. 

; cmp AL, BL                ; No flags set because AL > BL
; cmp BL, AL                ; CF -> 1 because BL < AL

; This is something to keep in mind when performing jumps - we have to
; keep track of what's compared against what as that will influence the
; resulting logic.