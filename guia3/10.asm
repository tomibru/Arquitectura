inicio:
    mov efx,DS;
    add efx,0;//Indice

    mov ebx,0;//Contador n

bucle_lectura:

    ldh ecx,0x04;
    ldl ecx,0x01;
    mov eax, 0x01;
    sys 0x1;
    
    cmp edx,0;
    jn fin_bucle;

    add efx,1;
    mov [efx], edx;
    add efx, 4;
    jmp bucle_lectura;

fin_bucle:
    mov eex,1;
bucle_lectura2:
    cmp eex,ebx;
    jz fin_lectura2;

    ldh ecx,0x04;
    ldl ecx,0x01;
    mov eax, 0x01;
    sys 0x1;
    move eax, 0;
    bucle_busqueda:
        
    fin_busqueda:

    jmp bucle_lectura2

fin_lectura2:



