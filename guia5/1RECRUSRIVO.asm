    PUSH base;
    PUSH exp;
    CALL potencia;

potencia:
    PUSH BP;
    MOV BP, SP; 
    PUSH AC;

    MOV EAX, [BP + 4];
    CMP EAX, 0;
    JNZ paso_recursivo;

    MOV EAX, 1; caso base
    JMP fin_potencia;

paso_recursivo:
    MOV EAX, [BP + 8];
    PUSH EAX;

    MOV EAX [BP + 4];
    SUB EAX, 1;
    PUSH EAX;

    CALL potencia; llamada recursiva -> Resultado queda en eax
    ADD SP, 8; limpio los dos parametros de la subllamada

    MOV EBX, [BP + 8]; base 
    MUL EAX,EBX;
fin_potencia:
    POP AC;
    MOV SP, BP;
    POP BP;
    RET
  

