#!/bin/bash
#Prova del 18 gennaio 2017
#File fcp.sh consegna G e D due param il primo assoluto il secondo semplice

#prima controllo su num di parametri esattamente 2
if test $# -ne 2 
then 
    echo ERRORE attesi solo 2 paramtri
    exit 1;
fi

case $1 in
    /*) if test ! -d $1 -o ! -x $1
        then 
            echo ERRORE il primo parametro deve essere il nome di una directory e deve essere attraversabile;
            exit 2;
        fi;;
    *) echo ERRORE il nome del primo param deve essere passato in forma assoluta;
    exit 3;;
esac

#controllo sul primo parab fatto
#ora controllo secondo param 

if test $2 = */*
then 
    echo ERRORE il secondo param non è una directory semplice
    exit 3;
fi
#esporto il path

PATH=`pwd`:$PATH
export PATH

#creo file temporaneo in cui insersco i nomi dei file
>/tmp/nomiAssoluti-$$
FCR.sh $1 $2 /tmo/nomiAssoluti-$$

#contiamo i file anche se non richiesto?? non credo vedi doppo

