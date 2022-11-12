.segment "HEADER"
.org $7FF0
.byte $4E,$45,$53,$1A,$02,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$0


.segment "CODE"
.org $8000

RESET:
; TODO:
; Load the A register with the literal hexadecimal value $82
; Load the X register with the literal decimal value 82
; Load the Y register with the value that is inside memory position $82
    ; lda #$82 ; 8*16 + 2 = 130
    ; ldx #82 ; literal value 82 
    ; ldx $82 ; store into x whatever the value that is in address location $82

; TODO:
; Load the A register with the hexadecimal value $A
; Load the X register with the binary value %11111111
; Store the value in the A register into memory address $80
; Store the value in the X register into memory address $81

    ; lda #$A 
    ; ldx #%11111111
    ; sta $80
    ; stx $81

; ; TODO:
; ; Load the A register with the literal decimal value 15
; ; Transfer the value from A to X
; ; Transfer the value from A to Y
; ; Transfer the value from X to A
; ; Transfer the value from Y to A
; ; Load X with the decimal value 6
; ; Transfer the value from X to Y


    lda #15
    tax
    tay
    txa
    tya
    ldx #6
    txa
    tay
    



NMI:
    rti

IRQ:
    rti




.segment "VECTORS"
.org $FFFA
.word NMI
.word RESET
.word IRQ
