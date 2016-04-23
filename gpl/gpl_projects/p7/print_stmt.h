#ifndef PRINT_STMT_H
#define PRINT_STMT_H

#include "expression.h"
#include "statement.h"

class Print_stmt : public Statement {
    public:
        Print_stmt(int p_line_number, Expression* p_expr);
        Expression *expr;
        int line_number;
        void execute();
};

#endif 
