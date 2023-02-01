#!/bin/bash
#Proviamo a fare una cosa:
#Accettiamo 2 parametri come ingresso e facciamo una ricerca di una stringa nel file passato

case $# in
    1)
        echo CORRETTO NUMERO DI ARGOMENTI 1;;
    2)
      echo CORRETTO NUMERO DI ARGOMENTI 2;;
    3)
      echo CORRETTO NUMERO DI ARGOMENTI 3;;
    4) 
      echo CORRETTO NUMERO DI ARGOMENTI 4;;
    *)
        echo Insufficenti argomenti passati a line di comando
        echo sono attesi almeno due di cui il primo è una str il secondo un nome di file;
        exit 1;
esac

if test -z $1
then 
    echo ERROR il primo argomento deve essere una stringa non nulla
    exit 2;
fi

if test ! -f $2 -o ! -r $2
then    
    echo ERROR non è un file o non si posseggon o diritti di lettura;
    exit 3;
fi

#verificati gli argomenti ora faccio la ricerca

if grep $1 $2 > /dev/null 2>&1
then echo TROVATA STRING $1 nel file $2
else echo NON TROVATA la strringa $1 nel file $2
fi

    