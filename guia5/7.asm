7. Indicar en los siguientes casos de invocación a funciones, cómo sería la invocación a la 
subrutina en assembler. Considerar que las variables a, b y c se encuentran en las posiciones de 
memoria BP-4, BP-8 y BP-12, respectivamente, y corresponden a variables locales de la función 
que invoca.  
a.   proce(a, b, c); 

    PUSH l[BP-4]
    PUSH l[BP-8]
    PUSH l[BP-12]
    CALL proce
    ADD SP, 12

b.   c = func(*a, b);

    MOV EAX, l[BP - 4]
    PUSH [EAX]
    PUSH l[BP - 8]
    CALL func
    ADD SP, 8
    MOV l[BP - 12], EAX

c.   proce(&a, *b, *c);

    MOV EAX, BP
    SUB EAX, 4
    PUSH EAX
    MOV EAX, [BP-8]
    PUSH [EAX]
    MOV EAX, [BP-12]
    PUSH [EAX]
    CALL proce
    ADD SP, 12


d.   *c = func(a + b); 

    MOV EAX, l[BP-4]
    ADD EAX, [BP- 8]
    PUSH EAX
    CALL func
    ADD SP, 4
    
    MOV EDX, [BP - 12]
    MOV [EDX], EAX
