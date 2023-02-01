#!/bin/bash
#FIle principale per la prova del 9 settembre 2016

#prima cosa controllo sul numero di parametri passsati a linea di comando

case $# in
    0|1|2)
        echo ERROR: numero di param insufficenti. Sintassi corretta è : X dirass1 dirass2 ... dirassN
        exit 1;;
    *)  
        echo Numero di param corretto proseguo con verifica dei singoli param;;
esac

#verifico prima il primo param che dovrebbe essere un numero strettamente positivo

case $1 in
    *[!0-9]*)
        echo ERROR: il primo parametro $1 non è un numero. 
        exit 2;;
    *)
        if test $1 -eq 0
        then 
            echo ERROR: il primo parametro $1 è uguale a 0
            exit 3
        fi;;
esac

Y=$1        #salvo il primo param che è un numero nella variabile Y cosi da poter eseguire lo shift e avere solo direttori assoluti su cui
            #eseguire il controllo
shift

#ora eseguo controllo su tutti i parametrri rimasti, verificando che siano direttori assoluti

for D in $*
do
    case $D in
        /*)
            if test ! -d $D -o ! -x $D 
            then 
                echo ERROR: il direttorio $D non è un direttorio non è attraversabile.
                exit 4
            fi;;
        *)
            echo ERROR: direttorio $D non in form assoluta
            exit 5;;
    esac
done  

#dopo la verifica dei parametri estraggo il path per il file script ricorsivo e creo un file temporaneo che 
#salva i file che verificano la specifica delle fasi

PATH=`pwd`:$PATH
export PATH

#creo il file temporaneo ora
> /tmp/nomiAssoluti-$$

echo Creato file emporaneo /tmp/nomiAssoluti-$$
# Ora avvio le N fasi 
for G in $*
do
    echo ...................Avvio fase per $G
    FCR.sh $G $Y /tmp/nomiAssoluti-$$
done 

echo Ho trovato in tutto "`wc -l < /tmp/nomiAssoluti-$$`" File che hanno almeno $Y linee


#prima apro ogni file 
for i in `cat /tmp/nomiAssoluti-$$`
do  
   
    case $i in 
        *NO*)
            echo NON IL file $i non contiene niente pichè aveva un nuero di righe minori di 5;;
        *)
            echo Il file $i invece contiene la quinta riga del file associato
            echo Il contenuto di tale file è il seguente:
            echo `cat < $i`;;
    esac
done 

echo FINITO TUTTO
rm /tmp/nomiAssoluti-$$
        