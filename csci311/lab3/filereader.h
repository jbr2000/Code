// Spencer McWilliams
// smcwilliams
// filereader.h

#include <fstream>
using namespace std;

#ifndef FILEREADER_H
#define FILEREADER_H 

class FileReader 
{
    public:
        FileReader();
        ~FileReader();
        // Function: Opens file stream that is already instantiated as a private variable in FileReader class as <file_in>.
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

#endif
