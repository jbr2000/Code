#include <iostream>
#include <string>
#include <map>
#include <sstream>
#include <vector>
using namespace std;

#include "symbol.h"
#include "gpl_type.h"
#include "error.h"

// class Symbol_table is a singleton
class Symbol_table
{
    public:
        void   print(ostream &os);
        bool   add_symbol(Symbol *symbol);
        Symbol *get_symbol(string symbol_name);

        bool get(string p_name, int& p_value);
        bool get(string p_name, double& p_value);
        bool get(string p_name, string& p_value);
        bool get_type(string p_name, Gpl_type& p_type);
        void set(string p_name, int p_value);

        map<string,Symbol*> m_map;
        static Symbol_table *instance();
    private:
        static Symbol_table *m_instance;
        Symbol_table() {};
        Symbol_table(const Symbol_table &);
        const Symbol_table &operator=(const Symbol_table &);
                                                  
};

