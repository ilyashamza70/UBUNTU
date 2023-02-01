#!/bin/bash
#FILE FCP.sh della prova del 6 giugno
H=  #contiene il primo argomento
M=  #contiene il secondo argomento
G=  #contiene le singole gerarchie
F=  #identifica i file delle directory esplorate
cont=0  #contatore dei file che soddisfano i requisiti

case $# in 
    0|1|2|3) echo ERRORE $# argomenti passati mentre usage è $0: H, M, dirass1, dirass2...
        exit 1;;
    *) echo OK: numero di argomenti corretto ora controllo i vari argomenti;;
esac

if test $1 -le 0
then 
    echo ERRORE $1 non è un intero strettamente positivo
    exit 2
fi
H=$1    #se è un intero positivo lo salvo in H il primo param
 
if test $2 -le 0
then    
    echo ERRORE $2 non è un intero positivo
    exit 3
fi
M=$2
shift   #eseguo la prima shift e rimuovo il primo param
shift   #eseguo la seconda shift e rimuovo il secondo param
#Ora controllo se le dir passate sono assaolute e se sono  e se sono attraversabile
for G in $*
do
case $G in
    /*) echo OK: la prima directory passata è assoluta con nome: $G
        #ora testo se è directory e attraversabile
        if test ! -d $G -a ! -x $G 
        then
            echo ERRORE: $G non è una directory o non è attraversabile
        fi;;
    *) echo ERRORE: $G non è nome assoluto di directory
        exit 4;;
esac
done

PATH=`pwd`:$PATH    #salvo il valore dell corrente path
export PATH #esporto il path cosi da poter cercare le directory anche in FCR.sh diventando cosi var di ambiente shell o almeno del process in esecuzione
#Ora finiti i controlli faccio le chiamate ricorsive sul file FCR.sh con G,H,M,/tmp/count-$$
#chiamata ricorsiva
>/tmp/count-$$
for G in $*
do
    FCR.sh $G $H $M /tmp/count-$$
    echo uscito da $G

done
echo +++++++++++++++++++++++++++++++++++
echo File /tmp/count-$$
cat /tmp/count-$$
rm /tmp/count-$$

