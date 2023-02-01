#!/bin/bash
#prima di tutto entro nel Direttorio dove devo fare la ricerca
cd $1
#ora salvo il numero x di linee da cercare
X=$2

#ora devo trovare tutti i file leggibili con lunghezza x in linee
#Poi controlla che tuttte le linee contengano almeno un carattere numerico.
echo ...............Ci troviamo nel direttorio : `pwd`

#eseguo un for loop nel direttorio corrente per trovare tutti i file

trovato=0    #è la variabile booleana che mi indica se quel direttorio ha trovato almeno un file
TMP=$3
F=
for F in *
do 
    if test -f $F -a -r $F
    then 
        #trovati tutti i file devo fare verificare che il numero di linee sia uguale a quello poassato come argomento
        #salvo prima il numero di linee per fare prima
        L=`wc -l < $F 2>&1`
        if test $L -eq $X 
        then 
            echo TROVATO il file $F che ha esattamente $X linee, ora verifico che abbia almeno un numero a linea
            #ora devo verificare che ogni linea presenti almeno un numero
            echo Ora verifico la presenza di numeri per ogni linea
            N=`grep [0-9] $F | wc -l`
            if test $L -eq $N
            then 
                echo Il file $F presenta un numero per ogni riga quindi lo metto nei file temporanei
                echo $3
                echo `pwd`/$F >> $3
                

            fi   
            
        fi
    
    fi
done  

#Se ho che in questo direttorio ho trovato dei file che verificano requisiti inserisco nel tmp


#dato che devo salvare ogni direttorio contenente almeno uno di questi file 

for G in *  
do

    if test -d $G -a -x $G 
    then 
        $0 `pwd`/$G $2 $3
    fi
done
