#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <string.h>
int fd_a;
int fd_s ;     // file descriptor della open relativo al file
char *C;     //Carattere da cercare e sostituire

int main(int argc,char **argv){
    //Controllo prima di tutto numero parametri ricevuti.
    if( argc != 3){
        printf("ERROR: sono stati passati %d parametri, mentre devono essere 2\n",argc-1);
        exit(1);
    }
    //Poi verifico che il primo sia effettivamente un file

    if((fd_s=open(argv[1],O_RDONLY)) < 0){
        printf("ERROR: non si è riuscito ad aprire il primo file %s\n",argv[1]);
        exit(2);
    }
    //Ora verifico che il secondo sia un file
    if((fd_a=open(argv[2],O_RDWR)) < 0){
        printf("ERROR: non si è riuscito ad aprire il secondo file in cui appendere %s\n",argv[2]);
        exit(2);
    }
    
    char buffer;
    int i=1;
    //Adesso che ho fatto verifiche parametri devo andare alla fine del secondo file
    int dim_inizio = lseek(fd_a,0,SEEK_END);
    printf(".........Grandezza del file %s in cui devo fare append è: %d\n",argv[2],dim_inizio);
    int cont= 0;
    while(read(fd_s,&buffer,1) > 0){
        //hO LETTO DAL SORGENTE IN BUFFER, ORA DEVO COPIARE TALE VALORE IN FD_A
            
            if(write(fd_a, &buffer, 1) != 1){
                printf("ERROR: non si è riusciti a scrivere nel file %s\n",argv[2]);
                close(fd_s);
                close(fd_a);
                exit(5);
            }
            cont++;
            printf("%d) Succesfully added %c \n",i,buffer);
    }
    int dim_final = lseek(fd_a,0,SEEK_END);
    printf(".........Grandezza del file %s ialla fine è: %d\n",argv[2],dim_final);
    int dim_n = lseek(fd_s,0,SEEK_CUR);
    printf(".........Grandezza del file %s in cui devo fare append è: %d\n",argv[1],dim_n);
    close(fd_a);
    close(fd_s);
    printf("Ho finito il ciclo del file e ho scritto in appen esattamente %d caratteri \n",cont);

}
    
