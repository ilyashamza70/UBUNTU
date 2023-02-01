#include <stdio.h>
#include <fcntl.h>
#include <sys/wait.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <time.h>

int main(int argc,char *argv[]){
    if(argc < 4){
        printf("Errore la sintassi per questo file è almeno tre nomi di file \n");
        exit(1);
    }
    
    int N=argc - 1; //numero di file da aprire
    int pid_nipoti, pid_wn;
    int pid, pid_f, status, status_n ,exit_s;
    int pid_n, exit_n;
    //srand(time(NULL));
    printf("ID del processo padre è %d mentre N->num file  passato è %d\n",getpid(),N);
    int fd;
    int fo;
    for(int i=0 ;i<N;++i){
        if((pid = fork()) < 0){
            printf("Errore nella %d - esima fork del figlio\n",i);
            exit(3);
        }
        if(pid==0){
            printf("--%d) Sono nel processo figlio %d-esimo con id %d con relativo id padre %d\n",i,i,getpid(),getppid());
            clode(0);
            if((fd = open(argv[i+1],O_RDONLY)) < 0){
                printf("Errore nell' apertura del file %d-esimo o non esiste\n",i);
                continue;
            }
            clode(1);
            char *f=malloC(strlen(argv[i+1]) + 6);
            strcpy(f,argv[i+1]);
            strcat(f,".sort");
            if((fo = open(,O_WRONLY,O_CREAT)) < 0){
                printf("Errore nella creazione del file.sort per il file %s\n",argv[i+1]);
                continue;
            }
            close(fo);
            if((pid_nipoti = fork())< 0){
                printf("Errore nella fork del nipote della %d - esima fork del figlio\n",i);
                continue;
            }
            if(pid_nipoti == 0){
                close(0);
                printf("Sono il nipote di %d e im id è %d \n",getppid(),getpid());
                if((open(argv[i+1],O_RDONLY))< 0){
                    perror("ERRORE file non esiste %s",argv[i+1]);
                    exit(-1); 
                }
                if((open(f,O_WRONLY))< 0){
                    printf("ERRORE fapertura file non esiste %s",f);
                    exit(-1); 
                }
                execlp("sort","sort",(char *)0);
                printf("Errore nella sort del nipote\n");
                exit(-1);
            }
            if((pid_wn = wait(&status_n))< 0){
                printf("Errore nella wait del  nipote\n");
                continue;
            }
            if(status_n & 0xFF != 0){
                printf("Errore exit anomala dal processo nipote con pid %d\n",pid_n);
            }else{
                exit_n=(status_n >> 8 ) & 0xFF;
                printf("--%d)Il processo con id %d ha ritornato: %d n",i,pid_n,exit_n); 
       
            }

            exit(0);
        }
    }
    for(int i=0;i<N;++i){
        if((pid_f = wait(&status)) < 0){
            printf("Errore nella wait del figlio\n");
            exit(3);
        }
      
        if(status & 0xFF != 0){
            printf("Errore exit anomala dal processo figlio con pid %d\n",pid);

        }else{
            exit_s=(status >> 8 ) & 0xFF;
            printf("--%d)Il processo con id %d ha ritornato%d\n",i,pid_f,exit_s); 
        }
        }
    exit(0);


}