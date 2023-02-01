#!/bin/bash
#Prima di tutto faccio il controllo sul numero di parametri
#i parametri devono essere esattamente * controllo con una case o if test

#facciaomo 2 nel nostro esempio

if test $# -ne 2
then
    echo ERRORE numero di argomenti passati $# mentre devono esere solo 2
    exit 1
fi

#Ora faccio Il controllo sul primo parametro che deve essere un numero strettamente positivo

if test $1 -le 0
then
    echo ERRORE il primo param è $1 mentre deve essere un numero strettamente positivo
    exit 2
fi
#ora di solito faccio la shift cosi da avere tutti gli alti n nomi di directory da controllare con un semplice for F in $*
N=$1
#questo ovviamente dopo aver salvato il primo param in variabile
shift

#Ora controlla gli altri param deve essere directory in forma assoluta e attraversabile
case $1 in 
    /*) if test ! -d $1 -o ! -x $1
        then 
            echo ERRORE il 2 param deve essere un duirectory ed essere attraversabile
            exit 3
        fi
        ;;
    *) echo ERRORE Il 2 param non è nella forma assoluta 
        exit 4;;
esac

#Ora di solito salvo ed esporto il Path per poterlo avere anche nel file FCR.sh prima di invocarlo
PATH=$(pwd):$Path
export PATH

echo `wc -l < main.c`


#ora Di solito creo file temporaneo che deve essere eliminato allla fine in cui salvo dati che possono essere nomi di file o specifiche righe di file
#o possono essere anche numeri o altro.

> /tmp/nomiAssoluti-$$ # con i due $$ indico il valore del processo corrente quindi è un file tmp con  numero del processo della shell

#poi invoco la parte FCR.sh con i relativi parametri interessati
#in questo caso cerco nella dir specificata le occorenze dei file con esattamebnte N linee e ne riporto il nome

FCR.sh $1 $N /tmp/nomiAssoluti-$$

#Ora puo essere richiesto di stampare qualcosa ad esempio il numero di file trovati e per ogni file il relativo nome assokyuto e il numero di caratteri ad esempio
#o puo essere chiesto di fare altro sui file trovati 

echo abbiamo trovata (wc -l < /tmp/nomiAssoluti-$$) file che soddisfano la specifica richiesta
echo Adesso devo chiamare la parte c che ha come parametri i nomi dei file trovati

#main.c `cat /tmp/nomiAssolut-$$` 

#ora importante eliminare il file temporaneo
rm /tmp/nomiAssoluti-$$

