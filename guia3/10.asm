inicio: mov edx, DS ; EDX -> V[0]
        mov EFX, 0  ; EFX = n = 0

BUCLE_LECTURA:
        MOV EAX, 0x01
        LDU ECX, 0x04
        LDL ECX, 0x01
        SYS 0x1

        MOV EAX, [EDX]
        CMP EAX, 0
        JN FIN_LECTURA

        add edx, 4  ; V[n++]
        add EFX, 1  ; n++
        jmp BUCLE_LECTURA

FIN_LECTURA:
        mov EBX, 0

BUCLE_CMP:
        CMP EBX, EFX
        JZ FIN_CMP
        MOV EDX, DS
        ADD EDX, 128
        MOV EAX, 0x01
        LDH ECX, 0x04
        LDL ECX, 0x01
        SYS 0x1

        MOV EAX, [EDX]

        MOV EDX, DS

BUCLE_BUSQUEDA:
        CMP EAX, [EDX]
        JZ FIN_BUSQUEDA

        add edx, 4
        jmp BUCLE_BUSQUEDA

FIN_BUSQUEDA:
        mov [EDX], -1
        add EBX, 1
        jmp BUCLE_CMP

FIN_CMP:
        MOV EDX, DS

BUCLE_FINAL:
        CMP [EDX], -1
        JNZ FIN_FINAL
        add EDX, 4
        jmp BUCLE_FINAL

FIN_FINAL:
        MOV EAX, 0x1
        LDU ECX, 0x04
        LDL ECX, 0x01
        SYS 0x2

        STOP