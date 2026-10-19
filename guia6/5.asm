;5. Escribir una subrutina que reciba dos listas de números (positivos, ordenados en forma 
;creciente) y las intercale formando una lista ordenada. 
;a. Creando una nueva lista.  
;b. Reutilizando los mismos nodos (modificando las listas originales).  

MEZCLAR:
    PUSH BP
    MOV BP, SP
    PUSH EBX; AUX1
    PUSH ECX; AUX2
    PUSH EDX; AUXF
    PUSH EFX;

    MOV EBX, [BP + 12]
    MOV ECX, [BP + 8]

    CMP EBX, -1
    JZ l1_vacia

    CMP ECX, -1
    JZ l2_vacia
    JMP ninguna_vacia
l1_vacia:
    MOV EAX, ECX
    JMP fin_mezclar
l2_vacia:
    MOV EAX, EBX
    JMP fin_mezclar

ninguna_vacia:
    MOV EFX, [EBX]
    CMP EFX, [ECX] ; VALOR1 - VALOR2
    JNN valor2

    MOV EAX, EBX
    MOV EDX, EBX
    MOV EBX, [EBX + 4]
    JMP ciclo_mezclar
valor2:
    MOV EAX, ECX
    MOV EDX, ECX
    MOV ECX, [ECX + 4]

ciclo_mezclar:
    CMP EBX, -1
    JZ fin_ciclo_mezclar
    CMP ECX, -1
    JZ fin_ciclo_mezclar

    MOV EFX, [EBX]
    CMP EFX, [ECX] ; VALOR1 - VALOR2
    JNN valor2_ciclo

    MOV [EDX + 4], EBX
    MOV EBX, [EBX + 4]
    MOV EDX, [EDX + 4]
    JMP ciclo_mezclar
valor2_ciclo:
    MOV [EDX + 4], ECX
    MOV ECX, [ECX + 4]
    MOV EDX, [EDX + 4]
    JMP ciclo_mezclar 
fin_ciclo_mezclar:
    
vaciar1:
    CMP EBX, -1
    JZ fin_vaciar1
    
    MOV [EDX + 4], EBX
    MOV EBX, [EBX + 4]
    MOV EDX, [EDX + 4]
    JMP vaciar1
fin_vaciar1:

vaciar2:
    CMP ECX, -1
    JZ fin_vaciar2
    
    MOV [EDX + 4], ECX
    MOV ECX, [ECX + 4]
    MOV EDX, [EDX + 4]
    JMP vaciar2
fin_vaciar2:
    MOV [EDX + 4],-1
fin_mezclar:
    POP EFX
    POP EDX
    POP ECX
    POP EBX
    POP BP
    RET
    

;b. Reutilizando los mismos nodos (modificando las listas originales).  