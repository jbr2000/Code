#include "statement_block.h"
#include "gpl_assert.h"
using namespace std;


Statement_block::Statement_block()
{

}

// Return true if this statement_block has no statements, false otherwise
// Implement this function for p7 (but you won't need it until p8)
bool Statement_block::empty()
{
  return statements.empty();
}

void Statement_block::execute()
{
    for (unsigned int i=0; i<statements.size(); i++) {
        statements[i]->execute();
    }
}
