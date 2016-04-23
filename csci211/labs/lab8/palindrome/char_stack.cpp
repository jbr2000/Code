#include <iostream>
using namespace std;

#include "char_stack.h"

Char_stack::Node::Node(char character, Node *next)
{
    m_character = character;
    m_next = next;
}
Char_stack::Char_stack()
{
    m_head = NULL;
}
Char_stack::~Char_stack()
{
    while (pop())
        ;
}

char Char_stack::pop()
{
    char character;
    if (m_head)
    {
        character = m_head->m_character;
        Node *tmp = m_head;
        m_head = m_head->m_next;
        delete tmp;
        return character;
    }
    // return 0 if the stack is empty
    return 0;
}

void Char_stack::push(char character)
{
    m_head = new Node(character, m_head);
}
