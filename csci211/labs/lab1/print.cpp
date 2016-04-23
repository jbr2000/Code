// print.cpp
// McWilliams, Spencer
// smcwilliams

#include <iostream>
using namespace std;

int main()
{
    int input;

    cout << "Enter a number: ";
    cin >> input;

    for (int i=0; i<input; i++)
    {
        cout << i << " hello\n";
    }

    return 0;
}
