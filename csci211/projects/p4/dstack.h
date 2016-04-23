// McWilliams, Spencer
// smcwilliams
// dstack.h

#ifndef DSTACK_H
#define DSTACK_H

class Dstack
{
    public:
        Dstack();
        ~Dstack();
        bool   pop(double &value);
        bool   empty();
        bool   push(double value);
        void   print();

    private:
        class Node
        {
            public:
                Node(double value, Node *next);
                double m_value;
                Node *m_next;
        };

        Node *m_head;
};

#endif
