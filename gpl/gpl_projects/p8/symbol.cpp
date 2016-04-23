#include "symbol.h"

Symbol::Symbol(string p_name, Gpl_type p_type, void* p_value) {
    name       = p_name;
    type       = p_type;
    value      = p_value;
    array_size = 0;
}

Symbol::Symbol(string p_name, Gpl_type p_type, int p_array_size) {
    name       = p_name;
    type       = p_type;
    value      = NULL;
    array_size = p_array_size;
}

Symbol::Symbol(string p_name, Game_object* p_value, int p_array_size) {
    name       = p_name;
    type       = GAME_OBJECT;
    value      = p_value;
    array_size = p_array_size;
}
