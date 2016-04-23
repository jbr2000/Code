// McWilliams, Spencer
// smcwilliams
// pqueue.cpp

#include "cust.h"
#include "pqueue.h"

// Constructor
Pqueue::Pqueue() {
    m_head = NULL;
}

Pqueue::~Pqueue() {
    while (dequeue()); 
}

Pqueue::Node::Node(Cust *customer, int priority, Node *next) {
    m_cust = customer;
    m_priority = priority;
    m_next = next;
}

void Pqueue::enqueue(Cust *customer, int priority) {
    if (m_head == NULL || priority < m_head->m_priority) {
        m_head = new Node(customer,priority,m_head);
        return;
    }

    Node *ptr = m_head;
    while (ptr->m_next && ptr->m_next->m_priority <= priority)
        ptr = ptr->m_next;

    ptr->m_next = new Node(customer,priority,ptr->m_next);
    return;
}


Cust *Pqueue::dequeue() {
    if (m_head == NULL)
        return NULL;
    
    Node *ptr = m_head;
    Cust *tmp = m_head->m_cust;
    m_head = m_head->m_next;
    delete ptr;
    return tmp;
}

bool Pqueue::is_empty() {
    return (m_head == NULL);
}

int Pqueue::first_node_prio() {
    return m_head->m_priority;
}
