#include "assignment_stmt.h"

Assignment_stmt::Assignment_stmt(Variable* p_left, ASSIGNMENT_TYPE p_type, Expression* p_right)
{
    right = p_right;
    left = p_left;
    type = p_type;
}

Assignment_stmt::~Assignment_stmt()
{
}

void Assignment_stmt::execute()
{
    switch (type) {
        case ASSIGN: {
            left->set_value(right->evaluate_to_type(left->return_type)->value); break;
        }
        case PLUS_ASSIGN: {
            Expression* left_expr = new Expression(left);
            Expression* plus = new Expression(PLUS, left->return_type, left_expr, right);
            left->set_value(plus->evaluate_to_type(left->return_type)->value);
            break; }
        case MINUS_ASSIGN: {
            Expression* left_expr = new Expression(left);
            Expression* minus = new Expression(MINUS, left->return_type, left_expr, right);
            left->set_value(minus->evaluate_to_type(left->return_type)->value);
            break; }
        default: assert(0); break;
    }
}
