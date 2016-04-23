//reverse.cpp
//McWilliams, Spencer
//smcwilliams

#include <iostream>
using namespace std;

#include "dstack.h"

int main()
{
    double my_double;
    Dstack stack;

    while(cin >> my_double)
    {
        stack.push(my_double);        
    }

    while(!stack.empty())
    {
       cout << stack.pop() << endl; 
    }

    return 0;
}
