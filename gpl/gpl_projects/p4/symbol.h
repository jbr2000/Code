#include <string>
using namespace std;

#include "gpl_type.h"

class Symbol {
    public:
        string      name;
        Gpl_type    type;
        void*       value;
        bool        is_array;

        // STDVAR:      foo = p_value;
        // ARRAY:       foo[p_value];
        // GAME_OBJECT: ??
        Symbol(string p_name, Gpl_type p_type, void* p_value, bool p_is_array);
};
