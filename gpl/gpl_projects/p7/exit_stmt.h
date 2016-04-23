#ifndef EXIT_STMT_H
#define EXIT_STMT_H

#include "statement.h"
#include "expression.h"

class Exit_stmt : public Statement {
    public:
        Exit_stmt(int p_line_number, Expression* p_expr);
        ~Exit_stmt();
        Expression* expr;
        int line_number;
        void execute();
};

#endif 
