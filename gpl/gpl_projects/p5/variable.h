#include <string>
using namespace std;
#include "gpl_type.h"

class Expression;
class Symbol;

class Variable {
    public:
        // Member Variables
        int variable_type;
        string field;
        Symbol *symbol;
        Gpl_type return_type;
        Expression *index_expression;

        // Member Functions
        void *get_value();
        // int a = b;
        Variable(string symbol_name);
        // int a = object.x
        Variable(string symbol_name, string p_field);
        // int a = nums[5*3]
        Variable(string symbol_name, Expression *p_index_expression);
        // int a = objects[4].y
        Variable(string symbol_name, string p_field, Expression *p_index_expression);
};
