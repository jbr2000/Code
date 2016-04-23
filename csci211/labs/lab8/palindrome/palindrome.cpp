#include <cstring>
#include <iostream>
using namespace std;

#include "char_stack.h"

const int MAX = 1000;

// you may create helper functions if you would like

int main()
{
    char buf[MAX];
    char fub[MAX];
    Char_stack stack;

    while (cin.getline(buf,MAX))
    {
        for (int i = 0; buf[i] != '\0'; i++)
            stack.push(buf[i]);

        for (int i = 0; fub[i] = stack.pop(); i++);

        cout << buf;
        
        if(!strcmp(buf, fub))
            cout << " 1\n";
        else
            cout << " 0\n";
    }

    return 0;
}
