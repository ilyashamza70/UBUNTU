//fILE CONTAoCCORRENZE DELLA PRIMA ESERCITAZIONE.
#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <string.h>

int fd; //File descriptor per file

int main(int argc,char **argv){
    if(argc != 3){
        printf("ERROR: il numero di paramtri deve essere esattamente 2 mentre ne sono stati passati argc=%d\n",argc);
        exit(1);
    }
    //Dopo avere eseguito il controllo sul PRIMO CHE DEVE ESSERE UN fiLE
    if((fd = open(argv[1],O_RDONLY)) < 0){
        printf("ERROR: non si è riusciti ad aprire il file passato di nome %s\n",argv[1]);
        exit(2);
    }
    //COntrollo ora che il secondo param sia un carattere
    if(strlen(argv[2]) != 1){
        printf("ERROR: bisogna passare un solo char come secondo argomento mentre sono stati passati: %s\n",argv[2]);
        close(fd);
        exit(3);
    }
    //Ora verifico che sia un carattere e non un numero
    if(argv[2][0] > '0'&& argv[2][0] < '9'){
        printf("ERROR: il secondo param deve essere un carattere\n");
        close(fd);
        exit(4);

    }
    //Adesso mi preparo a visuallizzzaereinfo chiamata su stdout

    printf("........é stat chiamata la funzione %s con i seguenti parametri:\nIl primo è il nome di un file: %s\nIl secondo invece è un carattere non numerico: %s\n",argv[0],argv[1],argv[2]);
    //Ora devo contare le occorrenze di carattere char, prima lo salvo in carattere
    char carattere = argv[2][0];

    //Ho il file gia aperto quindi faccio la ricerca col for
    //Leggo un carattere alla volta dal file con un for e verifco se è uguale a carattere

    //Creo anche variabile che contiene il valora letto
    //Inizializzo anche variabile i con occorrenze
    char *letto= malloc(sizeof(char));
    char *new=malloc(sizeof(char));
    *new=carattere;
    int i=0;
    int size = lseek(fd,0,SEEK_END);
    if(size < 0){
        printf("ERROR: IL FILE è VUOTO o ha dato errore nel calcolo del size\n");
        close(fd);
        exit(5);
    }
    printf("......DImensione del file %s è %d\n",argv[1],size);
    int p =lseek(fd,0,SEEK_SET);
    int res=0;
    while(i < size){
        int r = read(fd,letto,1);
        if(r != 1){
            printf("ERROR: in lettura di un carattere");
            close(fd);
            exit(99);
        }
        int c = strcmp(letto,new);

        if(*letto == carattere){
            //Ho trovato occorrenza di carattere nel file
            printf("Ho trovato l' occorrenze di %c in %s alla posizione %ld\n",carattere,argv[1],lseek(fd,0,SEEK_CUR));
            printf("Il valore tornato da strcmp è %d\n",c);
            ++res;; 
        }
        ++i;   
        
    }
    //Adesso printo il totale occorrenze trovate dato da i 
    printf("Finito la ricerca del carettere %c in %s che ha trovato esattamente %d occorrenze \n",carattere,argv[1],res);


}