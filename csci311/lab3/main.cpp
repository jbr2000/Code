// Mcwilliams, Spencer
// smcwilliams
// main.cpp

#include <iostream>
#include <fstream>
#include <map>
#include <assert.h>
using namespace std;

#include "wordcounts.h"
#include "filereader.h"
#include "rbtree.h"

int main(int argc, char *argv[]) {
// check for correct amount of arguments
    assert(argc == 2);

    string word;
    FileReader filereader;
    RBTree rbtree;
    WordCounts wordcounts;

    filereader.open(argv[1]);

// insert all words into tree
    // Get a new word from input file.
    while(filereader.get_word(word)){
        // If the word has substance, add the word to the tree.
        if(!word.empty())
            // calling helper function
            wordcounts.insert(rbtree, word);
        word.clear();
    }

// delete desired nodes
    rbtree.treewalk(rbtree, rbtree.root);

    return 0;
}
