#!/bin/bash
#File ricorsivo FCRF.sh per prova 5 april in SOl
#non neccessaria la verifica sui param parto con esplorazione dir alla ricerca di file 
#mi posiziono nella primo arg passato per invocare FCR.sh
cd $1
WC=	#param per salcvare il wc 
#controllo se è un file
if test -f $2.txt -a -r $2.txt -o -w $2.txt
	then	WC=`wc -c < $2.txt` #ricorda con < metti quello a sinistra in destra
		echo $WC `pwd/$2.txt` >> $3 	#cosi salvo tutto in destra
fi
for i in *
do
	if test -d $i -a -x $i
	then 
		#chimata ricorsivo dato che ho trovato una dir attraversabile
		FCR.sh `pwd`/$i $2 $3
	fi
done
#finito cosi file ricorsivo alla fine torna da solo al file FCS.sh



