// even.cpp
// McWilliams, Spencer
// smcwilliams

#include <iostream>
using namespace std;

bool is_odd(int input_par);

int main()
{
    int input;
    bool all_even=true;

    while (cin >> input)
    {
        if (is_odd(input))
            all_even = false;
    }

    if (all_even == true)
        cout << "all even\n";
    else
    {
        cerr << "not all even\n";
        return 1;
    }

    return 0;
}

bool is_odd(int input_par)
{
    if (input_par % 2 == 1)
        return true;
    else
        return false;
}
