#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <string.h>

int fd;


int main(int argc,char **argv){
    if(argc != 4){
        printf("ERROR: numnero di parametri incorretto. Uso è %s nome_file integer char\n",argv[0]);
        exit(1);
    }
    //Ora che ho verificato che sia chiamato con sintassi corretta procedo al controllo dei paramettri con cui invoxcato
    //Prima di tutto verifico che il prim o sia il  nome di un file esistente

    if(fd = open(argv[1],O_RDONLY) < 0){
        printf("ERROR: il nome del file passato non puo essere aperto perche non file o altro\n");
        exit(2);
    }
    
    

    //Ora verifico che il secondo param sia un intero:
    for(int i=0;i<strlen(argv[2]);++i){
        if(argv[2][i] < '0' || argv[2][i] > '9'){
            printf("ERROR: il secondo param non è un intero.\n");
            exit(3);
        }
    }
    //Controllo che ultimo param sia un char
    if(strlen(argv[3]) != 1){
        printf("ERROR: il terzo param deve essere un char!\n");
        exit(5);
    }
    if(argv[3][0] > '0' && argv[3][0] <'9'){
        printf("ERROR: il terzo parametro non è un char \n");
        exit(4);
    }

    //ORa ho finito fase di controllo mostro nome e tutti i param

    printf("Il file .c attuale di nome %s è stato chiamato con i seguenti parametri:\nNome del file è: %s,\nIl numero intero positivo è: %s,\nIl carattere è: %s \n",argv[0],argv[1],argv[2],argv[3]);



}