
#!/bin/bash
#File ricorsivo FCR.sh del 17_Aprile_2015
cd $1	#cosi entro direttamente nella directory interessata e cerco i file
for i in *
do
	if test -f $i -a -r $i
	then 
		NG=`grep 't$' $i | wc -l`
		if $NG -ge $2
		then
			cat `pwd`/$i  >> $3 
			echo $i added to tmp file
		fi
	fi
done

# nel caso trovo una o piu sottodirectoryu invcoo di nuovo FCR.sh nellla sottodir
for i in *
do
	if test -d $i -a -x $i
	then 
		FCR.sh $i $2 $3
		echo: Entro nella sottodirectory $i
	fi
done

 
