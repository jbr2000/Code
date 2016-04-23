// to_text.cpp
// McWilliams, Spencer
// smcwilliams

#include <iostream>
using namespace std;

int main()
{
    int inputs[10], i = 0;

    while (cin >> inputs[i])
    {
        switch (inputs[i])
        {
            case 1:
                cout << "one\n";
                break;
            case 2:
                cout << "two\n";
                break;
            case 3:
                cout << "three\n";
                break;
            case 4:
                cout << "four\n";
                break;
            case 5:
                cout << "five\n";
                break;
            case 6:
                cout << "six\n";
                break;
            case 7:
                cout << "seven\n";
                break;
            case 8:
                cout << "eight\n";
                break;
            case 9:
                cout << "nine\n";
                break;
            case 0:
                cout << "zero\n";
                break;

            default:
                cout << "invalid entry.\n";
                break;
        }
        
        i++;
    }

    return 0;
}
