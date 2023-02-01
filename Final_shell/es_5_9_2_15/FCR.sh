#!/bin/bash
#File ricorsivo FCR.sh della prova del 9 febbraio 2015


TROVATO=false    #variabile binaria per verificare se nel direttorio ho trovato o meno un file di K righe
                #Ogni inizio del ciclo per directory deve essere false

K=$2            #indica il numero di linee che il file devono avere

NL=             #indica il numero di line del File in esame
cd $1

for F in *
do
    if test -f $F -a -r $F
    then 
        echo Trovato file nome: $F 
        #ora verifico se il numero di linee di tale file è K
        NL=`wc -l < $F`
        if test $NL -eq $K
        then
            echo Trovato file di esattamente $K linee 
            TROVATO=true
            echo `pwd`$F >> $3
        fi 
    fi
done

if test $TROVATO == true
then
    
    echo La directory $2 presenta almeno un file con $K linee
fi
#Dopo aver fatto la ricorsione di tutti i file in tale direttorio verifico se questa gerarchi presenta sottodirectory
#In caso affermativo faccio una chiamata ricorsiva a questo script con il nuovo percorso della sottodirectory

for G in *
do
    if test -d $G -a -x $G
    then 
        echo Trovata sottodirectory con cui chiamo di nuovo FCR.sh
        $0 `pwd`/$G $2 $3
    fi
done