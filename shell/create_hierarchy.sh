#!/bin/bash
#controllo parametro 1 con directory dove creare file e sottodir e deve essere assoluto
if test $# -lt 1
then
    echo ERRORE: numero argomenti deve essere > di 1 mentre adesso è $#
    exit 1
fi  

if test -d $1 -a -x $1
then 
    echo OK :parametro corretto prosegui è nome aassoluto di dir
else
    echo ERRORE: l unico argomento deve essere un nome assoluto
    exit 2
fi
PATH=`pwd`:$PATH
export PATH

for F in $#
do
    create_hierarchy_recursive.sh $F
done


