#!/bin/bash
#File script shell prova del 17 aprile 2015 penultima slide di Agentgroup
case $# in
	0|1|2|)echo ERROR: numero di argomenti passati insufficente; exit 1;;
	3)echo OK, num di argomenti passati correto;;
	*)echo ERROR: troppi argomenti passati; exit 2;;
esac
#salvo il primo parametro se è un numero intero;
if test $1 -gt 1
then 
	X=$1
	shift	#nel caso è un intero strett. positivo lo salvo e faccio shift di argomenti
else
	echo ERROR: primo argomente non è un intero strettamengte positivo
fi
#adesso faccio la verifica sui nomi delle dir assoluti;
for i in $*
do
	case $i
	/*)if test -d $i -a -x $i
		then echo 1st argument cheked abosulute and executable
        else echo ERROR: directory $i non è directory o non passabile; exit 3;;
	*)echo ERROR: directory passate non assolute;
esac
done
#creo e inizializzo un file temporaneo
>/tmp/nomiAssoluti-$$

PATH=`pwd`:$PATH
#setto il path corrente e lo esport.
export $PATH
#ora faccio le n fasi per tutte le directory
for i in $*
do 
	FCR.sh $i $X /tmp/nomiAssoluti-$$ 
	#cosi chiamo per ogni directory il file ricorsivo 
done
echo `wc -l < /tmp/nomiAssoluti-$$`
cat /tmp/nomiAssoluti-$$

echo inserire in numero K dal file da trovare, compreso tra 0 < K < $X
read 
