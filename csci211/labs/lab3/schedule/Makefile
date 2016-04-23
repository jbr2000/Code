# makefile for 211 lab3 schedule exercise

schedule: schedule.o course.o
	g++ -Wall -pedantic -o schedule schedule.o course.o

schedule.o: schedule.cpp course.h
	g++ -Wall -pedantic -c schedule.cpp

course.o: course.cpp course.h
	g++ -Wall -pedantic -c course.cpp

clean:
	rm -f schedule schedule.o course.o
