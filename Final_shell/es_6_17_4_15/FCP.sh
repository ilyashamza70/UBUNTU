#|/bin/bash
#File principale del 17 Aprile 2015 FCP.sh

#Per prima cosa eseguo un controllo sul numero parametri passati a linea di comando:ù
case $# in 
    0|1|2)
        echo ERROR: numero di paramtri insufficenti. per chiamare script: dirass1 dirass2 numero
    exit 1;;
    *)
        echo Numero di argomenti passati corretto. Proseguo col controllo singolo
    ;;
esac

#il primo param deve essere un numero strettamente positivo quindi:
case $1 in
    *[!0-9]*)   #in questo caso verifico che non contenga numeri 
        echo ERROR: il primo param non è un numero 
        exit 2;;
    *) 
        if test  $1 -le 0
        then 
            echo ERRORE: il primo param non è un intero strettamente positivo.
            exit 3
        fi;;
esac

#Ora proced a fare lo shift, dopo avere salvato il primo parametro in una variuabile
X=$1
shift

#ora verifico che tutte le directory passate si in forma assoluta e che siano directory attraversabili
for i
do
case $i in
    /*) 
        if test ! -d $i -o ! -x $i
        then    
            echo ERRORE: $i non è un direttorio o non è attraversabile
            exit 4
        fi;;  
    *)  
        echo ERRORE: $i nome di directory non in form assoluta
        exit 5;;
esac
done
#fatto i controlli procedo alla chiamat ricorsiva
PATH=`pwd`:$PATH
export PATH

> /tmp/nomiAssoluti-$$

for G
do
    echo ...................Beginning fase per $G
    FCR.sh $G $X /tmp/nomiAssoluti-$$
done

echo Trovato esattamente "`wc -l < /tmp/nomiAssoluti-$$`" file che soddisfano la specifica.
#ora devo fare la chiamata al file c mostrando ogni nome di file salvato in tmp e chiedendo all' utente un numero K
#strettamente posiitivo e minore di X
#questo  numero deve mostrare la K-esima riga del file trovato corrente.

for i in `cat /tmp/nomiAssoluti-$$`
do
    echo Trovato il file $i 
    echo -n "Dammi il numero K (strettamente maggiore di 0 e strettamente minore di $X): "
    read K
    case $K in
        *[!0-9]*)   
            echo Il valore $K passato non è un numero
            rm /tmp/nomiAssoluti-$$
            exit 6;;
        *)  if test $K -lt 1 -o $K -gt $X  
            then echo Error: il valore non può essere negativo e non puo essere maggiore di $X
                rm /tmp/nomiAssoluti-$$
                exit 7
            fi;;
    esac
#arrivato qua vuol dire che il valore del param X è corretto
#allora adesso mostro la k-esima riga dal fondo
    head -$K $i | tail -1
done



echo Fatto tutto

rm /tmp/nomiAssoluti-$$
