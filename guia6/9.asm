SIZE EQU 10
DATO EQU 0
IZQ EQU 2
DER EQU 6
NULL EQU -1

SUMA_HIJOS: 
    PUSH BP
    MOV BP, SP
    PUSH EBX
    PUSH EDX
    PUSH EFX

    MOV EBX, [BP + 8]
    MOV EAX, 1
    
    CMP EBX, NULL
    JZ fin_suma_hijos

    CMP [EBX + IZQ], NULL
    JZ comparo_derecho
    JMP suma_nodos

comparo_derecho:
    CMP [EBX + DER], NULL
    JZ fin_suma_hijos

suma_nodos:
    MOV DX, 0

    CMP [EBX + IZQ], NULL
    JZ suma_derecho
    
    MOV EFX, [EBX + IZQ]
    ADD DX, w[EFX + DATO]

suma_derecho:
    CMP [EBX + DER], NULL
    JZ comparar

    MOV EFX, [EBX + DER]
    ADD DX, w[EFX + DATO]
comparar:
    CMP w[EBX + DATO], DX
    JNZ falso_suma_hijos

    MOV EFX, EBX
    ADD EFX, IZQ
    PUSH [EFX]
    CALL SUMA_HIJOS
    ADD SP, 4

    CMP EAX, 0
    JZ falso_suma_hijos

    MOV EFX, EBX
    ADD EFX, DER
    PUSH [EFX]
    CALL SUMA_HIJOS
    ADD SP, 4

    CMP EAX, 1
    JZ fin_suma_hijos    

falso_suma_hijos:
    MOV EAX, 0

fin_suma_hijos:
    POP EFX
    POP EDX
    POP EBX
    MOV SP, BP
    POP BP
    RET

    





