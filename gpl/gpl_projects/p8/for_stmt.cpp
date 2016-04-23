#include "for_stmt.h"

For_stmt::For_stmt(Statement_block* p_initializer,
                   Expression*      p_expr,
                   Statement_block* p_incrementor,
                   Statement_block* p_body)
{
    initializer = p_initializer;
    expr = p_expr;
    incrementor = p_incrementor;
    body = p_body;
}

For_stmt::~For_stmt() {}

void For_stmt::execute() {
    for(initializer->execute(); *((int*)(expr->evaluate_to_type(INT)->value)); incrementor->execute())
        body->execute();
}
