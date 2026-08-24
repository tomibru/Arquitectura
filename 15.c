/* 15. Realizar una función en C en la cual ingresa un valor entero de 2 bytes (short int), 
donde se codifica una fecha, e imprima la misma en formato ISO 8601 (YYYY-MM-DD).  
Los 2 bytes (16 bits) se utilizan del siguiente modo para codificar la fecha: los 5 bits más 
significativos para el día (de 1 a 31), seguidos de 4 bits para el mes (de 1 a 12) y los 7 bits 
menos significativos para el año (de 0 a 99). Si el año es mayor a 50, se asume que está 
entre 1950 y 1999, si es menor a o igual a 50, se considera como del 2000 al 2050.   */
void mostrarFecha(short int fechaBin){
    int dia, mes , ano;

    dia = (fechaBin & 0xF800) >> 11;
    mes = (fechaBin & 0x0780) >> 7;
    ano = (fechaBin & 0x007F);
    if(ano > 50)
        ano += 1900;
    else
        ano += 2000;    
}