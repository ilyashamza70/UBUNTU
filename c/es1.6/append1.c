#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#define PERM 0644

int main(int argc,char *argv[]){
    if(argc != 2){
        printf("ERRORE devi passare solo un argomento che è il nome di un file1n\n");
        exit(1);
    }

    int fd;
    if((fd=open(argv[1], O_RDWR | O_APPEND | O_CREAT,PERM)) < 0){
        printf("ERROE nell' apertura del file %s \n",argv[1]);
        exit(2);
    }
    char c[200 * BUFSIZ];
    int nread;
    while((nread = read(0,c,200))> 0){
        if((write(fd,c,nread)) != nread){
            printf("ERRORE nella scrittura in append al file %s\n",argv[1]);
            exit(3);
        }


    }

    exit(0);


}