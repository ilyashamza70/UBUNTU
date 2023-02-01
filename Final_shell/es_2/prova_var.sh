#!/bin/bash

#prima di tutto dichiaro la mia variabile.
A=`wc -l < F5`

#poi lo visualizzo 
echo il valore di a è $A
#adeso salvo l' altra variabile
B=`wc -l < F2`

#mostro anche quest
echo il valore di b è $B

#ora faccio somma e mostr

C=`expr $A + $B`

echo la somma di x e y è data da C=$C