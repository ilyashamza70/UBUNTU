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

#define PERM 0644
//srand(time(NULL));
//srand(time(NULL));

int pid;        //Per la fork
int pid_f;       //Per la fork del figlio
int fd;         //per open
int fd_f;       //per open del nuovo file creato nel figlio
int mia_random(int n)
{
    int casuale;
    casuale = rand() % n;
    return casuale;
}

char *C;     //Carattere da cercare e sostituire
int n;
int main(int argc,char **argv){
    //Controllo prima di tutto numero parametri ricevuti.
        int N = argc - 1;

    if(N <= 2){
        printf("ERROR: bisogna almeno un solo parametro    \n");
        exit(1);
    }
    


    printf("Il numero di file arrivati è : %d \n",argc - 1);

    printf("AVVIO del PROCESOO PADRE con pid= %d del padre\n",getpid());
    printf("ORA creo %d processi figli\n",argc-1);

    for(int i=1;i <= N;++i){
        // Itero su tutti i file il processo padre cosi per ogni file crea figlio
        if(fd = open(argv[i],O_RDWR) < 0){
            printf("ERRORE nell' apertura del file %s\n",argv[i]);
            exit(2);
        }

        if((pid=fork())< 0){
            //IN caso di errore nella fork gestisco con una printline e exit.
            printf("ERROR: la %d-iesima fork è fallita, non si e riusciti a creare il processo\n",i);
            exit(3);
        }

        if(pid == 0 ){
            //Sono nel processo figlio

            //Ora devo scrivere il pid del figlio
            printf("%d)....Ciao mondo sono il primo processo figlio con pid=%d creato da ppid=%d\n",i,getpid(),getppid());
            

            //Per prima cosa creo il nome del file da creare
            char *name_f =malloc(sizeof(char)*(strlen(argv[i]) + 6)) ;
            if(name_f == NULL){
                printf("ERRORE NELLA MALLOC");
                exit(-1);
            }
            strcpy(name_f,argv[i]);
            strcat(name_f ,".sort");
            //Ora creo il file
            if((fd_f=creat(name_f,PERM)) < 0){
                printf("ERRORE nella creazione del file %s\n",name_f);
                exit(-1);
            }
            
            //chiudi file che figlio non usa
            close(fd_f);
            //Ora che ho creato il file devo creare i nipotini;
            
            if((pid_f = fork()) < 0){
                printf("Errore nella creazione dell %d-esimo nipote\n",i);
                exit(6);
            }
            if(pid_f == 0){
                //SONO nel Processo NIPOTE i-esimo
                printf("............Ciao mondo sono il processo NIPOTE del %d-esimo figlio con pid=%d creato da ppid=%d\n",i,getpid(),getppid());
                //Ora devo fare in modo che ogni nipote faccia sort del file
                close(0);   //Cosi chiudo stdin e ridirigo a 
                //Ora apro il file
                if(open(argv[i],O_RDONLY) < 0){
                    printf("ERRORE NEll'apertura del nuovo file di nome %s\n",argv[i]);
                    exit(-1);
                }
                // DEvo anche chiudere stdout perche voglio che vada
                //Nel file nuovo
                close(1);
                if(open(name_f,O_WRONLY) < 0 ){
                    printf("ERROORE IN apertura nuovo file creato da padre %s\n",name_f);
                    exit(-1);
                }
                execlp("sort","sort",(char *)0);
                
                perror("ERRORE nel nipote, in esecuzione execlp\n");
                exit(errno);
            }
            //      FIniTO NIPOTE ORA SONO DI NUOVO NEL FIGLIO.

            int pid_n;
            int status;
            if((pid_n=wait(&status)) < 0){
                printf("ERROR: nella wait del figlio %d per il nipote\n",getpid());
                exit(7);
            }
            printf("Terminato nipote di pid= %d\n",pid_n);
            
            if((status & 0xFF) != 0){
                printf("ERROR: nel status ritornato dal nipote\n");
                exit(8);
            }
            status=WEXITSTATUS(status);
            if(status < 0){
                printf("Errore nell' esecuzione della sort per nipote con pid:%d",pid_n);
            
            }
            exit(status);

        }
        //SONO DI NUOVO NEL PADRE
    
        int status_p;
        int pid_f;
        if((pid_f = wait(&status_p)) < 0){
            printf("ERRORE NELLA WAIT DEL PADRE PER IL FIGIO di  pid=%d\n",pid_f);
            exit(1);
        }


        printf("Terminato figlio di pid= %d\n",pid_f);

        if((status_p & 0xFF) != 0){
            printf("ERROR: nel status ritornato dal nipote\n");
            exit(8);
        }
        status_p=WEXITSTATUS(status_p);
        if(status_p < 0){
        printf("Errore nell' esecuzione della sort per nipote con pid:%d",pid_f);
            
        }
           
        printf("%d-esimo) processo terminato con PID: %d\n",i,pid_f);
        printf(" Mentre il valore di ritorno calcolato è: %d , se = 255 ERROR\n",status_p);

    
    }

    printf("FINE del PROCESOO con pid= %d del padre\n",getpid());
}
    
