#ifndef VARIABLE_H
#define VARIABLE_H

#include "gpl_type.h"

#include <string>
using namespace std;

class Expression;
class Symbol;

class Variable {
    public:
        // Member Variables
        int variable_type;
        Expression* index;
        string field;
        Symbol *symbol;
        Gpl_type return_type;

        // Member Functions
        void *get_value();
        void set_value(void* p_value);
        // int a = b;
        Variable(string symbol_name);
        // int a = object.x
        Variable(string symbol_name, string p_field);
        // int a = nums[5*3]
        Variable(string symbol_name, Expression* p_index);
        // int a = objects[4].y
        Variable(string symbol_name, string p_field, Expression* p_index);
};

#endif
