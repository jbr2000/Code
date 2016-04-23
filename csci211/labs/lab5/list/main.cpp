#include <iostream>
using namespace std;
#include "list.h"

int main()
{
    // instantiate a List class (the constructor takes NO arguments)
    List list;
    int input;

    // NOTE:
    // List list();  is incorrect, when there are no arguments don't use ()

    // insert numbers into the list
    while(cin >> input)
    {
        list.insert_at_end(input);
    }
    
    list.print();
    cout << "sum = " << list.sum() << endl;

    return 0;
}
