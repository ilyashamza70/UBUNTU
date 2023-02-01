#!/bin/bash
#Prima eseguo il controllo sui parametri devono essere almeno 3
case $# in
    0|1|2) echo ERRORE: numero di argomenti passati $# mentre devono essere almeno 3;
            exit 1;;
    *) echo Numero di parametri passati corretto proseguo con controllo su singoli parametri;;
esac
#salvo il primo parametro Y poi controllo se è un intero strettam ente positivo.
Y=$1
if test $1 -lt 0
then 
    echo Errore il primo argomento: $1 non è un intero strettamente positivo deve essere > 0
    exit 2;
fi

shift #adesso pèosso shiftare cosi lavoro solo le directory
#prima verifico che siano nomi assoluti di directory poi che siano attreversabili e directories
for i in
do 
    case $i in  
    /*) if test ! -d $i -a ! -x $i
        then 
            echo Errore $i non è una directory o non è attraversabile;
            exit 3;
        fi;;
        
    *) echo ERRORE: $i non è un nome assoluto di directory;
        exit 4;;
    esac
done
#finito il controllo sui parametrri proseguo con le chiamate ricorsdive
#inzializzo un file temporaneo
>/tmp/nomiAssoluti-$$
#setto il path e lo esporto
PATH=`pwd`:$PATH
export PATH

#ora faccio le chiamate ricorsive al file FCR.sh con relativi parametri e file tmo

for G 
do
    FCR.sh $G $Y /tmp/nomiAssoluti-$$
done
#finito chiamata ricorsiva lavoro sul file tmp con cmd cat >

NF=`wc -l < /tmp/nomiAssoluti-$$`    # Metto il valore dei file globalmente creati

echo sono stati creati $NF file globalmente
for i in `cat /tmp/nomiAssoluti-$$`
do
    echo Creato il file $i
    case $i in 
    *NO) echo IL file originale non conteneva almeno 5 linee e quindi è $i è vuoto;;
    *) echo Il contenuto del file $i è il seguente:
        cat < $i ;;
    esac
done
#infine elimino file tmp            
cat /tmp/nomiAssoluti-$$
rm /tmp/nomiAssoluti-$$
