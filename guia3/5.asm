//5. Utilizando el algoritmo anterior, construya un programa que calcule el factorial de un número 
ingresado por teclado.

lectura:
    ldh ecx, 0x04;
    ldl ecx, 0x01;
    mov eax, 0x01;
    sys 0x1;

    mov ebx, edx;

    //Inicializo eax
    mov efx, ebx;
    sub ebx,1;
    mov eax,0;

ciclo_for:
    cmp ebx,0;
    jz fin_for:

    mov ecx,ebx;
    mov efx,eax;
    ciclo_mul:
        cmp ecx,0;
        jz fin_mul;

        add eax, efx;
        sub ecx, 1;
        jmp ciclo_mul;
    fin_mul:

    sub ebx, 1;
    jmp ciclo_for;
fin_for:
    mov edx, eax;
    ldh ecx, 0x04;
    ldl ecx, 0x01;
    mov eax, 0x01;
    sys 0x2;
fin:
    stop

