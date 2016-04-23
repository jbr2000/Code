// McWilliams, Spencer
// smcwilliams
// pqueue.h

#include "cust.h"

#ifndef PQUEUE_H
#define PQUEUE_H

class Pqueue
{
    public:
        Pqueue();
        ~Pqueue();
        bool is_empty();
        void enqueue(Cust *customer, int priority);
        Cust *dequeue();
        int  first_node_prio();

    private:
        class Node
        {
            public:
                Node(Cust *customer, int priority, Node *next);
                Node *m_next;
                Cust *m_cust;
                int  m_priority;
        };

        Node *m_head;
};

#endif
