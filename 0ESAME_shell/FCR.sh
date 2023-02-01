#File ricorsivo FCR.sh da usare per esame
#Prima di tutto entro nella gerarchia richiesta che solitamente passo come primo parametro di chiamata
cd $1
#adesso verifico ogni file in questa gerarchia

for F in * 
do
    if test -f $F -a -r $F
        then
            echo Trovato file leggibile su chui eseguire verifica
            if test `wc -l < $F` -eq $2
                then 
                    echo Trovato file con $2 linee esattamente quindi lo salvo
                    `pwd`/$F >> $3
            fi
    fi
done 
#poi verifico se la gerarchia congtiene directory se si controllo all' ointerno anche di esse con un chiamata ricorsiva a se stessa per ogni dir inco ntrata

for i in *
do
    if test -d $i -a -x $i
        then 
            FCR.sh $1/$i $2 $3
    fi
done
