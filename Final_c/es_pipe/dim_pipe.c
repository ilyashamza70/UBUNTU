#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/stat.h>
#include <unistd.h>
#include <string.h>
#include <time.h>
#include <errno.h>
#include <signal.h>

#define PERM 0644
//srand(time(NULL));
//srand(time(NULL));

int pid;        //Per la fork

int pid_f;       //Per la fork del figlio

int fd;         //per open

int fd_f;       //per open del nuovo file creato nel figlio

char *C;     //Carattere da cercare e sostituire

int n;
int count;

void alrm_action()
{ 
    printf ("Write bloccata dopo %d caratteri\n",count);
    exit(0);
}

int main(int argc,char **argv){
    
    printf("FINE del PROCESOO con pid= %d del padre\n",getpid());
    

    int piped[2]; 
    char c = 'x';
    if (pipe(piped) < 0) {
        printf("Errore\n"); exit(1); 
    }
    signal(SIGALRM,alrm_action);    //Invia a alarm sign al il segnale di ALARME


    for (count = 0; ; ){ /* ciclo infinito */
        alarm(20);      //Cosi setto allarme

        write(piped[1], &c, 1); /* scrittura sulla pipe */
        
        alarm(0);       //resetto allarme

        if ((++count % 1024) == 0){
            printf("%d caratteri nella pipe\n", count);
        }
    }
}
    
