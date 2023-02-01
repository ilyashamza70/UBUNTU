#!/bin/bash

#file ricorsivo chiamnato con tre argomenti :
#-nome assoluto directory G, un intero Y e un file temporaneo.

cd $1   #entro nella direcotry prima di tutto 

#adesso verifico se ci sono file e se tali file hanno lunghezza >= di 5
NL=0 #parametro NL rappresenta numero di line trovate nel file
for i in *
do 
    if test -f $i -a -r $i   #se è  file leggibile allora: 
    then 
        NL=`wc -l < $i` #conto le linee
        if test $NL -ge $2    # se queste sono >= Y
        then
            if test $NL -ge 5
            then
                head -5 $i | tail -1 > $i.quinta    #prendo  la 5 linea se cè 
                echo `pwd`/$i.quinta >> $3
            else
                > $i.NOquinta #il numero di linee e minore di Y
                echo `pwd`/$i.NOquinta >> $3
            fi
        fi
    
    fi 
done

for d in *
do
    if test -d $d -a -x $d  #se trovo una sottodirectory 
    then
        FCR.sh `pwd`/$d $2 $3   #richiamo la funzione ricorsiva con path della sottodirectory
    fi
done 




        
     