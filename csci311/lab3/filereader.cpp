// Spencer McWilliams
// smcwilliams
// filereader.cpp

#include <iostream>
using namespace std;

#include "filereader.h"

// FileReader Class Definitions
FileReader::FileReader(){}
FileReader::~FileReader(){}
void FileReader::open(char file_in_name[]){
    file_in.open(file_in_name);
} 
bool FileReader::get_word(string &word){
    string buffer;
    char next;
    while(!isspace(file_in.peek()) and file_in.peek() != -1){
        next = file_in.get(); 
        if(isalnum(next))
            buffer += tolower(next);
    }
    if(file_in.peek() == -1){
        return false;
    }
    file_in.ignore();
    if(!buffer.empty())
        word = buffer;
    return true;
}
