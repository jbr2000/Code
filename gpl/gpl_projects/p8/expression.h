#ifndef EXPRESSION_H
#define EXPRESSION_H

#include <string>
#include <iostream>
#include <assert.h>
#include <cmath>
using namespace std;

#include "gpl_type.h"

class Variable;

enum Node_type {CONSTANT, VARIABLE, BINARY_OPERATOR, UNARY_OPERATOR, GEOMETRIC_OPERATOR, BINARY_LOGICAL_OPERATOR, NO_CAST};

class Expression {
    public:
        // member variables
        void            *value;
        Expression      *left;
        Expression      *right;
        Variable        *variable;
        Gpl_type        return_type;
        Operator_type   operator_type;
        Node_type       node_type;

        // member functions
        Expression * evaluate_to_type(Gpl_type desired_type);

        // constructor and destructors
        // CONSTANT node
        Expression(void        *p_value,
                    Gpl_type    return_type,
                    Expression *p_left,
                    Expression *p_right);
        // OPERATOR node
        Expression(Operator_type p_op,
                    Gpl_type     return_type,
                    Expression  *p_left,
                    Expression  *p_right);
        // VARIABLE node
        Expression(Variable *p_variable);

    private:
        Expression * evaluate();
};

#endif
