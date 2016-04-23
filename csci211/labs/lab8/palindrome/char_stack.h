// Char_stack implements a First-In Last-Out stack of characters
// The pop() function return 0 if the stack is empty.
// if the stack is NOT empty, it removes top (last in) element and returns it
#ifndef CHAR_STACK_H
#define CHAR_STACK_H

using namespace std;

class Char_stack
{
    public:
        Char_stack();
        ~Char_stack();
        char pop(); // returns 0 if stack is empty
        void push(char character);
    private:
        class Node
        {
            public:
                Node(char character, Node *next);
                char m_character;
                Node *m_next;
        };
        Node *m_head;
};

#endif
