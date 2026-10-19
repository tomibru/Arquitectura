TRUE EQU "Es palindroma\n"
FALSE EQU "No es palindroma\n"
AUX EQU 100

NORMALIZAR:
    PUSH BP
    MOV BP, SP
    PUSH EAX
    PUSH EBX
    PUSH ECX
    PUSH EDX

    MOV EDX, l[BP + 8]          ; lector (frase original)
    MOV EBX, DS
    ADD EBX, AUX                ; escritor 
    MOV ECX, EBX                ; ECX = inicio del auxiliar

ciclo_normalizar:
    MOV EAX, 0
    MOV AL, b[EDX]
    CMP EAX, 0
    JZ fin_normalizar
    ADD EDX, 1

    CMP EAX, 65
    JN ciclo_normalizar         ; menor que 'A': descartar
    CMP EAX, 90
    JP no_mayus
    ADD EAX, 32                 ; mayúscula -> minúscula
    JMP guardar
no_mayus:
    CMP EAX, 97
    JN ciclo_normalizar         ; entre 'Z' y 'a': descartar
    CMP EAX, 122
    JP ciclo_normalizar         ; mayor que 'z' (incluye bytes de acentos)
guardar:
    MOV b[EBX], AL
    ADD EBX, 1
    JMP ciclo_normalizar

fin_normalizar:
    MOV b[EBX], 0
    MOV EDX, l[BP + 8]          ; destino: la frase original
    MOV EBX, ECX                ; vuelvo al inicio del auxiliar
sobreescritura:
    MOV AL, b[EBX]
    MOV b[EDX], AL
    CMP AL, 0
    JZ fin
    ADD EDX, 1
    ADD EBX, 1
    JMP sobreescritura

fin:
    POP EDX
    POP ECX
    POP EBX
    POP EAX
    POP BP
    RET

main:
    PUSH BP
    MOV BP, SP
    MOV EFX, b[BP + 12];argv, ebx es un puntero al arreglo de punteros

    ADD EFX, 4
    MOV EBX, l[EFX]
    PUSH EBX
    CALL NORMALIZAR
    ADD SP, 4

    MOV EAX, EBX
ciclo_final:
    CMP b[EAX], 0
    JZ llegue_al_final
    ADD EAX, 1
    JMP ciclo_final
llegue_al_final:
    SUB EAX, 1; EAX PUNTERO AL FINAL

ciclo_cmp:
    CMP EBX, EAX
    JNN verdadero 

    MOV ECX, 0
    MOV CL, b[EAX]
    CMP CL, b[EBX]
    JNZ falso

    ADD EBX, 1
    SUB EAX, 1
    JMP ciclo_cmp  

verdadero: 
    MOV EDX, KS
    ADD EDX, TRUE
    SYS 0x04
    JMP fin

falso:
    MOV EDX, KS
    ADD EDX, FALSE
    SYS 0x04
fin:
    RET






