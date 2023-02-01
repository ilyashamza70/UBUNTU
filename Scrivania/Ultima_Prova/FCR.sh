#!/bin/bash
#File FCR.sh 
#prima di tutto entro nella directory passata come primo argomento
cd $1
cont=0  #contatore per numero di file in questa directory o sottorirectory
CH=0 #contatore per la wc di ogni file per vederne la dimensione


for f in *
do
    if test -f $f -a -r $f  #verifico che sia un file e sia leggibili se lo è proseguo 
    then 
        CH=`wc -c < $f`     #inserisco nella var CH la lunghezza del file in caratteri 
        
        if test $CH -gt 0   #deve ovviamente essere > 0 per verificare che siano tutte maiuscole
        then 
            echo Trovato file $f di lunghezza $CH caratteri
            #adesso devo verificare che siano tutti maiuscoli 
            MAIUSC=`grep [A-Z] $f | wc -c`
            echo Caratterei maiuscoli e spazio e /n $MAIUSC
             #PROBLEMI QUA NON RIECO A CAPIRE COME INCLUDERE IL CARATTERE A CAPO E IL CARATTERE SPAZIO
            #Verifico con la if se grep ha trovato occorrenze di non MAiuscole e ridirigo stdout e error 
            
            if test $MAIUSC -eq $CH
            then 
                cont=`expr $cont + 1`   #se grep ha tronato false ovvero ci solo solo masiuscole allora aumento cont
                echo Trovato file $f con solo maiuscole     #in tal caso printo file e salvo nel file temporaneo in append 
                echo `pwd`/$f >> $2 
            else
                echo Il File $f NON contiene solo maiuscole #se trovo occorrenze di non maiuscole allora non aumento il cont
                
            fi
            

        fi
    fi
done
echo Nella directory $1 ci sono esattamente $cont file che soddisfano i requisiti


for i in *
do
	if test -d $i -a -x $i
	then
		#chiamata ricorsiva poiche è una sottodirectory
		FCR.sh `pwd`/$i $2
	fi
done