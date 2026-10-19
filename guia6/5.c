typedef nodo * Lista;
Lista mezclar(Lista l1, Lista l2){
    if(l1 == NULL)
        return l2;
    if(l2 == NULL)
        return l1;

    Lista aux1 = l1;
    Lista aux2 = l2;
    Lista lFinal;
    if(aux1->valor <= aux2->valor){
        lFinal = aux1;
        aux1 = aux1->sig;
    } 
    else{
        lFinal = aux2;
        aux2 = aux2->sig;
    } 
    Lista auxF = lFinal;

    while(aux1 != NULL && aux2 != NULL){
        if(aux1->valor <= aux2->valor){
            auxF->sig = aux1;
            aux1 = aux1->sig;
        } 
        else{
            auxF->sig = aux2;
            aux2 = aux2->sig;
        }
        auxF= auxF->sig; 
    }
    while(aux1 != NULL){
        auxF->sig = aux1;
        aux1 = aux1->sig;
        auxF= auxF->sig;        
    }
    while(aux2 != NULL){
        auxF->sig = aux2;
        aux2 = aux2->sig;
        auxF= auxF->sig;        
    }
    auxF->sig = NULL;
    return lFinal;
    
}

typedef struct nodo {
    int valor;
    struct nodo *sig;
} nodo;

typedef nodo *Lista;

// l1 = &Y1, l2 = &Y2 (direcciones de las variables cabeza)
void mezclar(Lista *l1, Lista *l2) {
    Lista aux1 = *l1;
    Lista aux2 = *l2;
    Lista lFinal, auxF;

    // casos base
    if (aux1 == NULL) {
        lFinal = aux2;
    } else if (aux2 == NULL) {
        lFinal = aux1;
    } else {
        // primer nodo
        if (aux1->valor <= aux2->valor) {
            lFinal = aux1;
            aux1 = aux1->sig;
        } else {
            lFinal = aux2;
            aux2 = aux2->sig;
        }
        auxF = lFinal;

        // ciclo principal
        while (aux1 != NULL && aux2 != NULL) {
            if (aux1->valor <= aux2->valor) {
                auxF->sig = aux1;
                aux1 = aux1->sig;
            } else {
                auxF->sig = aux2;
                aux2 = aux2->sig;
            }
            auxF = auxF->sig;
        }

        // enlazo lo que sobra (uno de los dos ya es NULL)
        if (aux1 != NULL)
            auxF->sig = aux1;
        else
            auxF->sig = aux2;
    }

    *l1 = lFinal;   // Y1 = lista resultante
    *l2 = NULL;     // Y2 = vacía (sus nodos ahora pertenecen a Y1)
}