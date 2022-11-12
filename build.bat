@echo off
echo ~~~~ starting build for %1 ~~~~

REM assemble the asm file
echo ...assembling...
ca65 -v %1.asm -o %1.o

REM build the rom for nes
echo ...linking...
ld65 -v -C nes.cfg %1.o -o %1.nes

echo ~~~~ completed ~~~~
