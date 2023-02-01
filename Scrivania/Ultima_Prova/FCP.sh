#!/bin/bash
#file FCS.sh di prova totale del 15 giugno 2022
#finito IN 45 minuti ma probemi con grep e pedita tempo allora non hai finito paRTE C 
M=  #inizializzo variabile M per contenere il num di file trovati globalmente

#Prima faccio la verifica dei argomenti passati co una case

case $# in     
    0|1|2) echo ERRORE la sintassi di questa shell script richiede di passare un numero strettamen maggiore di 2 argomenti quindi: dirass1 dirass2 ...
        exit 1;;
    *) echo Controllo Argomenti corretto $# directory passate,proseguo;;#Se passo W argomenti > 2 proseguo
esac
#ora verifico se tali directory sono nomi assoluti e se lo sono verico che siano effettiva directory e siano attravesabili
for g 
do
    case $g in 
        /*) if test ! -d $g -a ! -x $f
            then
                echo Errore: $f non è una directory o non è attraversabile check permissions maybe;
                exit 2
            fi;;
        *) echo Errore: nome di directory $f non passato in forma assoluta;
            exit 3;
    esac
done
#adesso devo settare la variabile path con il path corrente ed asportarla con export
PATH=`pwd`:$PATH
export PATH
>/tmp/fileAssoluti  #azzero il file temporaneo cosi e lo creo anche

#adesso proseguo alle w fasi con chiamata alla file ricorsivo con relativi argomenti
for g #nome stabilito dal testo è una g minuscola
do 
    echo FASE PER $g
    FCR.sh $g /tmp/fileAssoluti 
done
M=`wc -l < /tmp/fileAssoluti`
echo Sono stati trovati o creati $M file a livello globale cioe per tutte le directory

#I file si trovano nel file temporaneo /tmp/fileAssoluti come da specifica

#adesso devo invocare la parte in c con tutte le linee del file temporane
#oppure specifico M nella chiamata alla parte in c

#ora devo invocare il file main passanto come argomenti i nomi dei vari file trovat quindi con m argomenti

echo Sto per invocare main con $M argometni che sono i file trovati
main `cat /tmp/fileAssoluti` 

#cancelliamo il file temporaneo
rm /tmp/fileAssoluti

