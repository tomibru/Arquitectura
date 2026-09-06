//8. Se ingresan una serie de números naturales, terminada con un número negativo. Mostrar por 
cada número ingresado la cantidad de bits en 1 que contiene su representación binaria. 

//9. Modificar el ejercicio anterior de modo que antes de ingresar la lista se lea un valor que 
represente una máscara con la cual se debe realizar un AND a cada número de la lista antes de 
calcular la cantidad de bits en 1.  

//9)
inicio:
    mov edx,DS;
    add edx,4;
    ldh ecx,0x04;
    ldl ecx, 0x01;
    mov eax, 0x01;
    sys 0x1;

    mov efx, [edx];

bucle_lectura:
    mov edx,DS;
    add edx,4;
    ldh ecx,0x04;
    ldl ecx, 0x01;
    mov eax, 0x01;
    sys 0x1;

    cmp [edx], 0;
    jn fin;

    mov eax,edx;

    mov edx, DS;
    add edx, 3;
    mov [edx],0;
    mov ebx,edx;

    and [eax],efx;

    //Div guarda cociente en cc y resto en ac
    bucle_binario:
        cmp [eax],0;
        jz fin_binario;

        div [eax],2;
        add [ebx], ac;
        mov [eax],cc;
        jmp bucle_binario;
    fin_binario:

    mov edx,DS;
    mov [edx], ebx;
    ldh ecx,0x04;
    ldl ecx, 0x01;
    mov eax, 0x01;
    sys 0x2;

    jmp bucle_lectura
fin:
    stop