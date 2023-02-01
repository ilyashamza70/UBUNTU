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
    //Ora verifico che il secondo sia un numero positivo

    for(int i=0;i < strlen(argv[2]);i++){
        if(argv[2][i] < '0' || argv[2][i] > '9'){
            printf("ERROR il secondo parametro deve essere un intero positivo\n");
            exit(2);
        }
    }
    //Cosi ottengo il valore nu merico passato a linea di comando
    int n = atoi(argv[2]);
    printf("E stato passato come numero, converito con atoi(n) il valore = %d\n",n);

    
    char buffer;
    int i=1;
    //Adesso che ho fatto verifiche parametri devo andare alla ricerca dei multipli di n

    int cont= 0;
    while(read(fd_s,&buffer,1) > 0){
        //hO LETTO DAL SORGENTE IN BUFFER, ORA DEVO COPIARE TALE VALORE IN FD_A
        if((i % n) == 0){
            printf("%d) Trovato multiplo di %d  ",i,n);
            printf("QUa si trova il carattere %c\n",buffer);
            ++cont;
        }

        ++i;

    }
    

    printf("Ho finito il ciclo del file e ho trovato esattamente  %d multipli di %d \n",cont,n);

}
    
