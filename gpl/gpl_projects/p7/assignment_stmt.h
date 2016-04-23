#ifndef ASSIGNMENT_STMT_H
#define ASSIGNMENT_STMT_H

#include "statement.h"
#include "variable.h"
#include "expression.h"
#include "symbol.h"

enum ASSIGNMENT_TYPE { ASSIGN, PLUS_ASSIGN, MINUS_ASSIGN };

class Assignment_stmt : public Statement {
    public:
        Assignment_stmt(Variable* p_left, ASSIGNMENT_TYPE p_type, Expression* p_right);
        ~Assignment_stmt();
        void execute();
        Variable* left;
        Expression* right;
        ASSIGNMENT_TYPE type;
};

#endif 
