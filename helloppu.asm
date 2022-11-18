; iNES Header

.segment "HEADER"
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


RESET:
    sei                     ; disable all interrupts
    cld                     ; clear the decimal mode flag
    ldx #$40
    stx $4017               ; disable the API interrupt
    ldx #$FF
    txs                     ; start stack pointer at $FF
    inx                     ; to wrap around from $FF -> $00
    stx $2000               ; disable NMI by setting to 0
    stx $2001               ; disable rendering by setting to 0
    stx $4010               ; disable DMC by setting to 0

WaitVBlank1:                ; loop until bit 7 of the APU register
    bit $2002
    bpl WaitVBlank1

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
    bne ClearRam            ; by the end of this loop we will have cleared mem $0000 - $07FF as needed

WaitVBlank2:                ; loop until bit 7 of the APU register
    bit $2002
    bpl WaitVBlank2


Main:
    ldx #$3F                ; load into X the value $3F
    stx $2006               ; store the current value of X ($3F) into the address $2006
    ldx #$00                ; load into X the value $00
    stx $2006               ; store the current value in X into the address $2006
    lda #$2B
    sta $2007
    lda #%00011110
    sta $2001


LoopForever:
    jmp LoopForever


NMI:
    rti

IRQ:
    rti

.segment "VECTORS"
.word NMI
.word RESET
.word IRQ
