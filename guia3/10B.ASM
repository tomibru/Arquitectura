INICIO:        
        MOV EBX, 0    ; n=0
        MOV EFX, 0    ; suma=0

BUCLE_LECTURA:
        MOV EDX, DS
        MOV EAX, 0x01
        LDH ECX, 0x04
        LDL ECX, 0x01
        SYS 0x1

        CMP [EDX], 0
        JN FIN_LECTURA
        add EBX, 1
        add EFX, [EDX]
        jmp BUCLE_LECTURA

FIN_LECTURA:
        MOV EEX, 1    ; i=1

BUCLE_RESTA:
        CMP EEX, EBX
        JZ FIN_RESTA

        MOV EDX, DS
        MOV EAX, 0x01
        LDH ECX, 0x04
        LDL ECX, 0x01
        SYS 0x1

        SUB EFX, [EDX]
        add EEX, 1
        JMP BUCLE_RESTA

FIN_RESTA:
        MOV EDX, DS
        MOV [EDX], EFX
        MOV EAX, 0x01
        LDH ECX, 0x04
        LDL ECX, 0x01
        SYS 0x2

FIN:
        STOP