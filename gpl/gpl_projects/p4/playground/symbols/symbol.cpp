#include "symbol.h"

Symbol::Symbol(string p_name, Gpl_type p_type, void* p_value, bool p_is_array) {
    name  = p_name;
    type  = p_type;
    value = p_value;
    is_array = p_is_array;
}
