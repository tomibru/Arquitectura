/*16. Realizar una función en C que reciba día, mes y año como parámetros enteros y devuelva 
un short int con la fecha codificada al igual que en el ejercicio anterior. */

short int fecha_set( int dia, int mes, int ano){
    short int fecha;
    if (ano >= 2000) {
        ano -= 2000;
    } else {
        ano -= 1900;
    }

    resultado = (dia<<11) | (mes << 7) | ano;

}