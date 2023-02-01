//fILE myCat DELLA PRIMA ESERCITAZIONE.
#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <string.h>
#define PERM 0644


//DEVO CREARE UNA VERSIONE DI CAT che puo essere invocata con un numero qualunque o nessuno di file 

int fd = 0; //File descriptor per file lo metto a 0 cosi nel caso non ci sono file ape stdin cioe tastiera e ne fa il
char buffer [BUFSIZ];

int main(int argc,char **argv){
    if(argc == 1){
        
        while(read(fd,buffer, BUFSIZ) > 0 ){
            //Cosi sono nel while finchè viene letto almeno un carattere
            //Questo deve essere printato su stdout
            printf("%s",buffer);
        }
    }
    //Dopo avere eseguito il controllo sul PRIMO CHE DEVE ESSERE UN fiLE
    for(int i=0;i< argc-1;++i){
        //Prima di tutto verifico che sia un file e che riesco ad aprirlo
        if((fd = open(argv[1],O_RDONLY)) < 0){
            printf("ERROR: non si è riusciti ad aprire il file di nome %s\n",argv[i]);
            exit(2);
        }
        //Ora che so che è un file ne mostro il contenuto
        //Prima ne calcolo la dimensione? NON necessario
        //uss un altro ciclo
        printf("...........................\n");
        printf("AVVIO CAT DI FILE %s\n",argv[i]);
        printf("...........................\n");
        while(read(fd,buffer, BUFSIZ) > 0 ){
            //Cosi sono nel while finchè viene letto almeno un carattere
            //Questo deve essere printato su stdout
            printf("%s",buffer);
        }
        printf("\n...........................\n");        
    }
    //Adesso printo il totale occorrenze trovate dato da i 
    //printf("Finito il cat di tutti oi file passati con successo\n");


}