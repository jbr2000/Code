#include "variable.h"
#include "expression.h"
#include "symbol_table.h"

Variable::Variable(string symbol_name) {
    if (symbol_name == "DUMMY_VARIABLE") {
        symbol = new Symbol("DUMMY_SYMBOL", INT, new int(0), false);
        return_type = INT;
        variable_type = 0;
        //cout << "Created Dummy Variable!!\n";
        return;
    }
    symbol = Symbol_table::instance()->get_symbol(symbol_name);
    return_type = symbol->type;
    variable_type = 1;
}

Variable::Variable(string symbol_name, string p_field) {
    symbol = Symbol_table::instance()->get_symbol(symbol_name);
    return_type = symbol->type;
    variable_type = 2;

    field = p_field;
}

Variable::Variable(string symbol_name, Expression *p_index_expression) {
    symbol = Symbol_table::instance()->get_symbol(symbol_name);
    return_type = symbol->type;
    variable_type = 3;
    
    index_expression = p_index_expression;
}

Variable::Variable(string symbol_name, string p_field, Expression *p_index_expression) {
    symbol = Symbol_table::instance()->get_symbol(symbol_name);
    return_type = symbol->type;
    variable_type = 4;

    field = p_field;
    index_expression = p_index_expression;
}

void *Variable::get_value() {
    // different ways of evaluating each type of variable
    switch (variable_type) {
        // DUMMY_VARIABLE
        case 0: return new int(0); break; 
        case 1: return symbol->value; break;
        case 2: break;
        case 3:
          //return vec[index]
            return (*((vector<void*>*)(symbol->value)))[*((int*)(index_expression->evaluate_to_type(INT)->value))];
            break;
        case 4: break;
        default: break;
    }
    return NULL;
}
