SLEN:
    PUSH BP;
    MOV BP,SP;
    PUSH EAX;
    PUSH EDX; preservamos los valores de los registros usados por si en el main tenian otro proposito, ESTOS SON COMUNES EN LLAMADA AL SYS, aparte en ecx retornamos

    MOV ECX,0;
    MOV EDX, [BP + 8];
bucle_slen:
    MOV AL, b[EDX];
    CMP AL, 0;
    JZ fin_slen;

    ADD ECX, 1;
    ADD EDX,1; avanzo 1 byte
    JMP bucle_slen;
fin_slen;
    POP EDX;
    POP EAX;
    MOV SP,BP;
    POP BP;
    RET

;SCPY recibe cad1 y cad2 (2 direcciones a KS), se copia cad1 en la direccion de cad2
SCPY:
    PUSH BP;
    MOV BP,SP;
    PUSH EAX;
    PUSH EDX;
    PUSH EBX;

    MOV EDX, [BP + 12]; EDX = CAD1
    MOV EAX ,[BP + 8]; EAX = CAD2
    
bucle_scpy:
    MOV BL, b[EDX];
    CMP BL,0;
    JZ fin_scpy;

    MOV b[EAX], BL;
    ADD EDX, 1;
    ADD EAX, 1;

    JMP bucle_scpy;
fin_scpy:

    POP EBX;
    POP EDX;
    POP EAX;
    MOV SP, BP;
    POP BP;
    RET;



