lab2: lab2.o main.o 
	g++ -Wall -pedantic -g -o lab2 main.o lab2.o

main.o: main.cpp lab2.h
	g++ -Wall -pedantic -g -c main.cpp

lab2.o: lab2.h lab2.cpp
	g++ -Wall -pedantic -g -c lab2.cpp

clean:
	rm -f lab2
