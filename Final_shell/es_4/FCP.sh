#!/bin/bash
#Sono richiesti 2 parametri allora ne eseguo un controllo

case $# in
    0|1)    echo ERROR: Insufficenti argomenti attesi: 2 mentre sono stati passati $#
            exit 1;;
    2)  echo Corretto numero di param, proseguiamo.
        ;;
    *)  echo troppi argomenti. Richiesti solo 2 mentre sono stati passati $#ù
        exit 2;;
esac




#il primo deve essere un direttorio assoluto, lo verifico
case $1 in
    /*)
        if test ! -d $1 -a -x $1
        then echo Direttorio non attraversabile o non in forma assoluta
        fi;;
    *)
        echo ERROR: nome directory non in forma assolta
        exit 3;;
esac




PATH=`pwd`:$PATH
export PATH

echo QUESTO SONO I NUMERI DI LINEE CHE DEVONO AVERE $2

> /tmp/nomiAssoluti-$$

FCR.sh $1 $2 /tmp/nomiAssoluti-$$


echo Trovati esattamente `wc -l < /tmp/nomiAssoluti-$$`

rm /tmp/nomiAssoluti-$$
