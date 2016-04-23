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
            unsigned int array_size;
            switch (symbol->type) {
                case INT:    array_size = (*(vector<int>*)    symbol->value).size(); break;
                case DOUBLE: array_size = (*(vector<double>*) symbol->value).size(); break;
                case STRING: array_size = (*(vector<string>*) symbol->value).size(); break;
                default: break;
            }
            // populate vector
            for (unsigned int i=0; i<array_size; i++) {
                os << symbol->type << " " << symbol->name << "[" << i << "] ";
                switch (symbol->type) {
                    case INT:    os         << (*(vector<int>*)    symbol->value)[i] << endl;   break;
                    case DOUBLE: os         << (*(vector<double>*) symbol->value)[i] << endl;   break;
                    case STRING: os << "\"" << (*(vector<string>*) symbol->value)[i] << "\"\n"; break;
                    default:     os << "Symbol type incorrect in switch.\n";                    break;
                }
            }
        }
        else { // symbol not array
            os << symbol->type << " " << symbol->name << " ";
            switch (symbol->type) {
                case INT:    os         << *(int *)(symbol->value)    << endl;   break;
                case DOUBLE: os         << *(double *)(symbol->value) << endl;   break;
                case STRING: os << "\"" << *(string *)(symbol->value) << "\"\n"; break;
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
            switch (symbol->type) {
                case INT:    ptr = new vector<int>;    break;
                case DOUBLE: ptr = new vector<double>; break;
                case STRING: ptr = new vector<string>; break;
                default:                               break;
            }
            int array_size = *(int*)symbol->value;
            // populate vector
            for (int i=0; i<array_size; i++) {
                switch (symbol->type) {
                    case INT:    (*(vector<int>*)   ptr).push_back(42);            break;
                    case DOUBLE: (*(vector<double>*)ptr).push_back(3.14159);       break;
                    case STRING: (*(vector<string>*)ptr).push_back("Hello world"); break;
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
    else { // variable already exists
        Error::error(Error::PREVIOUSLY_DECLARED_VARIABLE, symbol->name);
    }
    return false;
}
