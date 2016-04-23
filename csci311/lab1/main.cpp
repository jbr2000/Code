// Mcwilliams, Spencer
// smcwilliams
// main.cpp

#include <iostream>
#include <fstream>
#include <map>
#include <assert.h>
using namespace std;

#include "lab1.h"

int main(int argc, char *argv[]) {
// check for correct amount of arguments
    assert(argc == 2);

    string word;
    FileParse fileparse;
    MapInterface wordmap;

    fileparse.open(argv[1]);

    while(fileparse.get_word(word)){
        if(!word.empty())
            wordmap.put_word(word);
        word.clear();
    }

    wordmap.print();

    return 0;
}
