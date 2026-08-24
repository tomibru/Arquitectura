#include <stdio.h>
#include <string.h>
#define max 50

int main(int argc, char *argv[]){
    FILE *origen,*destino;
    int byte , i=0 , claveLen = strlen(argv[1]);
    char clave[max];

    if(argc == 4){
        strcpy(clave,argv[1]);
        origen = fopen(argv[2],"rb");
        destino = fopen(argv[3],"wb");

        if(origen != NULL && destino != NULL){
            while((byte = fgetc(origen)) != EOF){
                fputc((byte ^ clave[i]),destino);
                if(i == (claveLen-1))
                    i=0;
                else
                    i++;
            }
            fclose(origen);
            fclose(destino);
        }
        else
            printf("Archivo origen o destino no existe");
    }
    else
        printf("Error en la cantidad de argumentos");
}