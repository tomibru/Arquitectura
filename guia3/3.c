int main(){
    /*3. Dado un valor decimal ingresado por teclado, imprimir su valor binario equivalente como una 
    secuencia de ceros y unos. */
    int decimal,resto,i=0;
    int binario[32];
    scanf("%d", &decimal);

    while(decimal != 0){
        resto = decimal % 2;
        decimal /= 2;
        binario[i] = resto;
        i++;
    }
    while(i>0){
        i--;
        printf("%d ", binario[i] );
    }
  
    return 0;
}