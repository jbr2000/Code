#include "symbol_table.h"
#include "game_object.h"
#include "indent.h"
#include "rectangle.h"
#include "triangle.h"
#include "circle.h"
#include "pixmap.h"
#include "textbox.h"


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
        if (symbol->array_size) {
            for (int i=0; i<symbol->array_size; i++) {
                os << symbol->type << " " << symbol->name << "[" << i << "]";
                switch (symbol->type) {
                    case INT:    os << " "  << *((int   *)((*((vector<void*>*)(symbol->value)))[i])) << endl;   break;
                    case DOUBLE: os << " "  << *((double*)((*((vector<void*>*)(symbol->value)))[i])) << endl;   break;
                    case STRING: os << " \"" << *((string*)((*((vector<void*>*)(symbol->value)))[i])) << "\"" << endl;   break;
                    case GAME_OBJECT: 
                        indent++;
                        os << endl << *((Game_object*)((*((vector<void*>*)(symbol->value)))[i])) << endl;
                        indent--;
                        break;
                    default:     os << "Symbol type incorrect in switch.\n"; break;
                }
            }
        }
        else { // symbol not array
            os << symbol->type << " " << symbol->name;
            switch (symbol->type) {
                case INT:    os << " "   << *((int   *)(symbol->value)) << endl;   break;
                case DOUBLE: os << " "   << *((double*)(symbol->value)) << endl;   break;
                case STRING: os << " \"" << *((string*)(symbol->value)) << "\"\n"; break;
                case GAME_OBJECT:
                    indent++;
                    os << endl << *((Game_object*)(symbol->value)) << endl;
                    indent--;
                    break;
                case ANIMATION_BLOCK: os << endl; break;
                default:     os << "Symbol type incorrect in switch.\n"; break;
            }
        }
        os.flush();
    }
}

bool Symbol_table::add_symbol(Symbol *symbol){
    
    if (m_map.find(symbol->name) == m_map.end()){ // variable with id doesn't exist
        if (symbol->array_size){
            // create vector pointer
            vector<void*>* ptr = new vector<void*>;
            // populate vector
            for (int i=0; i<symbol->array_size; i++) {
                switch (symbol->type) {
                    case INT:    ptr->push_back(new int(0)); break;
                    case DOUBLE: ptr->push_back(new double()); break;
                    case STRING: ptr->push_back(new string()); break;
                    case GAME_OBJECT:
                        Game_object* tmp;
                        if (((Game_object*)(symbol->value))->type() == "Rectangle")
                            tmp = new Rectangle();
                        else if (((Game_object*)(symbol->value))->type() == "Triangle")
                            tmp = new Triangle();
                        else if (((Game_object*)(symbol->value))->type() == "Circle")
                            tmp = new Circle();
                        else if (((Game_object*)(symbol->value))->type() == "Pixmap")
                            tmp = new Pixmap();
                        else if (((Game_object*)(symbol->value))->type() == "Textbox")
                            tmp = new Textbox();
                        ptr->push_back(tmp);
                        break;
                    default: break;
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

bool Symbol_table::get(string p_name, int& p_value) {
    if (this->get_symbol(p_name)) {
        p_value = *((int*)(this->get_symbol(p_name)->value));
        return true;
    }
    else return false;
}
bool Symbol_table::get(string p_name, double& p_value) {
    if (this->get_symbol(p_name)) {
        p_value = *((double*)(this->get_symbol(p_name)->value));
        return true;
    }
    else return false;
}
bool Symbol_table::get(string p_name, string& p_value) {
    if (this->get_symbol(p_name)) {
        p_value = *((string*)(this->get_symbol(p_name)->value));
        return true;
    }
    else return false;
}
bool Symbol_table::get_type(string p_name, Gpl_type& p_type) {
    if (this->get_symbol(p_name)) {
        p_type = (Gpl_type)(this->get_symbol(p_name)->type);
        return true;
    }
    else return false;
}
void Symbol_table::set(string p_name, int p_value){
    if (this->get_symbol(p_name))
        (this->get_symbol(p_name)->value) = new int(p_value);
}
