// demonstrate a simple linked-list of integers
#ifndef LIST_H
#define LIST_H

class List
{
    public:
        List();
        ~List();
        void insert(int value); // insert at beginning of list
        void print(); // print all values in the list

        // fill in the bodies of these four function in list.cpp
        void insert_at_end(int value); // insert at end of list
        int sum(); // return the sum of all the values in the list
        bool largest(int &largest_value);
        void compare(int value, int &smaller, int &equal, int &larger);

    private:
        class Node
        {
            public:
                // small functions can be inserted into the class definition
                // don't put large functions in the class definition
                Node(int value, Node *next)
                {m_value = value; m_next = next;}
                int m_value;
                Node *m_next;
        };
        Node *m_head;
};

#endif
