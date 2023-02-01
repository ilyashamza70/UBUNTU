#!#!/n/bash
#FIle principale per la prova del 9 settembre 2016

cd $1 #mi sposto per primo nella gerarchia passata
Y=$2    #cosi salvo il numero di line che i file devono avere

NL=        #salva il numero di line del file F su cui sto eseguenmdo il count

for F in *
do
    if test -f $F -a -r $F                  #prima di tutto verifico se il file è un file e abbiamo i diritti di lettura
    then 
        echo trovato un file di nome $F     # Trovato tale file ora verico che abbia un numero di line maggior uguale di Y
        NL=`wc -l < $F`                     #qua ricordati di ridirigere stdout e stderr su /dev/null
        if test $NL -ge $Y
        then 
            echo TROVATO FILE con $NL line che sono maggiore di $Y linee
            #inserisco il nome del file in tmp
            #Ora devo selezionare la 5 riga

            if test `wc -l < $F` -lt 5
            then
                echo IL file ha num di linee minore di 5 allora:
                > $F.NOquinta
                echo `pwd`/$F.NOquinta >> $3
            else
                L=`head -5 < $F | tail -1`
                #ho cosi salvato in L la quinta linea
                echo ....Questa è la 5 linea.........$L
                echo $L > $F.quinta
                echo `pwd`/$F.quinta >> $3
            fi    
        fi
    fi 
done 

for D in *
do
    if test -d $D -a -x $D
    then 
        $0 `pwd`/$D $2 $3
    fi
done