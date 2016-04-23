#include "symbol_table.h"

/* static */ Symbol_table *Symbol_table::m_instance = NULL;
/* static */ Symbol_table * Symbol_table::instance()
{
    if (m_instance == NULL)
        m_instance = new Symbol_table();
    return m_instance;
}

void Symbol_table::print(ostream &os) {
    // iterate through all symbols
    for (map<string,Symbol*>::iterator it=m_map.begin(); it!=m_map.end(); ++it) {
        Symbol *symbol = it->second;
        if (symbol->is_array) {
            // get size
            unsigned int array_size = (*((vector<void *>*)(symbol->value))).size();
            // populate vector
            for (unsigned int i=0; i<array_size; i++) {
                os << symbol->type << " " << symbol->name << "[" << i << "] ";
                switch (symbol->type) {
                    case INT:    os         << *((int   *)((*((vector<void*>*)(symbol->value)))[i])) << endl;   break;
                    case DOUBLE: os         << *((double*)((*((vector<void*>*)(symbol->value)))[i])) << endl;   break;
                    case STRING: os << "\"" << *((string*)((*((vector<void*>*)(symbol->value)))[i])) << "\"" << endl;   break;
                    default:     os << "Symbol type incorrect in switch.\n";                    break;
                }
            }
        }
        else { // symbol not array
            os << symbol->type << " " << symbol->name << " ";
            switch (symbol->type) {
                case INT:    os         << *((int   *)(symbol->value)) << endl;   break;
                case DOUBLE: os         << *((double*)(symbol->value)) << endl;   break;
                case STRING: os << "\"" << *((string*)(symbol->value)) << "\"\n"; break;
                default:     os << "Symbol type incorrect in switch.\n";         break;
            }
        }
    }
}


bool Symbol_table::add_symbol(Symbol *symbol){
    void *ptr;
    if (m_map.find(symbol->name) == m_map.end()){ // variable with id doesn't exist
        if (symbol->is_array){
            // create vector pointer
            ptr = new vector<void *>;
            int array_size = *(int*)symbol->value;
            // populate vector
            for (int i=0; i<array_size; i++) {
                switch (symbol->type) {
                    case INT:    (*(vector<void *>*)ptr).push_back(new int(0)); break;
                    case DOUBLE: (*(vector<void *>*)ptr).push_back(new double(3.14159)); break;
                    case STRING: (*(vector<void *>*)ptr).push_back(new string("Hello world")); break;
                    default:                                                       break;
                }
            }
            // symbol points to vector
            symbol->value = ptr;
        }
        // insert symbol
        m_map.insert(std::pair<string,Symbol*>(symbol->name,symbol));
        return true;
    }
    return false;
}

Symbol* Symbol_table::get_symbol(string symbol_name) {
    // check if symbol exists
    map<string,Symbol*>::iterator it = Symbol_table::instance()->m_map.find(symbol_name);
    if (it == Symbol_table::instance()->m_map.end()) // doesn't exist
        return NULL;
    else
        return it->second;
}
