#include "variable.h"
#include "expression.h"
#include "game_object.h"
#include "symbol_table.h"

Variable::Variable(string symbol_name) {
    if (symbol_name == "DUMMY_VARIABLE") {
        symbol = new Symbol("DUMMY_SYMBOL", INT, new int(0));
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
    ((Game_object*)(symbol->value))->get_member_variable_type(p_field, return_type);
    field = p_field;
    variable_type = 2;
}

Variable::Variable(string symbol_name, Expression* p_index) {
    symbol = Symbol_table::instance()->get_symbol(symbol_name);
    return_type = symbol->type;
    index = p_index;
    variable_type = 3;
}

Variable::Variable(string symbol_name, string p_field, Expression* p_index) {
    symbol = Symbol_table::instance()->get_symbol(symbol_name);
    field = p_field;
    ((Game_object*)((*((vector<void*>*)(symbol->value)))[*((int*)(p_index->evaluate_to_type(INT)->value))]))->get_member_variable_type(p_field, return_type);
    index = p_index;
    variable_type = 4;
}

void* Variable::get_value() {
    int ret_int;
    double ret_double;
    string ret_string;
    Gpl_type type;
    
    switch (variable_type) {
        // DUMMY_VARIABLE
        case 0: return new int(0); break; 
        case 1: return symbol->value; break;
        case 2: {
            Game_object* obj = (Game_object*)(symbol->value);
            obj->get_member_variable_type(this->field, type);
            switch (type) {
                case INT:    obj->get_member_variable(this->field, ret_int);    return new int(ret_int);       break;
                case DOUBLE: obj->get_member_variable(this->field, ret_double); return new double(ret_double); break;
                case STRING: obj->get_member_variable(this->field, ret_string); return new string(ret_string); break;
                default: assert(0); break;
            }
            break; }
        case 3: {
            if ((unsigned int)*((int*)(index->evaluate_to_type(INT)->value)) > ((vector<void*>*)(symbol->value))->size() -1) {
                Error::error(Error::ARRAY_INDEX_OUT_OF_BOUNDS,
                    symbol->name, *((string*)(index->evaluate_to_type(STRING)->value)));
                return (*((vector<void*>*)(symbol->value)))[0];
            }
            else return (*((vector<void*>*)(symbol->value)))[*((int*)(index->evaluate_to_type(INT)->value))]; break; }
        case 4: {
            Game_object* obj;
            if ((unsigned int)*((int*)(index->evaluate_to_type(INT)->value)) > ((vector<void*>*)(symbol->value))->size() -1) {
                Error::error(Error::ARRAY_INDEX_OUT_OF_BOUNDS,
                    symbol->name, *((string*)(index->evaluate_to_type(STRING)->value)));
                obj = (Game_object*)((*(vector<void*>*)(symbol->value))[0]);
            }
            else {
                obj = ((Game_object*)((*((vector<void*>*)(symbol->value)))
                                   [*((int*)(index->evaluate_to_type(INT)->value))]));
            }
            obj->get_member_variable_type(this->field, type);
            switch (type) {
                case INT:    obj->get_member_variable(this->field, ret_int);    return new int(ret_int);       break;
                case DOUBLE: obj->get_member_variable(this->field, ret_double); return new double(ret_double); break;
                case STRING: obj->get_member_variable(this->field, ret_string); return new string(ret_string); break;
                default: assert(0); break;
            }
            break; }
        default: assert(0); break;
    }
    return NULL;
}

void Variable::set_value(void* p_value) {
    Gpl_type type;

    switch (variable_type) {
        case 0: assert(0); break;
        case 1: symbol->value = p_value; break;
        case 2: {
            Game_object* obj = (Game_object*)(symbol->value);
            assert(OK == obj->get_member_variable_type(field, type));
            switch (type) {
                case INT: obj->set_member_variable(field, *((int*)(p_value))); break;
                case DOUBLE: obj->set_member_variable(field, *((double*)(p_value))); break;
                case STRING: obj->set_member_variable(field, *((string*)(p_value))); break;
                default: assert(0); break;
            }
            break; }
        case 3: 
            if ((unsigned int)*((int*)(index->evaluate_to_type(INT)->value)) >= ((vector<void*>*)(symbol->value))->size()) {
                Error::error(Error::ARRAY_INDEX_OUT_OF_BOUNDS,
                    symbol->name, *((string*)(index->evaluate_to_type(STRING)->value)));
                ((*((vector<void*>*)(symbol->value)))[0]) = p_value;
            }
            else {
                ((*((vector<void*>*)(symbol->value)))
                    [*((int*)(index->evaluate_to_type(INT)->value))]) = p_value;
            }
            break;
        case 4: {
            Game_object* obj;
            if ((unsigned int)*((int*)(index->evaluate_to_type(INT)->value)) >= ((vector<void*>*)(symbol->value))->size()) {
                Error::error(Error::ARRAY_INDEX_OUT_OF_BOUNDS,
                    symbol->name, *((string*)(index->evaluate_to_type(STRING)->value)));
                obj = (Game_object*)((*((vector<void*>*)(symbol->value)))[0]);
            }
            else {
                obj = (Game_object*)((*((vector<void*>*)(symbol->value)))
                                   [*((int*)(index->evaluate_to_type(INT)->value))]);
            }
            assert(OK == obj->get_member_variable_type(field, type));
            switch (type) {
                case INT: obj->set_member_variable(field, *((int*)(p_value))); break;
                case DOUBLE: obj->set_member_variable(field, *((double*)(p_value))); break;
                case STRING: obj->set_member_variable(field, *((string*)(p_value))); break;
                default: assert(0); break;
            }
            break; }
        default: assert(0); break;
    }
}
