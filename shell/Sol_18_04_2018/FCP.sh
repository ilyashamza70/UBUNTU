#!/bin/bash
#File FCP.sh for exam 1 of 18 April
echo this is the sol of April 18th exam the  FCP.sh file
case $# in 
	0|1|2) echo ERROR: too few parameters passed. Try adding param
	exit 1;;
	*) echo OK: so we have $? params;;
esac
#now we test first param shouyld be a number.
if test $1 [1-9]
then	Y=$1 
	 	shift 
	 #if $1 is int and  between 1 and 9 then we save its value in Y and then shift
elif $1 -eq 0
	echo the value of first param is 0 try changing it 
	exit 2
else echo ERROR: $1 is not an integer between 0 and 9 so change the first param.
	exit 3
fi

#Now we test if the remaining params excluded Y because we used shift are absolute directories
#uso un case  all interno di un for per controllare tutte le dir
for i 
do
case $* in i 
	/*) if test ! -d $i -o ! -x $i 
	then echo $i is not a either not a dir or not possible to go through it
	exit 4
	fi;;
	*) echo ERROR: $i is not an absolute name of dir
	exit 5;;
esac

#eseguiti tutti i controlli neccessari adesso entriamo nel file recursive FCR.sh
PATH=`pwd`:$PATH
export PATH
#neccessario esportare per poter lavorare nella pwd
counter=0	
> /tmp/conta$$	#creiamo/azzeriamo un file temporaneo.
for G in $?
do FCR.sh $G $Y $/tmp/conta$$

#finite le ricorsioni andiamo a contare tutti i file creati leggendo le line del file tmp



