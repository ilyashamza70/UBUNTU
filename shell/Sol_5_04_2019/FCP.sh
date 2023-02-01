#!/bin/bash
#File FCP.sh of 5 april exam last recent uploaded files on Agentgroup
#controllo numero di parametri con N>=2 quindi N+1>=3
case $# in
	0|1|2) echo ERROR: too few arguments passed. there should be at least  be more than 3;
	exit 1;;
	*)	echo Controllo sui param OK moving on;;
esac
#devo salvare l' ultimo param che è una stringa il cui valore salvo in una var
num=1	#uso la variabile num per sapere quando ho una stringa ovvero ultimo param
#intanto eseguo anche i test sulle directory prima di arrivae a ultimo paeram
params=0	#salvo il numero di param totale

for i
do
	if test $num -ne $# #cosi continuo finche non arrivo a ultimo argomento passato al comando
	then
		case $i in 
		/*)	if test ! -d $i -o -x $i
			then
			echo dir non attraversabile o non eseguibile
			exit 2
			fi;;
		*)	echo non nome assoluto; exit 3;;
		esac
	params="$params $i"
	else
		#ho ultimo parametro allora so che è una str verifico comunque se ha /
		S=$i
		case $S in
		*/*) echo ultimo argomento  è una directory assoluta mentre soi aspettava una stringa; exit 4;;
		*) ;;
		esac
	fi
	num=`expr $num + 1`	#incremento alla fine di evry for il num dell' arg su cui lavoro
done

#finito controllo su argomenti passati passo alla chiamata ricorsiva con tutte le directory
#sempre salvare il path corrente cosi da poter eseguire il file FCR.sh
PATH=`pwd`:$PATH	#cosi chiamo path a partire dalla dir in cui sono 
i=1
> /tmp/nomiAssoluti$$	#cosi creo e azzero il file temporaneo
for i < $params
do
	echo entro in FCR.sh con $i dir
	FCR.sh $i $S /tmp/nomiAssoluti-$$
done
#finito le N fasi devo fare gli echo.
#adesso lavora su FCR.sh.
$TOT=`wc -l < /tmp/nomiAssoluti$$` #salvo il numero totale di file trovati
echo Totali file trovati con nome S.txt è $TOT
cat /tmp/nomiAssoluti$$
echo -n "vuoi ordinare il file contenente la lunghezza dei file trovati"
read RISPOSTA
if test $RISPOSTA -ne S* -o $RISPOSTA -ne s* -o -ne Y* -o -ne y*
then 
	cat `sort -f /tmp/nomiAssoluti$$`	#proviamo se va cosi
else
	echo Non ordino i file e ho finito ;
fi
rm /tmp/nomiAssoluti$$

