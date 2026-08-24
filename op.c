#include <stdio.h>
#include <string.h>

int Transformar(char cad[]){
    int num=0,i, cadlen = strlen(cad), digito;
    for(i = 0;i < cadlen; i++){
        digito = (cad[i] & ~48);
        num= (num*10)+digito;
    }
    return num;
}
int opSuma(int a, int b){return a + b;}
int opAnd(int a, int b){return a & b;}
int opNothing(int a,int b){return a;}
int opNot(int a,int b){return ~a;}

int main(int argc, char *argv[]){
    int operacion,A,B=0,resultado;
    int (*operaciones[4])(int,int)={opSuma,opAnd,opNothing, opNot};
    if(argc < 3){
        printf("Falta parametro A\n");
        return 1;
    }
    else{
        operacion = Transformar(argv[1]);
        if (operacion < 0 || operacion > 3) {
            printf("error operacion invalida\n");
            return 1;
        }
        A = Transformar(argv[2]);
        if(argc >= 4)
            B = Transformar(argv[3]);

        resultado = operaciones[operacion-1](A,B);
        printf("%d\n",resultado);

        return 0;
    }

}