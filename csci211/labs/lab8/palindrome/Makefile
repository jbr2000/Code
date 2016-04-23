
palindrome: char_stack.o palindrome.o
	g++ -Wall -pedantic -g -o palindrome char_stack.o palindrome.o

palindrome.o: char_stack.h palindrome.cpp
	g++ -Wall -pedantic -g -c palindrome.cpp

char_stack.o: char_stack.h char_stack.cpp
	g++ -Wall -pedantic -g -c char_stack.cpp

clean:
	rm -rf *.o palindrome
