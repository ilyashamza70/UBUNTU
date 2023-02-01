#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <string.h>

int main(int argc,char** argv){
    if(argc <= 2){
        printf("ERROR: numero di parametri passati è %d, mentre deve essere almeno 2 \n", argc - 1);
        exit(1);
    }
    //Nel caso ho almeno due parametri proseguo con verifica 
    //Devo verificare che il primo parametro sia un intero

    //Il primo deve essere un numero

int ls= argv[1][0];
printf("Il valore di 1 param è %s \n",argv[1]);
printf("Ora verifico se è un numero \n");

int i=0;
int size=strlen(argv[1]);
while(i < size){
    if(argv[1][i] < '0' || argv[1][i] > '9'){
        //Allora esci non è numero
        printf("ERROR: il primo parametro %s non è un numero \n",argv[1]);
        exit(2);
    }
    ++i;
}

int sizel =(sizeof(argv[1])/ sizeof(int));
printf("SI è un numero di sizeof = %d \n", sizel);


printf("SI è un numero di valore = %s \n",argv[1]);



printf("Il valore di 2 param è %s \n",argv[2]);
printf("Ora verifico se è una stringa \n");

i=0;
while(argv[2][i] != '\0'){
    printf("Il char che controlo ora è il %c e si trova in posizione %d \n",argv[2][i],i);
    if(argv[2][i] >= '0' && argv[2][i] <= '9'){
        printf("ERROR: il secondo argomento non è una stringa!!! hai passato %s\n",argv[2]);
        exit(3);
    }
    ++i;
}


int sizela =(sizeof(argv[1])/ sizeof(char));
printf("SI è un numero di sizeof = %d \n", sizela);



printf("sizeof di int = %ld \n", sizeof(int));

printf("sizeof di char  = %ld \n", sizeof(char));
}
