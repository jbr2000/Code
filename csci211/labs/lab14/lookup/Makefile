lookup: lookup.o 
	g++ -Wall -pedantic -g -o lookup lookup.o

lookup.o: lookup.cpp location.h
	g++ -Wall -pedantic -g -c lookup.cpp

clean:
	rm -f lookup lookup.exe lookup.o
