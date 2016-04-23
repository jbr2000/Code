#include <iostream>
#include <string>
using namespace std;

#include "symbol_table.h"

int line_count;

int main() {
    Symbol_table *table = Symbol_table::instance();

    table->add_symbol(new Symbol("a", INT, new int(5), true));

    table->print(cout);
}
