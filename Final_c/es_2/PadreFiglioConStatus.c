#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/stat.h>
#include <unistd.h>
#include <string.h>
#include <time.h>

//srand(time(NULL));
//srand(time(NULL));

int mia_random(int n){
    int casuale;
    casuale= rand() % n;
    return casuale;
}

int fd_a;
int fd_s ;     // file descriptor della open relativo al file
char *C;     //Carattere da cercare e sostituire
int n;
int main(int argc,char **argv){
    //Controllo prima di tutto numero parametri ricevuti.
    printf("AVVIO del PROCESOO con pid=%d del padre\n",getpid());
    printf("ORA creo processo figlio\n");
    int pid;
    if((pid=fork()) == 0 ){
        //Sono nel processo figlio
        //Ora devo scrivere il pid del figlio
        printf("........Ciao mondo sono il primo processo figlio con pid=%d creato da ppid=%d\n",getpid(),getppid());
        //Ora devo calcolare random numvber tra 1 e 99
        int ris=mia_random(99);
        printf("........AUREVOIR MOrte del Processo figlio di pid= %d che passa il numero %d\n",getpid(),ris);
        exit(ris);

    }
    int status;
    int pid_f;
    if((pid_f = wait(&status)) < 0){
        printf("ERRORE NELLA WAIT DEL PADRE PER IL FIGIO");
        exit(1);
    }
    printf("FINE del PROCESOO con pid= %d del padre\n",getpid());
    

}
    
