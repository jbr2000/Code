#ifndef FOR_STMT_H
#define FOR_STMT_H

#include "statement.h"
#include "statement_block.h"
#include "expression.h"

class For_stmt : public Statement {
    public:
        For_stmt(Statement_block* p_initializer,
                 Expression*      p_expr,
                 Statement_block* p_incrementor,
                 Statement_block* p_body);
        ~For_stmt();
        void execute();
        Statement_block* initializer;
        Statement_block* incrementor;
        Statement_block* body;
        Expression* expr;
};

#endif 
