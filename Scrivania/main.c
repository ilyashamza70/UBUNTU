#include <stdlib.h>
#include <stdio.h>
#include <signal.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <ctype.h>
#include <limits.h>

/*Tipo di Dato pipe*/
typedef int pipe_t[2];
char *stampe;  //Array dinamico per memorizzzare i caratteri ricevuti dal padre e trovare il max
int *finito;
int F;
char minimo;
int index1;                        //salvo indice del massimo carattee
char posizioneMax = CHAR_MIN;     //salva indice del MAX CHE PARTE DAL PRIMO
                                  // Serve per la sort
char rx;    //buffer per salvare il carattere letto dalla pipe
int tx ;    //scrittura pipe dal padre al figlio
int nw;
int finitof()
{
	/* questa funzione verifica i valori memorizzati nell'array finito: appena trova un elemento uguale a 0 vuole dire che non tutti i processi figli sono finiti e quindi torna 0; tornera' 1 se e solo se tutti gli elementi dell'array sono a 1 e quindi tutti i processi sono finiti */
   int i;
	for (i=0; i < F; i++)
		if (!finito[i])
			/* appena ne trova uno che non ha finito */
			return 0; /* ritorna falso */
	return 1;
}


int main(int argc, char *argv[]){
    //Faccio un veloce controllo che ci siano almeno 2 file altrimenti non ha senso
    if(argc < 3){
        printf("ERRORE argomenti insufficenti per chiamata alla main sono stati passati %d argomenti\n",argc-1);
        exit(1)
    }

    //Calcolo prima il numero di file
    F= argc-1;
    int pid;    // PID PER LA FORK
    int fd;     // Filedescriptor
    int status; //Per  lo status della wait
    char CH;//Variabile usata dai figli per legger i caratteri
    int stampati;
    //Allocazione memoria per stampa e inizializzazione a 0
    finito = calloc(F,sizeof(int));

    if(finito == NULL){
        printf("ERRORE Nella allocazione di memoria");
        exit(2);
    }

    //Inizializzo le pipe dai figli al padre e ne alloco la memoria quindi ho 2*F pipe F da padre a figlio e F da figlio a padre

    pipe_t *pipedFP;
    pipe_t *pipedPF;

    pipedFP =  malloc (F*sizeof(pipe_t));
    pipedPF =  malloc (F*sizeof(pipe_t));
	if (pipedPF == NULL || pipedFP == NULL){
		printf("Errore in allocazione memoria per pipe padre-figli\n");
		exit(3);
	}

    //creo adesso le n pipe che comunicano con il padre e quelle che comunicano con figli
    for (int i=0; i < F; i++){
		if (pipe(pipedFP[i]) != 0){
			printf("Errore nella creazione della pipe %d-esima figli-padre\n", i);
			exit(4);
		}
    }
    for (int i=0; i < F; i++){
		if (pipe(pipedPF[i]) != 0){
			printf("Errore nella creazione della pipe %d-esima figli-padre\n", i);
			exit(5);
		}
    }
    //Posso adesso dato che ho create le pipe generare i figli
    for (int i=0; i < F; i++){
		
        if ( (pid = fork()) < 0){
			printf("Errore nella fork %d-esima\n", i);
			exit(6);
		}
		
		if (pid == 0) {
			//Mi trovo ora nel codice dei figli generati
			printf("Sono nel processo figlio numero %d con pid %d che apre il file: %s\n", i, getpid(), argv[i+1]);
			// chiudo le pipe figlie e padre nella direzione non neccessaria
			for (int j=0; j < F; j++){

				close(pipedFP[j][0]); 
                		close(pipedPF[j][1]);    
				if (i != j){
                    			close(pipedFP[j][1]);
                    			close(pipedPF[j][0]);
             			}
			}
            

            // Adesso per ogni figlio apro il relativo file in lettura e scrittura 
			if ((fd = open(argv[i+1], O_RDONLY)) < 0){
        	    printf("Errore nella open del file %s\n", argv[i+1]);
				exit(-1); // in caso di errore, torno -1 che è interpretato come errore (255)
                
                }
            printf("File aperto correttamente \n");    //Da togliere serve per verifica
            stampati=0;  //assegno 0 al numero di stamope del figlio 
            int posizione = 0;
            int x;
		    while (read(fd, &CH, sizeof(CH)) > 0)
			{	
			/* controlliamo se abbiamo trovato un carattere alfabetico MAIUSCOLO o miuscolo nel caso specifico esame(la mia parte shell verifica maiuscolo quindi ho usato maiuscolo) */
                if (isupper(CH)){
                    //SI deve comunicare al padre che e èstata trovata un occorrenza del carattere alfabetico minuscolo
                    printf("Trovata occorrenza carattere %c\n",CH);//Da togliere serve per verifica
                    int nw = write(pipedFP[i][1], &CH, sizeof(CH));
                    if(nw != sizeof(CH)){
                        printf("Impossibile scrivere sulla pipe per il processo di indice %d\n", i);
                        exit(-1); 
                    }
		
		    printf("Mandato al padre ora attendo risposta\n");
					
                    if(read(pipedPF[i][0],&x,sizeof(x)) != sizeof(x)){
                        printf("Impossibile leggere dalla pipe padre-figlio per il processo di indice %d\n",i);
                        exit(-1);
                    }
                    if(x == 1){
                         
                        printf("Il carattere scelto è %c con indice %i, che ha pid %i. la posizione nel file è %i ed è stato trovato nel file %s ",CH,i,getpid(),posizione,argv[i+1]);
                        ++stampati;
                    }   
                    
                    
                }   else {
                    printf("Non è un lower case %c \n",CH);//Da togliere serve per verifica
                }
				
				posizione++; // Cosi so la posizione del cararttere che ho trovato
            }
            exit(stampati);
        }
    }
    //Codice del padre
    //prima chiudo la pipe figlie e padre non usate
    printf("Sono nel padre\n");
    for(int i = 0 ;i < F ;i++){
        close(pipedFP[i][1]);
        close(pipedPF[i][0]);
    }
  
     /* Il padre recupera le informazioni dai figli in ordine di indice */
     //E scrive sulla pipe padrefiglio una volta letto dalla pipe figlio padre
     //in partivolare dopo che ha verificato che il figlio ha finito

    while(!finitof()){
        for(int i=0 ; i < F; i++){
            finito[i]=read(pipedFP[i][0], &rx, sizeof(rx));
            printf("Ho letto tutti i dati dal pid_PF nel padre del pid %i\n",i);
            if(!finito[i]){
                //Una voltra finito quindi ricevuto dalla pipe e salvato il dato in rx facciola sort 
                if(rx > posizioneMax){
                    posizioneMax = rx;
                    index1 = i;
                }
            }
        }

        printf("IL figlio con carattere minore ha id %i",index1);
        tx=1;
        printf("sto per eseguire write finita attesa figli e la sort");
        for(int l = 0; l < F ; l++){
            /*if(l == index1){
                tx = 0; 
            }else
                tx =1;
            */
            if(!finito[l]){
                nw = write(pipedPF[l][1],&tx,1); 
                if(nw != 0){
                    printf("ERRORE nella trasmissione dal padre al figlio con indice %i",l);
                }
            }
        
        }
    }
    
	/*
    for (int i=0; i < F; i++){
		read(pipedFP[i][0], &rx, sizeof(char));
        sort[i] = rx;
    }	
    
    printf("Ho ricevuto i carartteri al padre");
    //Una volta letti tutti i caratteri dalle pipe e messi in array di cahr
    //Proceda alla ricerca del massimo e ne salvo l'indice
    int tmp = 0;
    for(int l=1;l<F;l++){
        if(sort[0] <= sort[l]){
            sort[0]=sort[l];
            tmp=l;
        }
    }
    */
    //Trovato l printo il suo id
    
    
	/* Il padre aspetta i figli */
	for (int i=0; i < F; i++){
		pid = wait(&status);
		if (pid < 0){
		    printf("Errore in wait\n");
		    exit(7);
		}
    //Se ho un interruzione anomaalo o ho avuto dei problemi in
		if ((status & 0xFF) != 0){
    		printf("Figlio con pid %d terminato in modo anomalo\n", pid);

		}
        else{
            //int ritorno = (int)((status >> 8) & 0xFF);
            printf("Figlio con pid %d è ritornato con %d quindi questo è il numero di stampe effettuate da questop figlio\n", pid,WEXITSTATUS(status));
        }

	}


    exit(0);
}

