#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

int main(int argc, char *argv[]){
    //test sui parametri passatie
    if(argc != 3){
        printf("Errore sul numero di parametri devono essere 2\n");
        exit(1);
    }
    // controllo sul primo parametro file
    int fd=0;
    if((fd = open(argv[1],O_RDONLY)) < 0){
        printf("Error il primo arg non è un file o non si hanno permessi\n");
        exit(2);
    }
    printf("%d \n",fd);
    if(strlen(argv[2])!=1){
        printf("Erroe secondo argomento deve essere un solo carattere\n");
        exit(3);
    }
    char Cx=argv[2][0];
    char c=0;
    long int tot=0;
    printf("File eseguito è %s con %d argomenti ,il file è %s e il carattere da cercare è %s \n",argv[0],argc-1,argv[1],argv[2]);
    int t=0;
    while(read (fd,&c,1)){
        
        if(c == Cx){
            ++tot;
        }
    }
    printf("Trovati %ld occorrenze di carattere %s nel file %s\n",tot,argv[2],argv[1]);
    
    close(fd);
    exit(0);
}