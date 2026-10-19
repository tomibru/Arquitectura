void invertir(lista *l, lista *linv){
    lista ant= NULL, act = *l, sig;
    while(act != NULL){
        sig = act->sig;
        act->sig = ant;
        ant = act;
        act = sig;
    }
    *l = ant;
}