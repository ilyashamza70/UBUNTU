#makefile creato per la prova del 7 Settembre 2022 da Hamza Ilyas

CC=gcc 	#parametro utilizzato dal compilatore C
CFLAG=-Wall		#cosi mostro tutti i warning di compilazione e linking
SRC = $(wildcard *.c)
TAR = $(SRC:.c=)
ver= gcc -V
#Versione usata del gcc è ver verificala con cat $ver in seguito (togli il commento)
# $(ver)

all: $(TAR)

%: %.CC
		$(CC) $(FLAG)	$< -o $@
		
