# Foobar makefile 

# This rule tells make how to "make" the executable sentence
main: main.o foo.o bar.o
	g++ -Wall -pedantic -g -o main main.o foo.o bar.o

# This rule tells make how to "make" the object file main.o 
main.o: main.cpp foo.h bar.h
	g++ -Wall -pedantic -g -c main.cpp

# This rule tells make how to "make" the object file sentence.o
foo.o: foo.cpp foo.h
	g++ -Wall -pedantic -g -c foo.cpp

# This rule tells make how to "make" the object file bar.o
bar.o: bar.cpp bar.h
	g++ -Wall -pedantic -g -c bar.cpp

# This rule tells make what to delete when the user type "make clean"
# BE VERY CAREFUL to only put generated files here
clean:
	rm -f main main.o foo.o bar.o
