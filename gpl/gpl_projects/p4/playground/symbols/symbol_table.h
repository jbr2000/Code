#include <iostream>
#include <string>
#include <map>
#include <sstream>
#include <vector>
using namespace std;

#include "symbol.h"
#include "gpl_type.h"

// class Symbol_table is a singleton
class Symbol_table
{
    public:
        static Symbol_table *instance();
        void print(ostream &os);
        bool add_symbol(Symbol *symbol);
        map<string,Symbol*> m_map;

    private:
        static Symbol_table *m_instance;
        Symbol_table() {};
        Symbol_table(const Symbol_table &);
        const Symbol_table &operator=(const Symbol_table &);
                                                  
};

