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
    if((pid=fork())< 0){
        printf("ERROR: la fork è fallita, non si e riusciti a creare il processo");
        exit(3);
    }
    if(pid == 0 ){
        //Sono nel processo figlio
        //Ora devo scrivere il pid del figlio
        printf("........Ciao mondo sono il primo processo figlio con pid=%d creato da ppid=%d\n",getpid(),getppid());
        //Ora devo calcolare random numvber tra 1 e 99
        int ris=mia_random(99);
        
        printf("Ora dormo per 5 secondi\n");
        printf("........AUREVOIR MOrte del Processo figlio di pid= %d che passa il numero %d \n",getpid(),ris);
        sleep(5);
        exit(1);
       
    }
    int status;
    int pid_f;
    if((pid_f = wait(&status)) < 0){
        printf("ERRORE NELLA WAIT DEL PADRE PER IL FIGIO\n");
        exit(1);
    }
    //ciaoo
    printf("IL vaolre di ritorno del pid_f della wait è: %d\n",pid_f);
    printf("Mentre il valore di status cio exit del figlio è %d\n",status);
    printf("Invece il prodotto status & 0xFF è uguale a :...%d...: SEMPREEEEEE vuol dire successo\n",(status & 0xFF));
    printf("Per prendere invece il valore di uscita del figlio cioè exitstatus ho due modi\n");
    printf("Uso wexitstatus: %d \noppure faccio uno shift di 8 nel caso di terminazione senza segnali:%d\n",WEXITSTATUS(status),status >> 8);

    printf("FINE del PROCESOO con pid= %d del padre\n",getpid());
    

}
    
