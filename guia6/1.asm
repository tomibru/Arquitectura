\\EXTRA 1024
ES_OFFSET EQU 1024

;Alloc: Reserva n bytes del HEAP, retorna en EAX el puntero a la memoria reservada
;PUSH n
;CALL Alloc
;ADD SP, 4
Alloc:
    PUSH BP
    MOV BP, SP
    PUSH EBX
    PUSH ECX

    MOV EBX, l[BP + 8]
    MOV EAX, l[ES]
    ADD EBX, EAX
    MOV ECX, ES
    ADD ECX, ES_OFFSET
    CMP EBX, ECX
    JP sin_lugar
    MOV l[ES], EBX
    JMP fin

sin_lugar:
    MOV EAX, -1
fin:

    POP ECX
    POP EBX
    POP BP
    RET

STAR_HEAP:
    ;Inicializacion del heap
    MOV l[ES], ES
    ADD l[ES], 4
    RET

CREAR_NODO:     ;RETORNA DIRECCION EN EAX
    PUSH BP
    MOV BP, SP
    PUSH EBX

    MOV EBX, l[BP + 8]
    PUSH 8
    CALL Alloc
    ADD SP, 4

    CMP EAX, -1
    JZ fin

    MOV l[EAX], EBX
    MOV l[EAX + 4], -1

fin:
    POP EBX
    POP BP
    RET

INSERT_SORT:
    PUSH BP
    MOV BP,SP
    PUSH EAX ; ant
    PUSH EBX ; act
    PUSH ECX 
    PUSH EDX ; uso auxiliar
    PUSH EFX ; uso auxiliar

    MOV EAX, l[BP + 12] ; TLISTA
    MOV EBX, l[EAX] ; 1er nodo
    MOV ECX, l[BP + 8] ; nodo a insertar

ciclo_cmp:
    MOV EDX, l[ECX] ; valor a insertar
    CMP EBX, -1
    JZ insertar ; ultimo elemento
    CMP l[EBX], EDX
    JNN insertar

    MOV EDX, EBX  
    ADD EDX, 4 ; *Sig
    MOV EBX, l[EDX] ; act = act->sig

    MOV EAX, EDX ; ant es un pntr al sig del nodo anterior
    JMP ciclo_cmp
insertar:
    MOV l[ECX + 4], EBX ; nuevo->sig = act
    MOV l[EAX], ECX ; ant-> sig = nuevo

    POP EFX
    POP EDX
    POP ECX
    POP EBX
    POP EAX
    POP BP
    RET

REMOVE:
    PUSH BP
    MOV BP, SP
    PUSH EBX
    PUSH ECX                ; ant: puntero a la celda
    PUSH EDX                ; act
    PUSH EEX

    MOV EBX, l[BP + 8]      ; valor a borrar
    MOV ECX, l[BP + 12]     ; ant = &Y
    MOV EDX, l[ECX]         ; act = primer nodo

rem_busqueda:
    CMP EDX, -1
    JZ rem_no_esta
    CMP l[EDX], EBX
    JZ rem_eliminar
    MOV ECX, EDX
    ADD ECX, 4              ; ant = &(act->sig)
    MOV EDX, l[ECX]         ; act = act->sig
    JMP rem_busqueda

rem_eliminar:
    MOV EEX, l[EDX + 4]     ; act->sig
    MOV l[ECX], EEX         ; *ant = act->sig
    MOV EAX, 1
    JMP rem_fin

rem_no_esta:
    MOV EAX, 0

rem_fin:
    POP EEX
    POP EDX
    POP ECX
    POP EBX
    POP BP
    RET


SEARCH:
    PUSH BP
    MOV BP, SP
    PUSH EBX
    PUSH ECX

    MOV EBX, l[BP + 8]      ; valor
    MOV ECX, l[BP + 12]     ; &Y
    MOV ECX, l[ECX]         ; ECX = primer nodo

search_busqueda:
    CMP ECX, -1
    JZ no_encontrado
    CMP l[ECX], EBX
    JZ encontrado
    MOV ECX, l[ECX + 4]     ; act = act->sig
    JMP search_busqueda

no_encontrado:
    MOV EAX, -1
    JMP fin_search

encontrado:
    MOV EAX, ECX

fin_search:
    POP ECX
    POP EBX
    POP BP
    RET 

LV  EQU "Lista vacia\n"
SEP EQU " "

PRINT_LISTA:
    PUSH BP
    MOV BP, SP
    PUSH EAX
    PUSH ECX
    PUSH EDX
    PUSH EFX

    MOV EFX, l[BP + 8]      ; &Y
    MOV EFX, l[EFX]         ; primer nodo
    CMP EFX, -1
    JZ lista_vacia

print_imprimir:
    CMP EFX, -1
    JZ fin_print            ; <- era JMP

    MOV EDX, EFX            ; EDX apunta al valor del nodo
    LDH ECX, 0x04
    LDL ECX, 0x01
    MOV EAX, 0x01
    SYS 0x2

    MOV EDX, KS
    ADD EDX, SEP
    SYS 0x4                 ; separador

    MOV EFX, l[EFX + 4]
    JMP print_imprimir

lista_vacia:
    MOV EDX, KS
    ADD EDX, LV
    SYS 0x4

fin_print:
    POP EFX
    POP EDX
    POP ECX
    POP EAX
    POP BP
    RET

main:

    CALL STAR_HEAP



    