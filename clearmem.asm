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
    txs
    txa                     ; A = 0

; The strategy for the clearing 2kb of RAM when we have only 
; 8bit registers is to use the x register and a series of "starting points"

ClearRam:
    sta $0000,x             ; this will clear $0000+$00 -> $0000+$FF => $0000 - $00FF is cleared
    sta $0100,x             ; this will clear $0100+$00 -> $0100+$FF => $0100 - $01FF is cleared
    sta $0200,x             ; ----
    sta $0300,x             ; ---- 
    sta $0400,x             ; ----
    sta $0500,x             ; ----
    sta $0600,x             ; ----
    sta $0700,x             ; this will clear $0700+$00 -> $0700+$FF => $0700 - $07FF is cleared

    inx
    bne ClearRam            ; by the end of this loop we will have cleared mem $0000 - $07FF are needed

LoopForever:
    jmp LoopForever


NMI:
    rti

IRQ:
    rti

.segment "VECTORS"
.org $FFFA
.word NMI
.word RESET
.word IRQ
