.include "consts.inc"
.include "header.inc"
.include "init.inc"

.segment "CODE"

.proc loadPalette 
    ldy #0
:
    lda PaletteData,y 
    sta PPU_DATA
    iny
    cpy #32
    bne :-
    rts
.endproc

RESET:
    init_nes

Main:
    bit PPU_STATUS          ; make sure the latch in PPU_ADDR is reset by "poking" the PPU_STATUS
    ldx #$3F                ; load into X the value $3F
    stx PPU_ADDR            ; store the current value of X ($3F) into the address $2006
    ldx #$00                ; load into X the value $00
    stx PPU_ADDR            ; store the current value in X into the address $2006

    jsr loadPalette         ; jump to subroutine

    lda #%00011110
    sta PPU_MASK


LoopForever:
    jmp LoopForever


NMI:
    rti

IRQ:
    rti


PaletteData:
.byte $0F,$2A,$0C,$3A, $0F,$2A,$0C,$3A, $0F,$2A,$0C,$3A, $0F,$2A,$0C,$3A
.byte $0F,$10,$00,$26, $0F,$10,$00,$26, $0F,$10,$00,$26, $0F,$10,$00,$26

.segment "CHARS"
.incbin "mario.chr"

.segment "VECTORS"
.word NMI
.word RESET
.word IRQ

