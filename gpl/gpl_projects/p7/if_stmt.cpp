#include "if_stmt.h"

If_stmt::If_stmt(Expression* p_expr, Statement_block* p_then_block)
{
    expr = p_expr;
    then_block = p_then_block;
    else_block = NULL;
}

If_stmt::If_stmt(Expression* p_expr, Statement_block* p_then_block, Statement_block* p_else_block)
{
    expr = p_expr;
    then_block = p_then_block;
    else_block = p_else_block;
}

If_stmt::~If_stmt() { }

void If_stmt::execute()
{
    if(*((int*)(expr->evaluate_to_type(INT)->value))) {
        then_block->execute();
    }
    else if(else_block) else_block->execute();
}
