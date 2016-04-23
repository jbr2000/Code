// McWililams, Spencer
// smcwilliams
// dstack.cpp

#include <iostream>
using namespace std;

#include "dstack.h"

// constructors
Dstack::Node::Node (double value, Node *next)
{
    m_value = value;
    m_next = next;
}

Dstack::Dstack()
{
    m_head = NULL;
}

// destructor
Dstack::~Dstack()
{

}

bool Dstack::pop(double &value)
{
    if(m_head == NULL)    
        return false; 

    value = m_head->m_value;

    Node *tmp = m_head;

    m_head = m_head->m_next;
    
    delete tmp;

    return true;
}

bool Dstack::push(double value)
{
    m_head = new Node(value, m_head);

    return true;
}

bool Dstack::empty()
{
    return (m_head == NULL);
}

void Dstack::print()
{
    Node *ptr = m_head;
    while(ptr != NULL)
    {
        cout << ptr->m_value << endl;
        ptr = ptr->m_next;
    }
}
