#ifndef SYMBOL_H
#define SYMBOL_H
#include <string>
using namespace std;

#include "gpl_type.h"
#include "game_object.h"

class Symbol {
    public:
        string      name;
        Gpl_type    type;
        void        *value;
        int         array_size;

        Symbol(string p_name, Gpl_type p_type, void* p_value);
        Symbol(string p_name, Gpl_type p_type, int p_array_size);
        Symbol(string p_name, Game_object* p_value, int p_array_size);
};
#endif
