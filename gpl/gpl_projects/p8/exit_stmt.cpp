#include "exit_stmt.h"

Exit_stmt::Exit_stmt(int p_line_number, Expression* p_expr) {
    expr        = p_expr;
    line_number = p_line_number;
}

Exit_stmt::~Exit_stmt() { }

void Exit_stmt::execute() {
    int val = *((int*)(expr->evaluate_to_type(INT)->value));
    cout << "gpl[" << line_number << "]: exit(" << val << ")\n";
    exit(val);
}
