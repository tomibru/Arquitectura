HIJO EQU 0
SIG EQU 4
ROOT EQU 0
NULL EQU -1
VALORN EQU 0
HIJOS EQU 4

ELIMINAR_VALOR_ARBOL:
    PUSH BP
    MOV BP, SP
    PUSH EAX
    PUSH EBX
    PUSH ECX
    PUSH EDX
    PUSH EFX

    MOV EAX, [BP + 12]; **ROOT
    MOV EBX, [EAX], *ROOT
    MOV ECX, [BP + 8]; VALOR

    MOV EDX ,[EBX + HIJOS]
llamado_recursivo:
    CMP EDX, NULL
    JZ fin_llamado_recursivo

    PUSH EDX
    PUSH ECX
    CALL ELIMINAR_VALOR_ARBOL
    ADD SP, 8

    MOV EDX, [EDX + SIG]
    JMP llamado_recursiva
fin_llamado_recursivo:

    CMP [EBX + VALORN], ECX
    JNZ fin_eliminar_valor_arbol

    ;ELIMINAR NODO
    MOV EDX, [EBX + HIJOS];
    MOV [EAX], [EDX + HIJO]; **ROOT AHORA APUNTA AL PRIMER HIJOS

    MOV EBX, [EDX]; EBX APUNTA AL PRIMER HIJO
    MOV EFX, EBX
    ADD EFX, HIJOS

avanzar_en_hijos:
    CMP [EFX], NULL
    JZ agregar_hijos

    MOV EFX, [EFX]
    ADD EFX, SIG
    JMP avanzar_en_hijos

agregar_hijos:
    ADD EDX, SIG
    CMP [EDX], NULL
    JZ fin_agregar_hijos

    MOV [EFX], [EDX]
fin_agregar_hijos:
    MOV [EDX], NULL
    POP EFX
    POP EDX
    POP ECX
    POP EBX
    POP EAX
    MOV SP, BP
    POP BP
    RET

  


PUNTO11:
    PUSH BP
    MOV BP, SP
    PUSH EBX
    PUSH ECX
    PUSH EDX

    MOV EDX, [BP + 12] ; ANT, INICIALIZADO EN **1ER NODO LISTA
    MOV EBX, [EDX]; EBX = *1ER NODO LISTA

    MOV ECX, [BP + 8]; VALOR

ciclo_recorrer_lista:
    CMP EBX, NULL
    JZ fin_recorrer_lista

    PUSH EBX ; <<**ROOT>>
    PUSH ECX ; <<VALOR>>
    CALL ELIMINAR_VALOR_ARBOL
    ADD SP, 8

    CMP [EBX + HIJO], NULL
    JNZ avanzar_lista

    ;Eliminar nodo
    MOV [EDX], [EBX + SIG]
    MOV EBX, [EBX + SIG]
    JMP ciclo_recorrer_lista

avanzar_lista:
    MOV EDX, EBX
    ADD EDX, SIG
    MOV EBX, [EDX]
    JMP ciclo_recorrer_lista

fin_recorrer_lista:

    POP EDX
    POP ECX
    POP EBX
    MOV SP, BP
    POP BP
    RET
