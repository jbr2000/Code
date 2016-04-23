// chart.cpp
// McWilliams, Spencer
// smcwilliams

#include <iostream>
using namespace std;

int highest_value(int values_par[], int size);

int main()
{
    int const MAXIMUM = 100;
    int values[MAXIMUM], i=0, input_value, count=0;
    char const SPACE = ' ';
    char const ASTERISK = '*';
    
    do {
        cin >> input_value;
        values[i] = input_value;
        i++;
        if (input_value != 0)
            count++;
    } while (input_value != 0);
    
    for (int j = highest_value(values, count); j > 0; j--)
    {
        for (int k = 0; k < count; k++) {
            if (values[k] >= j)
                cout << ASTERISK;
            else
                cout << SPACE;
        }
        cout << endl;
    }
    
    return 0;
}

int highest_value(int values_par[], int size)
{
    int high_number = 0;
    
    for (int i = 0; i < size; i++)
    {
        if (values_par[i] > high_number)
            high_number = values_par[i];
    }
    
    return high_number;
}