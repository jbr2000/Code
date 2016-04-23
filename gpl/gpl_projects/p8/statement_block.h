#ifndef STATEMENT_BLOCK_H
#define STATEMENT_BLOCK_H

#include <iostream>
#include <vector>
using namespace std;

#include "indent.h"
#include "statement.h"

class Game_object;

class Statement_block
{
  public:
    Statement_block();

    // return true if the statement block contains no statements
    bool empty();

    // This is called when a statement block is executed
    // Implement it for p7
    void execute();

    vector<Statement*> statements;
  
};

#endif // #ifndef STATEMENT_BLOCK_H
