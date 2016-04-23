run: main.o dlist.o trie.o
	g++ -o run main.o  dlist.o trie.o
trie.o: trie.cpp trie.h node.h
	g++  -c -Wall -pedantic -g -std=c++11 trie.cpp
dlist.o: dlist.cpp dlist.h node.h
	g++ -c -Wall -pedantic -g -std=c++11 dlist.cpp
main.o: main.cpp trie.h priority_queue.h 
	g++ -c -Wall -pedantic -g -std=c++11 main.cpp
clean: 
	rm main.o  dlist.o run trie.o
