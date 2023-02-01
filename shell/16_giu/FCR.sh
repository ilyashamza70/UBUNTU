#!/bin/bash
#file FCR.sh per prova 16_giugno

cd $1   #entro nella directory in cuin devo eseguire la ricerca prima di tutto
cont=0  #è il numero file con H linee e esattamente 2 caratteri come nome
files=
WC=0
i=1
#ciclo per fare tutte le verifiche su tutt i file in oggetto nella directory corrent
for F in *
do
    if test -f $F -a -r $F #se è un file ed e leggibile allora:
    then
        case $F in
            ??) if test `wc -l < $F` -eq $2 #se tale file contiene esattamente H linee che è il 2 argomento passato alla chiamata a FCR.sh
                then
                    cont=`expr $cont + 1`  #se quste condizioni verificate allora aumento il counter e stampo il file con requisiti verificato su stdout
                    files="$files $F"
                    echo TROVATO $i file con $2 righe il cui nome contiene solo due caratteri e ha esattamente `wc -l < $F` linee
            fi
            i=`expr $i + 1`;;
            *);;    #non fa nulla questo caso
        esac
    fi
done
#se la directory ha almeno 2 file con tali specifiche cioe count >= 2 o se è minore di M che è il 3 argomento salvo la directory
if test $cont -ge 2 -a $cont -lt $3
then
    `pwd >> $4`    #allora salvo il percorso della directory nel file temporanea passato come 4 arogomento e print una line adeguata
    echo $1 directory inserita nel file temporaneo
    #aggiungi qua la chiamat alla funzione c
fi
#se trovo una sottodirectory ci entro con chiamata ricorsiva con primo arg il path di tale sottodirectory
for D in *
do  
    if test -d $D -a -x $d
    then
        FCR.sh `pwd`/$D $2 $3 $4
    fi
done