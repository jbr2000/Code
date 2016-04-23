// McWililams, Spencer
// smcwilliams
// calc.cpp

#include <cmath>
#include <cstdlib>
#include <iostream>
using namespace std;

#include "dstack.h"

double do_operation(char operation, Dstack &stack);
void   error();

int main()
{
    double input, value;
    char   operation;
    Dstack stack;
    
    while(cin.peek() != -1)
    {
        if(isspace(cin.peek()))
            cin.ignore();
        
        else
        if(isdigit(cin.peek()) or (cin.peek() == '.'))
        {
            cin >> input;
            if(cin.good())
                stack.push(input);
            else
                error();
        }

        else
        if((cin.peek() == '*') or
           (cin.peek() == '+') or
           (cin.peek() == '/') or
           (cin.peek() == '^') or
           (cin.peek() == '-'))
        {
            cin >> operation;
            stack.push(do_operation(operation, stack));
        }
        
        else
            error();
    }
  
    if(stack.empty())
        error();

    stack.pop(value);
    
    if(!stack.empty())
        error();
    
    cout << value << endl;
    stack.~Dstack();

    return 0;
}

double do_operation(char operation, Dstack &stack)
{
    double val1, val2;
    if(!stack.pop(val1) or
       !stack.pop(val2))
    {
        error();
    }
    
    if(operation == '*')
        return (val1*val2);
    if(operation == '+')
        return (val2+val1);
    if(operation == '/')
    {
        if (val1 == 0)
            error();
        return (val2/val1);
    }
    if(operation == '-')
        return (val2-val1);
    if(operation == '^')
        return (pow(val2,val1));
}

void error()
{
    cerr << "Error: Invalid expression." << endl;
    exit(1);
}
