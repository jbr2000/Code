#include "expression.h"
#include "variable.h"
#include <math.h>
#include <string>
#include <sstream>
#include <stdlib.h>
#include <iostream>
using namespace std;


// CONSTANT node
Expression::Expression(void        *p_value,
                        Gpl_type    p_return_type,
                        Expression *p_left,
                        Expression *p_right) {
    value       = p_value;
    left        = p_left;
    right       = p_right;
    return_type = p_return_type;
    node_type   = CONSTANT;
}

// OPERATOR node
Expression::Expression(Operator_type p_op_type,
                        Gpl_type     p_return_type,
                        Expression  *p_left,
                        Expression  *p_right) {
    left          = p_left;
    right         = p_right;
    return_type   = p_return_type;
    operator_type = p_op_type;
    // set node_type based on operator_type
    switch (p_op_type) {
        case PLUS:
        case MINUS:
        case MULTIPLY:
        case DIVIDE:
        case MOD:
            node_type = BINARY_OPERATOR;
            break;
        case SIN:
        case COS:
        case TAN:
        case ASIN:
        case ACOS:
        case ATAN:
        case SQRT:
        case RANDOM:
        case UNARY_MINUS:
            node_type = UNARY_OPERATOR;
            break;
        case ABS:
        case FLOOR:
        case NOT:
            node_type = NO_CAST;
            break;
        case OR:
        case AND:
        case EQUAL:
        case NOT_EQUAL:
        case GREATER_THAN:
        case GREATER_THAN_EQUAL:
        case LESS_THAN:
        case LESS_THAN_EQUAL:
            node_type = BINARY_LOGICAL_OPERATOR;
            break;
        default: cerr << "Error while setting operator_type during Expression construction.\n";
        break;
    }
}

// VARIABLE node
Expression::Expression(Variable *p_variable) {
    variable    = p_variable;
    node_type   = VARIABLE;
    return_type = p_variable->return_type;
}

// Evaluate and cast result to type
Expression* Expression::evaluate_to_type(Gpl_type desired_type) {
    stringstream ss; // buffer for casting ints and doubles to strings
    if (return_type == desired_type) // Expression's value is already the correct type
        return this->evaluate();

    // Special case for Logical Operators because they always return INT!
    if (node_type == BINARY_LOGICAL_OPERATOR || node_type == NO_CAST)
        return new Expression((this->evaluate()->evaluate_to_type(desired_type)->value),
                              desired_type,
                              NULL,
                              NULL);

    // Perform casting
    switch (return_type) {
        case INT:
            if (desired_type == DOUBLE)
                // create new DOUBLE Expression
                return new Expression(new double(*((int*)(this->evaluate()->value))),
                                      DOUBLE,
                                      NULL,
                                      NULL);
            else if (desired_type == STRING) {
                // cast value to string
                ss << *((int*)(this->evaluate()->value));
                // create new STRING Expression
                return new Expression(new string(ss.str()),
                                      STRING,
                                      NULL,
                                      NULL);
            }
            break;
        case DOUBLE:
            if (desired_type == STRING) {
                // cast value to string
                ss << *((double*)(this->evaluate()->value));
                // create new STRING Expression
                return new Expression(new string(ss.str()),
                                      STRING,
                                      NULL,
                                      NULL);
            }
            break;
        case STRING: return this; break;
        case GAME_OBJECT:
        case ANIMATION_BLOCK:
            break;
    }
    cout << "Error while casting Expression\n";
    return NULL;
}

