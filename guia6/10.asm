\\INCLUDE "arbol_binario.asm"
SIG EQU 4
DATO EQU 0
IZQ EQU 4
DER EQU 8
NULL EQU -1

PUNTO10:
    PUSH BP
    MOV BP, SP
    PUSH EAX
    PUSH EBX
    PUSH ECX
    PUSH EDX
    PUSH EEX

    MOV EEX, [BP + 12]; EEX = *ROOT 
    MOV EBX, [BP + 8]; **1erNODO
    MOV ECX, [EBX]; *1erNODO
    MOV EDX, EBX; ANT

    CMP EEX, NULL
    JZ fin_recorrer_lista

ciclo_recorrer_lista:
    CMP ECX, NULL
    JZ fin_recorrer_lista

    PUSH EEX
    PUSH [ECX + VALOR]
    CALL INTREE
    ADD SP, 8

    CMP EAX, 1
    JZ is_intree

    MOV EDX, ECX
    ADD EDX, SIG
    MOV ECX, [EDX]
    JMP ciclo_recorrer_lista

is_intree:
    MOV ECX, [ECX + SIG]
    MOV [EDX], ECX
    JMP ciclo_recorrer_lista

fin_recorrer_lista:

    POP EEX
    POP EDX
    POP ECX
    POP EBX
    POP EAX
    MOV SP, BP
    POP BP
    RET







