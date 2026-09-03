3. Dado un valor decimal ingresado por teclado, imprimir su valor binario equivalente como una 
secuencia de ceros y unos. 

inicio:
    //LECTURA DECIMAL;
    mov edx, DS;    
    add edx,0;
    ldh ecx, 0x04;
    ldl ecx, 0x01;
    mov eax, 0x01;
    sys 0x1;

    //Inicilizo i=0
    mov edx, DS;
    add edx,2;
    mov [edx],0;

    //while(decimal != 0)
    mov edx,DS;
    add edx,0;
    mov eax,edx; //eax apunta a decimal; 

    mov edx,DS;
    add edx,4;
    mov ebx,edx; //ebx apunta a binario[];
    
    mov edx,DS;
    add edx,2;
    mov [edx],0;
    mov efx,edx; //efx apunta a i;


bucle_while:

    cmp [eax], 0;
    jz fin_while;

    div [eax],2;
    mov [eax], ac;
    mov [ebx],cc;
    add ebx,4;
    add [efx],1;

    jmp bucle_while;

fin_while;

imprimir:
    mov edx, ebx;
    ldh ecx, 0x04;
    ldl ecx ,0x01;
    mov eax, 0x01;

    bucle_mostar:
        cmp [efx],0;
        jz fin_mostrar:

        sub edx,4;
        sub [efx],1;
        sys 0x1;
        jmp bucle_mostar;
    fin_mostrar:

