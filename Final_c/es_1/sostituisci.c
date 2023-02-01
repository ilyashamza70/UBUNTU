#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <string.h>

int fd ;     // file descriptor della open relativo al file
char *C;     //Carattere da cercare e sostituire

int main(int argc,char **argv){
    //Controllo prima di tutto numero parametri ricevuti.
    if( argc != 3){
        printf("ERROR: sono stati passati %d parametri, mentre devono essere 2\n",argc-1);
        exit(1);
    }
    //Poi verifico che il primo sia effettivamente un file

    if((fd=open(argv[1],O_RDWR)) < 0){
        printf("ERROR: non si è riuscito ad aprire il file %s\n",argv[1]);
        exit(2);
    }
    //Ora verifico che il secondo parametro sia un carattere
    if(strlen(argv[2]) != 1){
        printf("ERROR: il secondo parametro deve essere un solo carattere mentre si ha passato: %s\n",argv[2]);
        exit(3);
    }
    if(argv[2][0] > '0' || argv[2][0] < '9'){
        printf("ERROR: il secondo paramtro deve essere un carattere mentre hai passato: %d \n",argv[2][0]);
        exit(4);

    }

    C = malloc(sizeof(char));
    *C = argv[2][0];
    char *buffer=malloc(sizeof(char));
    int nread;
    int nwrite;
    long int pos;
    int cont;
    char *new=malloc(sizeof(char));
    *new=' ';
    //Adesso che ho fatto verifiche parametri devo cercare tutte le occorenze nel file del carattere c
    while((nread = read(fd,buffer,1)) > 0){
        if(*buffer == *C){
            lseek(fd,-1L,SEEK_CUR);
            
            if((nwrite = write(fd,new,1)) != 1){
                printf("ERROR: non si è riusciti a scrivere nel file %s\n",argv[1]);
                exit(5);
            }
            cont++;
            printf("Succesfully changed %s with %s\n",buffer,new);
        }

    }

    printf("Ho finito il ciclo del file ora verifica\n");

}