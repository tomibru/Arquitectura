13. Validar si una matriz es simétrica respecto de su diagonal principal.

inicio:
    mov EAX, 0 ; i=0
    mov EAX, DS
    add EAX, 128
    mov [EAX], 0 ; Asumimos verdadero

BUCLE_FILAS:
    CMP EAX, [DS]
    jz Fin_Filas

    mov EBX, EAX ; j=i+1
    add EBX, 1   

BUCLE_COLUMNAS:
    cmp EBX, [DS]
    jz Fin_columnas

    mov EDX, EAX
    mul EDX, [DS]
    add edx, EBX
    mul EDX, 4       ;EDX = M[i,j]

    mov ECX, EBX
    mul ECX, [DS] //Preguntar
    add ecx, EAX     
    mul ECX, 4      ;ECX = M[j,i]

    add EDX, DS
    add ECX, DS

    cmp [EDX], [ECX]
    jnz no_simetrica

    add EBX, 1
    jmp BUCLE_COLUMNAS

Fin_columnas:
    add EAX, 1
    jmp BUCLE_FILAS

no_simetrica:
    mov EAX, DS
    add EAX, 128
    mov [EAX], 0

Fin_filas
    stop