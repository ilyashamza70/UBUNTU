#!/bin/bash
#script shell principale della prova del 9 febbraio del 2015
#INIZIAMO

#Prevede 2 parametri.

case $# in
    0|1)
        echo Numero di parametri insufficenti, chiamata corretta: dirass numero
        exit 1;;
    2)
        #corretto numero di param proseguo alla verifica dei singoli parametri passati
        ;;
    *)
        echo Error: numero di parametri passati incorretto,  chiamata corretta: dirass numero
        exit 2;;
esac

#Prima verifico Il primo parametro

case $1 in
    /*) #cosi so che è in forma assoluta allora verifico sia un direttoria e che sia aatraversabile
        if test ! -d $1 -o ! -x $1
        then echo ERRORE: il primo parametro non è il nome di directory o non p attraversabile
             exit 3
        fi;;
    *)
        echo ERROR: Il primo parametro non è una directory nella forma assoluta
        exit 4;;
esac

#Ora verifico che il secondo param sia un numero strettamente positivo

if test $2 -le 0    #cosi verifico che non sia maggiore di 1 ovvero sia minore di 1 
then echo ERROR: il secondo parametro non è un numero strettamente positivo.
     exit 5;
fi

# Neccessario esportare il path cosi FCR.sh dispone degli stessi accessidi FCP.sh

PATH=`pwd`:$PATH
export PATH

#creo un file temporaneo per salvare i nomi assoluti dei directory in cui vi è almeno un file con K linee
#dove K è
K=$2

> /tmp/nomiAssoluti-$$



#Finito il controllo sui param ora faccio la chiamata ricorsiva

FCR.sh $1 $2 /tmp/nomiAssoluti-$$

echo Ho trovato esattamente "`wc -l < /tmp/nomiAssoluti-$$`" file di $2 linee nella gerarchia $1

for i in `cat /tmp/nomiAssoluti-$$`
do
	params="$params $i"
 	#Il programma, per ognuno dei file, deve richiedere all'utente un numero X intero strettamente positivo e minore di $2
	echo -n "Dammi un numero intero strettamente positivo e minore o uguale a $2 per il file $i: "
	read X
	#Controllo X (sempre con case!)
	case $X in
	*[!0-9]*) echo non numerico o non positivo
		  rm /tmp/nomiAssoluti-$$ #poiche' stiamo uscendo a causa di un errore, cancelliamo il file temporaneo!
                  exit 5;;
	*) if test $X -eq 0
	   then echo ERRORE: dato inserito $X uguale a zero
		rm /tmp/nomiAssoluti-$$ #poiche' stiamo uscendo a causa di un errore, cancelliamo il file temporaneo!
		exit 5
	   fi ;;
	esac
	if test $X -gt $2 
	then
		echo Numero fornito $X non minore di $2
		rm /tmp/nomiAssoluti-$$ #poiche' stiamo uscendo a causa di un errore, cancelliamo il file temporaneo!
		exit 6
	fi
 	params="$params $X"
done
#cancelliamo il file temporaneo dato che non ne abbiamo piu' bisogno
rm /tmp/nomiAssoluti-$$
echo $params
#Infine, si deve invocare la parte in C passando come parametri gli N nomi assoluti dei file selezionati F0, F1, ..., FN-1 intervallati dai numeri positivi chiesti all'utente  
echo Sto per chiamare la parte C a cui si passano i parametri $params
#main.c $params



#Alla fine rimuvo il file temporaneo 


