// Fill in the functions at the bottom of this file
// 
#include <iostream>
using namespace std;
#include "list.h"

// on some machines member variables are not automatically initialized to 0
List::List()
{
    m_head = NULL;
}

// delete all Nodes in the list
// since they are dynamically allocated using new, they won't go away
// automatically when the list is deleted
// Rule of thumb: destructor deletes all memory created by member functions
List::~List()
{
    // cout << "List::~List() was called" << endl;

    Node *ptr = m_head;
    while (ptr != NULL)
    {
        Node *temp;
    
        temp = ptr;
        ptr = ptr->m_next;
        delete temp;
    }
}

// always insert at the front of the list
// Note: this works even in the SPECIAL CASE that the list is empty
void List::insert(int value)
{
    m_head = new Node(value, m_head);
}

// iterate through all the Nodes in the list and print each Node
void List::print()
{
    Node *ptr = m_head; 
    while (ptr != NULL)
    {
        cout << ptr->m_value << endl; 
        ptr = ptr->m_next;
    }

    /* The following is the same as the above loop
    for (Node *ptr = m_head; ptr; ptr = ptr->m_next)
    {
        cout << ptr->m_value << endl; 
    }
    */
}



// insert the given value at the end of the list
// the list may contain duplicates
void List::insert_at_end(int value)
{
    //SC: List is empty
    if(m_head == NULL)
    {
        m_head = new Node(value,NULL);
        return;
    }

    Node *ptr = m_head;
    while(ptr->m_next != NULL)
    {
        ptr = ptr->m_next;
    }

    ptr->m_next = new Node(value,NULL);
}

// return the sum of all the numbers in the list
// return 0 if the list is empty
int List::sum()
{
    int sum=0;
    //SC: List is empty.
    if(m_head == NULL)
        return sum;
    
    Node *ptr = m_head;
    while(ptr != NULL)
    {
        sum += ptr->m_value;
        ptr = ptr->m_next;
    }
    return sum;
}

// find the largest value in the list
// put the largest value in the reference parameter largest_value
// return true if the list is NOT empty
// return false if the list is empty
bool List::largest(int &largest_value)
{
    largest_value = 0;
    if(m_head == NULL)
        return false;

    Node *ptr = m_head;
    while(ptr != NULL)
    {
        if (ptr->m_value > largest_value)
            largest_value = ptr->m_value;
        ptr = ptr->m_next;
    }
    return true;
}

// count the values in the list that are smaller than, equal to, 
// and larger than the given value
// for example, if the list contains the values:  
//     5, 1, 17, 86, 2 and the given value == 5
// there are 2 values less than 5 (1, 2)
// there are 2 values equal to 5
// there is 1 value greater than 5
// Put the counts in the reference parameters (smaller, equal, larger)
// make sure you initialize all three reference parameters to zero 
// before you start counting
void List::compare(int value, int &smaller, int &equal, int &larger)
{
    smaller = 0;
    equal   = 0;
    larger  = 0;

    if (m_head == NULL)
        return;

    Node *ptr = m_head;
    while(ptr != NULL)
    {
        if (ptr->m_value < value)
            smaller += 1;
        if (ptr->m_value > value)
            larger += 1;
        if (ptr->m_value == value)
            equal += 1;

        ptr = ptr->m_next;
    }

    return;
}
