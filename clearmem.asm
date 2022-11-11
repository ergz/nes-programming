; iNES Header

.segment "HEADER"
.org $7FF0              ;; start at address $7FF0
.byte $4E,$45,$53,$1A   ;; 4 bytes with character 'N', 'E', 'S', '\n'
.byte $02
