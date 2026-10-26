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


;8. Crear una estructura de árbol binario que permita cargar ordenados números ingresados por el 
;usuarios  (indicando el último número con un número negativo). Armar subrutinas para: 

;a. Agregar un nodo al árbol.      

SIZE EQU 12
VALOR EQU 0
IZQ EQU 4
DER EQU 8
NULL EQU -1

ADD_NODO:
    PUSH BP
    MOV BP, SP
    PUSH EAX
    PUSH EBX
    PUSH ECX
    PUSH EDX

    MOV EDX, [BP + 8]       ; EDX = ROOT** (campo a escribir)
    MOV EAX, [EDX]          ; EAX = nodo actual (ROOT*)
    MOV EBX, [BP + 12]      ; EBX = nodo a agregar

ciclo_add_nodo:
    CMP EAX, NULL
    JZ add_nodo

    MOV ECX, [EAX + VALOR]
    CMP ECX, [EBX + VALOR]  ; actual - nuevo
    JN derecha              ; actual < nuevo -> derecha

    ; IZQUIERDA
    MOV EDX, EAX
    ADD EDX, IZQ            ; EDX = &actual->izq
    MOV EAX, [EAX + IZQ]
    JMP ciclo_add_nodo

derecha:
    MOV EDX, EAX
    ADD EDX, DER            ; EDX = &actual->der
    MOV EAX, [EAX + DER]
    JMP ciclo_add_nodo

add_nodo:
    MOV [EDX], EBX          ; enlaza el nodo nuevo

    POP EDX
    POP ECX
    POP EBX
    POP EAX
    POP BP
    RET
SEP EQU " "
SIZE EQU 12
VALOR EQU 0
IZQ EQU 4
DER EQU 8
NULL EQU -1
PREORDER_SHOW:
    PUSH BP
    MOV BP, SP
    PUSH EAX
    PUSH EBX
    PUSH ECX
    PUSH EDX

    MOV EBX, [BP + 8]
    MOV EBX, [EBX]

    CMP EBX, NULL
    JZ fin_preorder_show

ciclo_mostrar:
    MOV EDX, EBX
    ADD EDX, VALOR
    LDL ECX, 1
    LDH ECX, 4
    MOV EAX, 0x01
    SYS 0x2

    MOV EDX, KS
    ADD EDX, SEP
    SYS 0x4

    MOV EDX, EBX
    ADD EDX, IZQ
    PUSH EDX
    CALL PREORDER_SHOW
    ADD SP, 4

    MOV EDX, EBX
    ADD EDX, DER
    PUSH EDX
    CALL PREORDER_SHOW
    ADD SP, 4

fin_preorder_show:
    POP EDX
    POP ECX
    POP EBX
    POP EAX
    POP BP
    RET

INORDER_SHOW:
    PUSH BP
    MOV BP, SP
    PUSH EAX
    PUSH EBX
    PUSH ECX
    PUSH EDX

    MOV EBX, [BP + 8]
    MOV EBX, [EBX]

    CMP EBX, NULL
    JZ fin_inorder_show

ciclo_mostrar:
    MOV EDX, EBX
    ADD EDX, IZQ
    PUSH EDX
    CALL INORDER_SHOW
    ADD SP, 4

    MOV EDX, EBX
    ADD EDX, VALOR
    LDL ECX, 1
    LDH ECX, 4
    MOV EAX, 0x01
    SYS 0x2

    MOV EDX, KS
    ADD EDX, SEP
    SYS 0x4

    MOV EDX, EBX
    ADD EDX, DER
    PUSH EDX
    CALL INORDER_SHOW
    ADD SP, 4

fin_inorder_show:
    POP EDX
    POP ECX
    POP EBX
    POP EAX
    POP BP
    RET

POSTORDER_SHOW:
    PUSH BP
    MOV BP, SP
    PUSH EAX
    PUSH EBX
    PUSH ECX
    PUSH EDX

    MOV EBX, [BP + 8]
    MOV EBX, [EBX]

    CMP EBX, NULL
    JZ fin_POSTORDER_SHOW

ciclo_mostrar:
    MOV EDX, EBX
    ADD EDX, IZQ
    PUSH EDX
    CALL POSTORDER_SHOW
    ADD SP, 4

    MOV EDX, EBX
    ADD EDX, DER
    PUSH EDX
    CALL POSTORDER_SHOW
    ADD SP, 4

    MOV EDX, EBX
    ADD EDX, VALOR
    LDL ECX, 1
    LDH ECX, 4
    MOV EAX, 0x01
    SYS 0x2

    MOV EDX, KS
    ADD EDX, SEP
    SYS 0x4

fin_POSTORDER_SHOW:
    POP EDX
    POP ECX
    POP EBX
    POP EAX
    POP BP
    RET

;--------------------------------------------------------------------------------------------------
; INTREE: devuelve en EAX
;   1 si el valor está en el árbol
;   0 si el valor no está en el árbol
;
;   PUSH <<ROOT*>>     ; contenido de la variable ROOT (el nodo)
;   PUSH <<VALOR>>
;   CALL INTREE
;   ADD SP, 8
;--------------------------------------------------------------------------------------------------

INTREE:
    PUSH BP
    MOV BP, SP
    PUSH EBX
    PUSH ECX

    MOV EBX, [BP + 8]       ; valor buscado
    MOV ECX, [BP + 12]      ; ECX = nodo actual (ROOT*)
    MOV EAX, 0

    CMP ECX, NULL
    JZ fin_intree

    CMP [ECX + VALOR], EBX
    JNZ llamada_recursiva
    MOV EAX, 1
    JMP fin_intree

llamada_recursiva:
    PUSH [ECX + IZQ]        ; hijo izquierdo (NODO*)
    PUSH EBX
    CALL INTREE
    ADD SP, 8

    CMP EAX, 1
    JZ fin_intree

    PUSH [ECX + DER]        ; hijo derecho (NODO*)
    PUSH EBX
    CALL INTREE
    ADD SP, 8

fin_intree:
    POP ECX
    POP EBX
    POP BP
    RET

;---------------------------------------------------------------------------------------------------------
;TREE_HEIGHT: Retorna la altura del arbol en eax
;   PUSH <<**ROOT>>
;   CALL TREE_HEIGHT
;   ADD SP, 4
;---------------------------------------------------------------------------------------------------------
TREE_HEIGHT:
    PUSH BP
    MOV BP, SP
    PUSH EBX
    PUSH ECX
    PUSH EDX

    MOV EBX, [BP + 8]
    MOV EBX, [EBX]
    MOV EAX, -1

    CMP EBX, NULL
    JZ fin_tree_height

    MOV EDX, EBX
    ADD EDX, IZQ
    PUSH EDX
    CALL TREE_HEIGHT
    ADD SP, 4
    MOV ECX, EAX

    MOV EDX, EBX
    ADD EDX, DER
    PUSH EDX
    CALL TREE_HEIGHT
    ADD SP, 4

    CMP ECX, EAX
    JN fin_tree_height
    MOV EAX, ECX
fin_tree_height:

    ADD EAX, 1
    POP EDX
    POP ECX
    POP EBX
    MOV SP, BP
    POP BP
    RET