Expression* Expression::evaluate() {
    double const RADIAN_MULTIPLIER = 0.01745329222;
    double const DEGREE_MULTIPLIER = 57.2957804904;

    // casting for operators
    switch (node_type) {
        case CONSTANT: return this; break;
        case VARIABLE: return new Expression(this->variable->get_value(),
                                              this->return_type,
                                              NULL, NULL);
            break;
        case BINARY_OPERATOR:
            left = left->evaluate_to_type(return_type);
            right = right->evaluate_to_type(return_type);
            break;
        case UNARY_OPERATOR:
            left = left->evaluate_to_type(return_type);
            break;
        case NO_CAST:
            return_type = left->return_type;
            break;
        case BINARY_LOGICAL_OPERATOR:
            Gpl_type master_type;
            master_type = (left->return_type > right->return_type) ?
                            left->return_type :
                            right->return_type;
            left = left->evaluate_to_type(master_type);
            right = right->evaluate_to_type(master_type);
            return_type = master_type; // use correct evaluation below
            break;
        default: cerr << "Error while evaluating Expression\n"; break;
    }

    // Evaluate Operator nodes
    switch (return_type) {
        case INT: {
            int left_i_value;
            int right_i_value;
            left_i_value = *((int*)(left->evaluate()->value));
            if (node_type == BINARY_OPERATOR ||
                node_type == BINARY_LOGICAL_OPERATOR)
                right_i_value = *((int*)(right->evaluate()->value));
            
            switch (operator_type) {
                case PLUS:     return new Expression(new int(left_i_value + right_i_value), INT, NULL, NULL); break;
                case MINUS:    return new Expression(new int(left_i_value - right_i_value), INT, NULL, NULL); break;
                case MULTIPLY: return new Expression(new int(left_i_value * right_i_value), INT, NULL, NULL); break;
                case DIVIDE:   return new Expression(new int(left_i_value / right_i_value), INT, NULL, NULL); break;
                case MOD:      return new Expression(new int(left_i_value % right_i_value), INT, NULL, NULL); break;
                // BINARY_LOGICAL
                case OR:                 return new Expression(new int(left_i_value || right_i_value), INT, NULL, NULL); break;
                case AND:                return new Expression(new int(left_i_value && right_i_value), INT, NULL, NULL); break;
                case EQUAL:              return new Expression(new int(left_i_value == right_i_value), INT, NULL, NULL); break;
                case NOT_EQUAL:          return new Expression(new int(left_i_value != right_i_value), INT, NULL, NULL); break;
                case LESS_THAN:          return new Expression(new int(left_i_value <  right_i_value), INT, NULL, NULL); break;
                case LESS_THAN_EQUAL:    return new Expression(new int(left_i_value <= right_i_value), INT, NULL, NULL); break;
                case GREATER_THAN:       return new Expression(new int(left_i_value >  right_i_value), INT, NULL, NULL); break;
                case GREATER_THAN_EQUAL: return new Expression(new int(left_i_value >= right_i_value), INT, NULL, NULL); break;
                // UNARY
                case NOT:         return new Expression(new int   (!        left_i_value),  INT,    NULL, NULL); break;
                case ABS:         return new Expression(new int   (abs  (   left_i_value)), INT,    NULL, NULL); break;
                case SQRT:        return new Expression(new double(sqrt (   left_i_value)), DOUBLE, NULL, NULL); break;
                case FLOOR:       return new Expression(new int   (floor(   left_i_value)), INT,    NULL, NULL); break;
                case RANDOM:      return new Expression(new int   (rand() % left_i_value),  INT,    NULL, NULL); break;
                case UNARY_MINUS: return new Expression(new int   (-        left_i_value),  INT,    NULL, NULL); break;
                // TRIG
                case SIN:  return new Expression(new double(sin (left_i_value*RADIAN_MULTIPLIER)), DOUBLE, NULL, NULL); break;
                case COS:  return new Expression(new double(cos (left_i_value*RADIAN_MULTIPLIER)), DOUBLE, NULL, NULL); break;
                case TAN:  return new Expression(new double(tan (left_i_value*RADIAN_MULTIPLIER)), DOUBLE, NULL, NULL); break;
                case ASIN: return new Expression(new double(asin(left_i_value*DEGREE_MULTIPLIER)), DOUBLE, NULL, NULL); break;
                case ACOS: return new Expression(new double(acos(left_i_value*DEGREE_MULTIPLIER)), DOUBLE, NULL, NULL); break;
                case ATAN: return new Expression(new double(atan(left_i_value*DEGREE_MULTIPLIER)), DOUBLE, NULL, NULL); break;
                default: cout << "Invalid operation on INT\n"; break;
            }
            break;
        }
        case DOUBLE: {
            double left_d_value;
            double right_d_value;
            left_d_value = *((double*)(left->evaluate()->value));
            if (node_type == BINARY_OPERATOR ||
                node_type == BINARY_LOGICAL_OPERATOR)
                right_d_value = *((double*)(right->evaluate()->value));

            switch (operator_type) {
                case PLUS:     return new Expression(new double(left_d_value + right_d_value), DOUBLE, NULL, NULL); break;
                case MINUS:    return new Expression(new double(left_d_value - right_d_value), DOUBLE, NULL, NULL); break;
                case MULTIPLY: return new Expression(new double(left_d_value * right_d_value), DOUBLE, NULL, NULL); break;
                case DIVIDE:   return new Expression(new double(left_d_value / right_d_value), DOUBLE, NULL, NULL); break;
                // EQUALITY
                case OR:                 return new Expression(new int(left_d_value || right_d_value), INT, NULL, NULL); break;
                case AND:                return new Expression(new int(left_d_value && right_d_value), INT, NULL, NULL); break;
                case EQUAL:              return new Expression(new int(left_d_value == right_d_value), INT, NULL, NULL); break;
                case NOT_EQUAL:          return new Expression(new int(left_d_value != right_d_value), INT, NULL, NULL); break;
                case LESS_THAN:          return new Expression(new int(left_d_value <  right_d_value), INT, NULL, NULL); break;
                case LESS_THAN_EQUAL:    return new Expression(new int(left_d_value <= right_d_value), INT, NULL, NULL); break;
                case GREATER_THAN:       return new Expression(new int(left_d_value >  right_d_value), INT, NULL, NULL); break;
                case GREATER_THAN_EQUAL: return new Expression(new int(left_d_value >= right_d_value), INT, NULL, NULL); break;
                // UNARY
                case NOT:         return new Expression(new int   (!        left_d_value),  INT,    NULL, NULL); break;
                case ABS:         return new Expression(new double(abs  (   left_d_value)), INT,    NULL, NULL); break;
                case SQRT:        return new Expression(new double(sqrt (   left_d_value)), DOUBLE, NULL, NULL); break;
                case FLOOR:       return new Expression(new int   (floor(   left_d_value)), INT,    NULL, NULL); break;
                case RANDOM:      return new Expression(new int   (rand() % (int)floor(left_d_value)),  INT,    NULL, NULL); break;
                case UNARY_MINUS: return new Expression(new double(-        left_d_value),  INT,    NULL, NULL); break;
                // TRIG
                case SIN:  return new Expression(new double(sin (left_d_value*RADIAN_MULTIPLIER)), DOUBLE, NULL, NULL); break;
                case COS:  return new Expression(new double(cos (left_d_value*RADIAN_MULTIPLIER)), DOUBLE, NULL, NULL); break;
                case TAN:  return new Expression(new double(tan (left_d_value*RADIAN_MULTIPLIER)), DOUBLE, NULL, NULL); break;
                case ASIN: return new Expression(new double(asin(left_d_value)*DEGREE_MULTIPLIER), DOUBLE, NULL, NULL); break;
                case ACOS: return new Expression(new double(acos(left_d_value)*DEGREE_MULTIPLIER), DOUBLE, NULL, NULL); break;
                case ATAN: return new Expression(new double(atan(left_d_value)*DEGREE_MULTIPLIER), DOUBLE, NULL, NULL); break;
                default: cout << "Invalid operation on DOUBLE\n"; break;
            }
            break;
        }
        case STRING: {
            string left_s_value;
            string right_s_value;
            left_s_value = *((string*)(left->evaluate()->value));
            if (node_type == BINARY_OPERATOR ||
                node_type == BINARY_LOGICAL_OPERATOR)
                right_s_value = *((string*)(right->evaluate()->value));
            switch (operator_type) {
                case PLUS: return new Expression(new string(left_s_value + right_s_value), STRING, NULL, NULL); break;
                // EQUALITY
                case EQUAL:              return new Expression(new int(left_s_value == right_s_value), INT, NULL, NULL); break;
                case NOT_EQUAL:          return new Expression(new int(left_s_value != right_s_value), INT, NULL, NULL); break;
                case LESS_THAN:          return new Expression(new int(left_s_value <  right_s_value), INT, NULL, NULL); break;
                case LESS_THAN_EQUAL:    return new Expression(new int(left_s_value <= right_s_value), INT, NULL, NULL); break;
                case GREATER_THAN:       return new Expression(new int(left_s_value >  right_s_value), INT, NULL, NULL); break;
                case GREATER_THAN_EQUAL: return new Expression(new int(left_s_value >= right_s_value), INT, NULL, NULL); break;
                default: //cout << "Invalid operation on STRING\n";
                    break;
            }
            break;
        }
        default: cout << "Operator type broken\n"; break;
    }

    return this;
}
