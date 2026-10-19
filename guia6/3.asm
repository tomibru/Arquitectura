a.  int ascendente(lista* L) { 
  if (L == NULL) return 1; 
   
  register lista* ant; 
   
  do { 
    ant = L; 
    L = L->sig; 
  } while (L != NULL && ant->dato <= L->dato); 
   
  return L == NULL; 
} 

ascendente:
    PUSH BP
    MOV BP, SP
    PUSH EBX
    PUSH ECX
    PUSH EDX

    MOV ECX, [BP + 8]
    MOV EAX, 1
    CMP [ECX], -1
    JZ fin_ascendente

    MOV EBX, [ECX]
do_while:
    MOV ECX, EBX
    MOV EBX, [ECX + 4]

    CMP EBX, -1
    JZ fin_ascendente

    MOV EDX, [EBX]
    CMP [ECX], EDX
    JP falso
    JMP do_while
falso:
    MOV EAX, 0
fin_ascendente:
    POP EDX
    POP ECX
    POP EBX
    POP BP
    RET


b.  lista** maximo(lista** L) { 
  if (*L != NULL) { 
    register list** max = maximo(&(*L)->sig); 
     
    if (*max != NULL && (*L)->dato < (*max)->dato) 
      L = max; 
  } 
   
  return L; 
} 

