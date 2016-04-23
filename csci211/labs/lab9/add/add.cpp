#include <iostream>
#include <stdlib.h>
using namespace std;

// STANDARD error message
void error()
{
    cerr << "Error: illegal integer.\n";
    exit(1);
}

// Checking if incoming character string is a number
bool legal_int(char *str)
{
    char* tmp = str;

    while (*tmp)
    {
        if (!isdigit(*tmp))
            return false;
        tmp++;
    }
    
    return true;
}

int main(int argc, char *argv[])
{
    int sum = 0;

// Checking if all arguments are integers
    for (int i=1; i<argc; i++)
    {
        if (!legal_int(argv[i]))
            error();
    }

    for (int i=1; i<argc; i++)
    {
        sum += atoi(argv[i]);
    }

    cout << sum << endl;

    return 0;
}
