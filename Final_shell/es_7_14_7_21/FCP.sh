#!/bin/bash
#File Principale della prova del 14 Luglio 2021 FCP.sh

#controllo sul numero di parametri prima cosa da eseguire

#uso lista di params per accumulare tutte le gerarchie fino ad arrivare agli ultimi due numeri
params= #per lista faccio cosi in for params="$params $i"


case $# in
    0|1|2|3)
        echo ERROR: numero minimo di parametri è quattro nella forma : dirass1 dirass2 .... H M dove ultimi sono numeri
        exit 1;;
    *)
        echo OK numero param corretto proseguo al controllo sul singolo
        ;;
esac

num=1

#prima facciamo il controllo sulle directory assolute finchè non troviamo un numero
for i in $*
do
    
    if test $num -lt `expr $# - 1`
    then
        echo verifico che la gerarchi i-esima: $i sia dir assoluta
        case $i in
            /*) #in questo caso ho che la directory è assoluta
                if test ! -d $i -o ! -x $i
                then 
                    echo ERROR: directory non attraversabile o non nome di directory
                    exit 2
                fi;;
            *)  #qualsiasi altra cosa:
                echo ERROR: nome di dir non in forma assoluta
                exit 3;;
        esac 
        params="$params $i" #se i controlli sono andati bene memorizziamo il nome nella lista params
    else
        #qua verifico che sia un numer, poi che sia strettamente positivo
        case $i in 
            *[!0-9]*)   
                echo ERROR: il penultimo non è un numer
                exit 4;;
                *)
                    if test $i -eq 0
                    then 
                        echo i numeri Devono essere strettamente positivi non zero
                        exit 5
                    fi;;
        esac
        if test $num -eq `expr $# - 1`
		then
			H=$i
		else
			M=$i

        fi

    fi
    num=`expr $num + 1` #incrementiamo il contatore del ciclo sui parametri
    
done

echo Ho salvato in H il valore $H e in M il valore $M
echo mentre la lista di parametri passati come dir assolute sono $params

