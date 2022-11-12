@echo off
echo ~~~~ starting build for %1 ~~~~

REM assemble the asm file
ca65 %1.asm -o %1.o

REM build the rom for nes
ld65 -C nes.cfg %1.o -o %1.nes

echo ~~~~ completed ~~~~
