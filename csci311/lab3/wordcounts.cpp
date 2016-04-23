// Spencer McWilliams
// smcwilliams
// wordcounts.cpp

#include <iostream>
#include <utility>
#include <vector>
using namespace std;

#include "wordcounts.h"
#include "rbtree.h"

WordCounts::WordCounts(){}
WordCounts::~WordCounts(){}

void WordCounts::insert(RBTree &T, string word){
    Node* z = T.rbinsert(T, word);
    if(z){
        z->data.second++;
    }
}
