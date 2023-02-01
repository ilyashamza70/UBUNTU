#!/bin/bash
#file comandi pshell prova 15 febb 2017 esercitazioni

if test $# -ne 2
then 
    echo ERRORE nel numero di parametri passati devono essere 2;
    exit 1;
fi

case $1 in
    /*) if test -d $1 -a -x $1
        then 
            echo nome di directory assoluta ed è una directory
        else
            echo Directoryname not directory o non attravesabile
            exit 2;
        fi;;
    *) echo Errore nomedirectory non assoluto;
    exit 4;;
esac
