; iNES Header

.segment "HEADER"
.org $7FF0                  ; start at address $7FF0
.byte $4E,$45,$53,$1A       ; 4 bytes with character 'N', 'E', 'S', '\n'
.byte $02                   ; 2x 16kb of program code
.byte $01                   ; 1x 8kb of character rom
.byte %00000000             ; horiz mirror, no battery, no mapper
.byte %00000000             ; all disabled
.byte $00                   ; no program ram size
.byte $00                   ; ntsc tv
.byte $00                   ; no program ram 
.byte $00,$00,$00,$00,$00   ; padding

.segment "CODE"
.org $8000


RESET:
    sei                     ; disable all interrupts
    cld                     ; clear the decimal mode flag
    ldx #$FF
    txs                     ; init the stack pointer at the bottom of the stack

    lda #0
    ldx #$FF 
MemLoop:                    ; loop from $FF until the zero flag is enabled
    sta $0,x                ; store that value in A into the mem position $0+x <- where x is register changing memory
    dex
    bne MemLoop

NMI:
    rti

IRQ:
    rti

.segment "VECTORS"
.org $FFFA
.word NMI
.word RESET
.word IRQ
