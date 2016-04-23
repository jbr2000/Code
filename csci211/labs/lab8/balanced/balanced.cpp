#include <iostream>
#include <cstdlib> // for exit()
using namespace std;
#include "char_stack.h"

void error()
{
  cout << "not balanced\n";
  exit(1); // exit the program with status == 1 (same as "return 1" in main)
}

int main()
{
    Char_stack stack;
    char       input, popped;

    while (cin >> input)
    {
        if ((input == '(') or
            (input == '{'))
            stack.push(input);
        
        if (input == ')')
        {
            popped = stack.pop();
            if (popped != '(')
                error();
        }
        
        if (input == '}')
        {
            popped = stack.pop();
            if (popped != '{')
                error();
        }
    }

    // Checking if there is an extra paren/brace in the stack at end
    popped = stack.pop();
    if (popped)
        error();

    // if error is not called above, the input must be balanced
    cout << "balanced\n";
    return 0;
}
