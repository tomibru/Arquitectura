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
    MOV b[EAX], BL;
    CMP BL,0;
    JZ fin_scpy;

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

SCMP:
    PUSH BP
    MOV BP,SP
    PUSH EBX
    PUSH ECX
    PUSH EDX

    MOV EDX, [BP + 12]
    MOV ECX, [BP + 8]

ciclo_cmp:
    MOV EAX, 0
    MOV EBX,0

    MOV AL, b[EDX]; AL = COD1
    MOV BL, b[ECX]; BL = COD2
    SUB EAX, EBX
    JNZ fin

    CMP EBX, 0
    JZ fin
    CMP AL, 0
    JZ fin

    ADD  EDX, 1
    ADD ECX, 1
    JMP ciclo_cmp
fin:
    POP EDX
    POP ECX
    POP EBX
    MOV SP,BP
    POP BP
    RET

SCAT:
    PUSH BP
    MOV BP,SP
    PUSH EAX
    PUSH EBX
    PUSH ECX

    MOV EAX, [BP + 12]
    MOV EBX, [BP + 8]
ciclo:
    CMP b[EAX], 0
    JZ fin_ciclo
    ADD EAX, 1
    JMP ciclo
fin_ciclo:
ciclo_str2:
    MOV CL, b[EBX]
    CMP CL, 0
    JZ fin_str2
    MOV b[EAX], CL
    ADD EAX, 1
    ADD EBX, 1
    JMP ciclo_str2
fin_str2:
    MOV [EAX], 0

    POP ECX
    POP EBX
    POP EAX
    MOV SP,BP
    POP BP
    RET

SPLIT:
    PUSH BP
    MOV BP,SP
    PUSH EAX
    PUSH EBX
    PUSH ECX
    PUSH EDX

    MOV EAX, l[BP+ 16]; EAX = string
    MOV ECX, l[BP + 12]; ECX = CHAR
    MOV EDX, l[BP + 8]; EDX = PUNTERO A ARRAY
   
    MOV [EDX], EAX
    ADD EDX, 4

ciclo:  
    MOV BL, b[EAX]
    
    CMP BL, 0
    JZ fin

    CMP BL, CL
    JZ siguiente

    ADD EAX, 1
    JMP ciclo
siguiente:
    MOV b[EAX], 0
    ADD EAX, 1
    MOV l[EDX], EAX
    ADD EDX, 4
    JMP ciclo

fin: 
    MOV l[EDX], -1

    POP EDX
    POP ECX
    POP EBX
    POP EAX
    MOV SP,BP
    POP BP
    RET

STRIM:
    PUSH BP
    MOV BP, SP
    PUSH EAX
    PUSH EBX
    PUSH ECX

    MOV EAX, l[BP + 8]          ; escritor (inicio original)
    MOV EBX, EAX                ; lector

principio:
    CMP b[EBX], 32
    JNZ fin_principio
    ADD EBX, 1
    JMP principio

fin_principio:
    CMP b[EBX], 0               ; vacío o solo espacios
    JZ sobreescribir_original

    MOV ECX, EBX
ciclo_hasta_final:
    CMP b[ECX], 0
    JZ llegue_al_final
    ADD ECX, 1
    JMP ciclo_hasta_final

llegue_al_final:
    SUB ECX, 1                  ; último carácter
ciclo_borrar_espacios:
    CMP b[ECX], 32
    JNZ fin_borrar_espacios
    SUB ECX, 1
    JMP ciclo_borrar_espacios

fin_borrar_espacios:
    ADD ECX, 1
    MOV b[ECX], 0               ; nuevo terminador

sobreescribir_original:
    MOV CL, b[EBX]
    MOV b[EAX], CL
    CMP CL, 0
    JZ fin
    ADD EBX, 1
    ADD EAX, 1
    JMP sobreescribir_original

fin:
    POP ECX
    POP EBX
    POP EAX
    POP BP
    RET