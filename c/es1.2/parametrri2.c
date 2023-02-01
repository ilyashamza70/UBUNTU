
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <string.h>

int main(int argc, char *argv[]){
//Prima effettuo controllo su parametri.
    if(argc != 4){
        printf("Errore: numero di parametri: %d è incorretto, argomenti attesi 3\n",argc);
        exit(1);
    }
        //COntrollo su primo param
    if(open(argv[1],O_RDONLY) < 0){
        printf("Errore apertura sul primo argomento, atteso un  nome file\n");
        exit(2);
    }
    if(argv[2] < 0){
        printf("Errore sul 2 param dovrebbe esssere un intero strettamente positivo\n");
        exit(3);
    }
    if(strlen(argv[3]) != 1 ){
        printf("Errore: ultimo parametro atteso un solo char \n");
        exit(4);
    }
    //finiti controllo sui parametri;
    printf("Eseguo il file %s, con %d argomenti\n",argv[0],argc);
    for(int i=0;i< argc - 1;i++){
        printf("Parametro %d) %s \n",i+1,argv[i+1]);
    }
exit(0);
}