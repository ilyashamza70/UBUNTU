#|/bin/bash
#File Ricorsivo del 17 Aprile 2015 FCR.sh

cd $1

X=$2    #salvo il numero 

NT=     #è il numero di linee terminanti con t nel file


for F in *
do  if test -f $F
    
     #prima controllo se è un file
    then
        echo Trovato File $F 
        #Ora devo verificare che abbia almeno X linee che terminano col carattere t
        #prima conto le line t terminate usando piping cosi:
        #uso il grep per cercare le line t terminate che poi passo con piping a wc -l 
        NT=`grep 't$' < $F | wc -l`
        echo $NT risultato di grep con wc
        echo $X ince è il numero minimo
        #ora verificao che tale numero sia maggiore o uguale di X
        if test $NT -ge $X
        then
            echo trovato $F file con almen o $X linee terminanti con t
            echo AGGiungo tale file in tmp
            echo `pwd`/$F >> $3
        fi
    fi
done

#se invece ho sottodirectory faccio chiamata a me stesso

for D in *
do  if test -d $D 
    then
        $0 `pwd`/$D $2 $3
    fi
done