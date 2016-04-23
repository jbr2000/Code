#ifndef IF_STMT_H
#define IF_STMT_H

#include "expression.h"
#include "statement_block.h"

class If_stmt : public Statement {
    public:
        If_stmt(Expression* p_expr, Statement_block* p_then_block);
        If_stmt(Expression* p_expr, Statement_block* p_then_block, Statement_block* p_else_block);
        ~If_stmt();
        void execute();
        Expression* expr;
        Statement_block* then_block;
        Statement_block* else_block;
};

#endif 
