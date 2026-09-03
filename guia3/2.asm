/*2. Dada una lista de ceros y unos que se ingresan por teclado, imprimir el valor decimal 
equivalente. El fin de la lista se indica con un número distinto de 0 y 1.  
a. La lista se ingresa del bit menos significativo al más significativo. 
b. La lista se ingresa del bit más significativo al menos significativo. */

//----2A)

inicio:
    mov edx , DS;
    add edx, 5;//Cont
    mov [edx], 0;
    
    mov edx , DS;
    add edx, 6;//Suma
    mov [edx] 0;

bucleLectura:
    mov edx , DS;
    add edx ,4;
    ldh ecx, 0x04;
    ldl ecx, 0x01;
    mov eax, 0x01;
    sys 0x1;

    mov eax, edx;
    cmp eax ,0;
    jz procesar;
    
    cmp eax , 1;
    jz procesar;
    jnz fin;

procesar:
    mov edx ,DS;
    add edx, 5;
    mov efx ,edx;
    add [efx] ,1; //Incremento cont y lo dejo en efx
    
    move edx,DS;
    add edx, 7;
    mov ecx, edx; //En ecx coloco controlador del ciclo for
    mov [ecx] ,1;

    bucle_for:
        cmp [efx],[ecx];
        jz fin_for

        mul eax, 2;
        add [ecx], 1;//Incremento indice auxiliar
        jmp bucle_for;

    fin_for:

    mov edx, DS;
    add edx, 6; //Suma
    add [edx], eax;
    
    jmp bucleLectura;

fin:
    mov edx, DS;
    add edx, 6;
    ldh ecx, 0x04;
    ldl ecx ,0x01;
    mov eax, 0x01;
    sys 0x1;



