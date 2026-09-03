typedef char cad[10];
void semana(char c){
    cad diasSemana[7]={"Domingo", "Lunes", "Martes", "Miercoles", "Jueves", "Viernes", "Sabado"};
    int i;

    for(i=0;i<7;i++){
        if((c >> i) & 1){
            printf("%s \n", diasSemana[i]);
        }
    }
}