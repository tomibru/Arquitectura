;Interpretar una operación matemática escrita en notación polaca inversa y calcular el resultado.   

\\INCLUDE 3.asm
\\DATA 100
\\STACK 2048
DIVERR EQU "Error: Divison por cero\n"
BUF EQU 0

POLACA:
    PUSH BP
    MOV BP, SP
    PUSH EAX
    PUSH EBX
    PUSH ECX
    PUSH EDX
    PUSH EEX

    MOV ECX, l[BP + 8]; argc
    MOV EDX, l[BP + 12]; argv
    
    CMP [EDX], -1
    JZ fin
    ADD EDX, 4
    SUB ECX, 1

ciclo:
    CMP ECX, 0
    JZ mostrar
    
    MOV EBX, l[EDX]
    MOV EEX, 0
    MOV EL, b[EBX]

    CMP b[EBX + 1], 0
    JNZ numero
    CMP EEX, '+'
    JZ operador
    CMP EEX, '-'
    JZ operador
    CMP EEX, '*'
    JZ operador
    CMP EEX, '/'
    JZ operador

numero:
    PUSH EBX
    CALL STRNUM
    ADD SP, 4
    PUSH EAX
    JMP siguiente

operador:
    POP EBX
    POP EAX
    CMP EEX, '+'
    JNZ no_suma
    ADD EAX, EBX
    PUSH EAX
no_suma:
    CMP EEX, '-'
    JNZ no_resta
    SUB EAX, EBX
    PUSH EAX
no_resta:
    CMP EEX, '*'
    JNZ no_mul
    MUL EAX, EBX
    PUSH EAX
no_mul:
    CMP EBX, 0
    JZ div_cero
    DIV EAX, EBX
    PUSH EAX

siguiente:
    ADD EDX, 4
    SUB ECX,1
    JMP ciclo

mostrar:
    POP EAX                   ; resultado
    MOV EBX, DS
    ADD EBX, BUF
    PUSH EAX                  ; NUMSTR(n, buffer)
    PUSH EBX
    CALL NUMSTR
    ADD SP, 8
    MOV EDX, DS
    ADD EDX, BUF
    SYS 4
    JMP salir

div_cero:
    MOV EDX, KS
    ADD EDX, ERRDIV
    SYS 4

salir:
    PUSH EEX
    PUSH EDX
    PUSH ECX
    PUSH EBX
    PUSH EAX
    MOV SP, BP                ; descarta lo que haya quedado apilado
    POP BP
    RET

