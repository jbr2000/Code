// Spencer McWilliams
// smcwilliams
// wordcounts.h

#include <vector>
using namespace std;
#include "rbtree.h"

#ifndef WORDCOUNTS_H
#define WORDCOUNTS_H

class WordCounts{
    public:
        WordCounts();
        ~WordCounts();
        void insert(RBTree &T, string word);
};

#endif
