serial: serial.c
	gcc -g -Wall -std=c99 -o serial serial.c -lm
 
parallel: parallel.c
	mpicc -g -Wall -std=c99 -o parallel parallel.c -lm

clean:
	rm serial
	rm parallel
