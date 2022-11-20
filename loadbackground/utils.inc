.macro ppu_set_address addr
    
    bit PPU_STATUS
    lda #>addr
    sta PPU_ADDR 
    lda #<addr 
    sta PPU_ADDR

.endmacro 
