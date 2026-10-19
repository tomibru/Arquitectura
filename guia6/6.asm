INVERTIR:
    PUSH BP
    MOV BP, SP
    PUSH EAX
    PUSH EBX
    PUSH ECX
    PUSH EDX

    MOV EAX, -1
    MOV EDX, [BP + 8]
    MOV EBX, [EDX]

ciclo_invertir:
    CMP EBX, -1
    JZ fin_ciclo_invertir
    
    MOV ECX, [EBX + 4]
    MOV [EBX + 4], EAX
    MOV EAX, EBX
    MOV EBX, ECX
    JMP ciclo_invertir
fin_ciclo_invertir:
    MOV [EDX], EAX

    POP EDX
    POP ECX
    POP EBX
    POP EAX
    POP BP
    RET