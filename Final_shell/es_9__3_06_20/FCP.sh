 #!/bin/bash
 #File prova principale FCP.sh del 3 Giungnko del 2020

 #Prima cosa eseguo controllo su parametri

 case $# in
    0|1|2)  
        echo ERROR: numero di parametri insufficente. Coretta chiamat è $0 char dirass1 dirass2 ... 
        exit 1;;
    *)
        echo Ok chiamta con parametri corretto, proseguo al controllo singoli param
    ;;
esac

#Ora faccio il controllo sul primo parametro

if test `grep -i [a-z] $1 > /dev/null 2>&1`
then 
    echo ERROR: Il primo parametro passato non è un carattere
    exit 2;
fi
#Ora lo salvo in una variabile chiamata C cosi posso fare shift e verificare tutti i direttori

C=$1
shift

#ora posso proseguire a fdare il controllo su tutti i restanti parametri che sono solo Direttori
#Verifico siano in forma assoluta e che siano direttori ed attraversabili.
for D in $*
do 
    case $D in 
        /*)
            if test ! -d $D -o ! -x $D
            then   
                echo ERROR: $D NoN è un direttorio o non è attraversabile.
                exit 2
            fi;;
        *)  
            echo ERROR: $D nome di DIrectory non in forma Assoluta.
            exit 3;;
    esac
done
#prima delle n fasi devo salvare il path e asportarlo

PATH=`pwd`:$PATH
export PATH

#Dopo tutti i test avvio le N fasi

#Per le N fasi sara neccessario un file temporaneo per contare tutti 
#i direttori che verifiacano le specifiche.

> /tmp/nomiAssoluti-$$

for D in $*
do
    FCR.sh $D $C /tmp/nomiAssoluti-$$
done 

echo FINITO le N fasi.
echo Ho trovato ESATTAMENTE "`wc -l < /tmp/nomiAssoluti-$$`" direttori che verificano la specifica.

#Ora devo printare i nomi di tutti i direttori che roispettanop le specifiche
#E chiedere per ogni direttorio a ELENA se vuole o meno visualizzarne il contenuto compresi elementi 
#nascosti



for i in `cat < /tmp/nomiAssoluti-$$`
do 
    echo Ciao Elena,
    echo .......TRovato il direttorio $i che verifica le specifiche
    echo Desideri vederne il contenuto compresi elementi nascosti della dir:
    read answer
    case $answer in 
        Y*|y*|S*|s*)
            echo Elena hai scelto di vedere il contenuto del direttorio $i che è:
            echo `ls -A $i`
            ;;
        N*|n*)
            ;;
    esac

done 




rm /tmp/nomiAssoluti-$$
