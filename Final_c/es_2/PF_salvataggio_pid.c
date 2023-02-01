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


int mia_random(int n)
{
    int casuale;
    casuale = rand() % n;
    return casuale;
}

int fd_a;
int fd_s ;     // file descriptor della open relativo al file
char *C;     //Carattere da cercare e sostituire
int n;
int main(int argc,char **argv){
    //Controllo prima di tutto numero parametri ricevuti.
    if(argc-1 != 1){
        printf("ERROR: bisogna passare un solo parametro    \n");
        exit(1);
    }
    if(argv[1][0] < '0' || argv[1][0] >'9'){
        printf("ERROR Il parametro arrivato è : %s mentre è atteso un intero strettamente positivo  \n",argv[1]);
        exit(2);
    }

    printf("Il parametro arrivato è : %s \n",argv[1]);

    int N=atoi(argv[1]);
    if(N> 155){
        printf("ERROR: il parametro %d deve essere < di 155",N);
    }

    printf("AVVIO del PROCESOO PADRE con pid= %d del padre\n",getpid());
    printf("ORA creo processi figli\n");

    for(int i=1;i <= N;++i){

        int pid;
        if((pid=fork())< 0){
            printf("ERROR: la %d-iesima fork è fallita, non si e riusciti a creare il processo\n",i);
            exit(3);
        }
        if(pid == 0 ){
            //Sono nel processo figlio
            //Ora devo scrivere il pid del figlio
            printf("%d)........Ciao mondo sono il primo processo figlio con pid=%d creato da ppid=%d\n",i,getpid(),getppid());
            //Ora devo calcolare random numvber tra 1 e 99
            
            int ris = mia_random(100+i);

            printf("........AUREVOIR MOrte del Processo figlio di pid= %d, calcolato num= %d \n",getpid(),ris);

            sleep(1);
            exit(ris);

        }
    
    
        int status;
        int pid_f;
        if((pid_f = wait(&status)) < 0){
            printf("ERRORE NELLA WAIT DEL PADRE PER IL FIGIO\n");
            exit(1);
        }
        //ciaoo
        printf("%d-esimo) processo terminato con PID: %d",i,pid_f);
        printf(" Mentre il valore di random calcolato è: %d\n",WEXITSTATUS(status));

    
    }

    printf("FINE del PROCESOO con pid= %d del padre\n",getpid());
}
    
