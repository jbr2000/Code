// Test driver for link list class
// Reads a single integer from standard input and executes 
//   the test associated with that number
#include <iostream>
using namespace std;
#include "list.h"

int main()
{
    int test_number;

    cin >> test_number;

    switch (test_number)
    {
        // test that insert at end correctly inserts values at end
        // of the list
        case 1: 
        {
            List list;
            list.insert_at_end(1);
            list.insert_at_end(2);
            list.insert_at_end(3);
            list.insert_at_end(4);
            list.print();
            break;
        } 

        // test the sum() function by inserting values 1..100 into the
        // list and then calling the sum function
        case 2:
        {
            List list;
            // make sure sum can handle an empty list correctly
            cout << "an empty list should have sum = 0, list.sum() = " << list.sum() << endl;
            for (int i = 1; i <= 100; i++)
            {
              list.insert_at_end(i);
            }
            cout << "1 + 2 + ... + 100 = " << list.sum() << endl;
            break;
        }

        // test the largest() function by inserting some number then calling
        // largest and printing the results
       
        case 3:
        {
            List list;
            int value;
            // make sure largest handles an empty list correctly
            if (list.largest(value) == false)
            {
                cout << "list is starting out empty (this is correct)\n";
            }
            else
            {
                cout << "list is not empty (this is not correct)\n";
            }
            list.insert_at_end(42);
            list.insert_at_end(86);
            list.insert_at_end(17);
            list.insert_at_end(12);
            list.insert_at_end(100);
            if (list.largest(value) == true)
            {
                // should print the largest of number inserted above (100)
                cout << "largest value = " << value << endl;
            }
            else
            {
                cout << "error calling List::largest()\n";
            }
            break;
        }

        // test the compare function
        case 4:
        {
            List list;
            for (int i = 1; i <= 100; i++)
            {
              list.insert_at_end(i);
            }
            int smaller, equal, larger;
            list.compare(42, smaller, equal, larger);

            cout << "in the numbers 1..100, " << smaller << " are smaller than 42, " 
                 << equal << " is equal to 42, "
                 << larger << " are larger than 42\n";
            break;
        }
        default:
               cerr << "Unknown test number.\n";
               return 1;
               break;
    }

    // executed w/o error
    return 0;
}
