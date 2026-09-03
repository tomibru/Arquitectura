/*18. Realizar una función en C para pasar un string ASCII a un integer, utilizando máscaras (no 
utilizar funciones de librerías como atoi()). */
int inciso_18(char cad[]){
    int num=0,i, cadlen = strlen(cad), digito;
    for(i = 0;i < cadlen; i++){
        digito = (cad[i] & ~48);
        num= (num*10)+digito;
    }
    return num;
}