// Spencer McWilliams
// smcwilliams
// lab1.h

#include <map>
#include <fstream>
using namespace std;

#ifndef LAB1_H
#define LAB1_H

class FileParse
{
    public:
        FileParse();
        ~FileParse();
        // Function: Opens file stream that is already instantiated as a private variable in FileParse class as <file_in>.
        // Expects: A cstring that is the name of the input file <file_in_name>.
        // Returns: Nothing
        void open(char file_in_name[]);
        // Function: Using the private input stream <file_in> it will pull one word, ignoring non-alphanumaric characters and return that word.
        // Expects: String by reference to store word.
        // Returns: True if word was parsed. False if EOF was reached.
        bool get_word(string &word); 
    private:
        ifstream file_in;
};

class MapInterface
{
    public:
        MapInterface();
        ~MapInterface();
        // Function: Puts given string <word> into the map that is already instantiated as a public variable of MapInterface. If the key is not already in the map, it will create a new branch in the map with the given key <word> and a value of 1. If the word already exists, it will add 1 to the paired integer value of the key.
        // Expects: String to be used as key for the map <word>.
        // Returns: Nothing.
        void put_word(string word);
        // Function: Prints out all of the elements of <word_map>
        // Expects: Nothing
        // Returns: Nothing
        void print();
        map<string,int> word_map;

};

#endif
