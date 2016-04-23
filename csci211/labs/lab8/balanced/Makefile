
balanced: char_stack.o balanced.o
	g++ -Wall -pedantic -g -o balanced char_stack.o balanced.o

balanced.o: char_stack.h balanced.cpp
	g++ -Wall -pedantic -g -c balanced.cpp

char_stack.o: char_stack.h char_stack.cpp
	g++ -Wall -pedantic -g -c char_stack.cpp

clean:
	rm -rf *.o balanced 
