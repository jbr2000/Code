#include "symbol_table.h"

/* static */ Symbol_table *Symbol_table::m_instance = NULL;
/* static */ Symbol_table * Symbol_table::instance()
{
    if (m_instance == NULL)
        m_instance = new Symbol_table();
    return m_instance;
}

void Symbol_table::print(ostream &os) {
    for (map<string,Symbol*>::iterator it=m_map.begin(); it!=m_map.end(); ++it) {
        Symbol *symbol = it->second;
        
        if (symbol->is_array) {
            switch (symbol->type) {
                case INT:
                    for (unsigned int i=0; i<(*(vector<int>*)symbol->value).size(); i++) {
                        os << symbol->type << " " << symbol->name << "[" << i << "]" << (*(vector<int>*)symbol->value)[i] << endl;
                    }
                    break;
                case DOUBLE:
                    break;
                case STRING:
                    break;
                case GAME_OBJECT:
                    break;
                default:
                    break;
            }
        }
        else { // not array
            os << symbol->type << " " << symbol->name << " ";
            if (symbol->type == INT)
                os << *(int *)(symbol->value) << endl;
            else if (symbol->type == DOUBLE)
                os << *(double *)(symbol->value) << endl;
            else if (symbol->type == STRING)
                os << "\"" << *(string *)(symbol->value) << "\"\n";
            else
                os << "dun fuqd up\n";
        }
    }
}

// *(int *)symbol->value => array size OR value
bool Symbol_table::add_symbol(Symbol *symbol){
    void *ptr;

    if (m_map.find(symbol->name) == m_map.end()){ // check if variable with id exists
        if (symbol->is_array){
            switch (symbol->type) {
                case INT:
                    ptr = new vector<int>;
                    for (int i=0; i<*(int *)symbol->value; i++) // fill vector
                        (*(vector<int>*)ptr).push_back(42);
                    break;
                case DOUBLE:
                    ptr = new vector<double>;
                    for (int i=0; i<*(int *)symbol->value; i++) // fill vector
                        (*(vector<double>*)ptr).push_back(3.14159);
                    break;
                case STRING:
                    ptr = new vector<string>;
                    for (int i=0; i<*(int *)symbol->value; i++) // fill vector
                        (*(vector<string>*)ptr).push_back("Hello world");
                    break;
                case GAME_OBJECT:
                    break;
                default:
                    break;
            }

        /*    if (symbol->type == INT) {
                ptr = new vector<int>;
                for (int i=0; i<*(int *)symbol->value; i++) // fill vector
                    (*(vector<int>*)ptr).push_back(42);
            }
            else if (symbol->type == DOUBLE) {
                ptr = new vector<double>;
                for (int i=0; i<*(int *)symbol->value; i++) // fill vector
                    (*(vector<double>*)ptr).push_back(3.14159);
            }
            else if (symbol->type == STRING) {
                ptr = new vector<string>;
                for (int i=0; i<*(int *)symbol->value; i++) // fill vector
                    (*(vector<string>*)ptr).push_back("Hello world");
            }
            */
            symbol->value = ptr;
        }
        m_map.insert(std::pair<string,Symbol*>(symbol->name,symbol));
        return true;
    }
    return false;
}
