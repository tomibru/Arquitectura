/*17. Realizar una función en C para pasar un string ASCII a mayúsculas, utilizando máscaras y 
aprovechando la codificación ASCII (no utilizar la función de librerías como toupper() o 
strupr()). */
#include <string.h>
void mayusculas(char cad[]){
    int i,n = strlen(cad);
    for(i=0 ; i<n ; i++)
        cad[i] = cad[i] & ~32;
}