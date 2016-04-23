#include "print_stmt.h"

Print_stmt::Print_stmt(int p_line_number, Expression* p_expr) {
    expr = p_expr;
    line_number = p_line_number;
}

void Print_stmt::execute() {
    string val = *((string*)(expr->evaluate_to_type(STRING)->value));
    cout << "gpl["<< line_number << "]: " << val << endl;
}
