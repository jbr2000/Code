// Spencer McWilliams
// smcwilliams
// lab1.cpp

#include <fstream>
#include <iostream>
#include <assert.h>
#include <ctype.h>
#include <map>
using namespace std;

#include "lab1.h"


// FileParse Class Definitions
FileParse::FileParse(){}
FileParse::~FileParse(){}
void FileParse::open(char file_in_name[]){
    file_in.open(file_in_name);
} 
bool FileParse::get_word(string &word){
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

// MapInterface Class Definitions
MapInterface::MapInterface(){}
MapInterface::~MapInterface(){} 
void MapInterface::put_word(string word){
    map<string,int>::iterator iter;
    iter = word_map.find(word);

    if(iter == word_map.end()){
        word_map.insert(pair<string,int>(word,1));
    }
    else
        word_map[word] += 1;
}
void MapInterface::print(){
    map<string,int>::iterator iter;

    for(iter = word_map.begin(); iter != word_map.end(); iter++){
    cout << (*iter).first << " " << (*iter).second << endl;
    }
}
