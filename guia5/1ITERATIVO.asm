;1. Hacer una subrutina que calcule la potencia de dos números pasados como parámetro. Resolver 
;en forma iterativa y recursiva.

PUSH 2;base
PUSH 3;exp
CALL potencia;

potencia:
    PUSH BP;
    MOV BP,SP;
    SUB SP, 4; Reservamos lugar para resultado
    PUSH AC;
    
    MOV EAX, [BP + 8]; eax = base
    MOV EFX, EAX;  acumulador, lo incializamos en la base
    MOV ECX, [BP + 4]; ecx = exp;
    MOV EBX , 1; ebx = 1, variable de control del ciclo
ciclo_potencia:
    CMP EBX, ECX;
    JZ fin_ciclo;
    
    MUL EFX,EAX;
    ADD EBX, 1;
    JMP ciclo_potencia;
fin_ciclo:
    MOV EFX, [BP - 4]; resultado = EFX
    POP AC;
    ADD SP, 4;
    MOV SP,BP;
    POP BP;
    RET;




