robot: main.o matrix.o world.o
	g++ -Wall -pedantic -g -o robot main.o matrix.o world.o

main.o: main.cpp matrix.h world.h
	g++ -Wall -pedantic -g -c main.cpp

matrix.o: matrix.h matrix.cpp
	g++ -Wall -pedantic -g -c matrix.cpp

world.o: world.h world.cpp
	g++ -Wall -pedantic -g -c world.cpp

clean:
	rm -f matrix.o main.o robot
