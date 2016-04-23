#include <iostream>
#include <math.h>
using namespace std;

#include "expression.h"
#include "variable.h"

int main() {

    Expression *s = new Expression(new int(19), INT, NULL, NULL);
    Expression *f = new Expression(new int(6), INT, NULL, NULL);
    Expression *b = new Expression(new int(2), INT, NULL, NULL);
    Expression *n = new Expression(new int(14), INT, NULL, NULL);
    Expression *v = new Expression(new int(22), INT, NULL, NULL);
    Expression *h = new Expression(new int(8), INT, NULL, NULL);
    Expression *f2= new Expression(new int(6), INT, NULL, NULL);
    Expression *s2= new Expression(new int(19), INT, NULL, NULL);
    Expression *q = new Expression(new int(17), INT, NULL, NULL);
    Expression *w = new Expression(new int(23), INT, NULL, NULL);
    Expression *q2= new Expression(new int(17), INT, NULL, NULL);

    Expression *e1 = new Expression(MULTIPLY, INT, q2, w);
    Expression *e2 = new Expression(GREATER_THAN, INT, h, f2);
    Expression *e3 = new Expression(GREATER_THAN_EQUAL, INT, v, e2);
    Expression *e4 = new Expression(NOT_EQUAL, INT, n, e3);
    Expression *e5 = new Expression(LESS_THAN_EQUAL, INT, b, e4);
    Expression *e6 = new Expression(GREATER_THAN, INT, f, e5);
    Expression *e7 = new Expression(LESS_THAN_EQUAL, INT, e1, q);
    Expression *e8 = new Expression(OR, INT, s2, e7);
    Expression *e9 = new Expression(AND, INT, e6, e8);
    Expression *e10 = new Expression(AND, INT, s, e9);

    cout << *((int*)(e10->evaluate_to_type(INT)->value)) << endl;

    return 0;
}
