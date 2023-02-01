
#include <stdlib.h>
#include <stdio.h>

int main(int argc,char *argv[]){

    //Prima controllo sui parametri devono essere num+ 1 che è il nomne dell' eseguibile
    if(argc < 2){
        printf("Errore sul numero di parametri passati dovrebbero esserci almeno uno \n");
        exit(1);//Se param != da 1 allora esce
    }

    int N = argc - 1; //ricorda che conta anche il nome del file eseguibile

    printf("Eseguo il programma %s , con %d parametri\n",argv[0],N);//In realta potevi mettere anche solo argc -1;
    for(int i=0;i<N;i++){
        printf("%d) %s \n",i,argv[i+1]);
    }   
    exit(0);

}