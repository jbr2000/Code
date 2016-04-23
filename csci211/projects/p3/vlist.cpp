// Vlist.cpp File

#include <iostream>
#include <string>
using namespace std;

#include "vlist.h"
#include "video.h"


// constructors
Vlist::Node::Node (Video *video, Node *next)
{
    m_video = video;
    m_next = next;
}

Vlist::Vlist()
{
    m_head = NULL;
}

// destructors
Vlist::~Vlist()
{

}

void Vlist::print()
{
    if (m_head == NULL)
    {
        return;
    }

    Node *ptr = m_head;

    while (ptr->m_next != NULL)
    {
        ptr->m_next->m_video->print();
        ptr = ptr->m_next;
    }
}

void Vlist::insert (Video *video)
{
    //SC: No videos in list.
    if (m_head == NULL)
        m_head = new Node(video, NULL);

    // Begin standard execution.
    Node *ptr = m_head;

    while (ptr->m_next != NULL && ptr->m_next->m_video->comes_before(video))
    {
        if (ptr->m_next->m_video->get_title() == video->get_title())
        {
            cerr << "Could not insert video <" << video->get_title()
                 << ">, already in list." << endl;
            return;
        }
        ptr = ptr->m_next;
    }

    ptr->m_next = new Node(video,ptr->m_next);

    return;
}

int Vlist::length()
{
    int count = 0;

    if (m_head == NULL)
    {
        return count;
    }

    else
    {
        Node *ptr = m_head;

        while(ptr->m_next != NULL)
        {
            ptr = ptr->m_next;
            count += 1;
        }

        return count;
    }
}

void Vlist::lookup(string title)
{
    if (m_head == NULL)
        return;

    Node *ptr = m_head;
    while (ptr->m_next != NULL)
    {
        if (title == ptr->m_video->get_title())
        {
            ptr->m_video->print();
            return;
        }

        ptr = ptr->m_next;
    }

    cerr << "Title <" << title << "> not in list." << endl;
    return;
}

bool Vlist::remove(string title)
{
    //SC: List is empty.
    if (m_head == NULL)
    {
        cerr << "Title <" << title << "> not in list, could not delete." << endl;
        return false;
    }

// Begin standard execution
    Node *ptr = m_head;
    while (ptr->m_next != NULL && ptr->m_next->m_video->get_title() != title)
    {
        ptr = ptr->m_next;
    }
        
    //SC: Value is not in list.
    if(ptr->m_next == NULL)
    {
        cerr << "Title <" << title << "> not in list, could not delete." << endl;
        return false;
    }

    Node *tmp = ptr->m_next;
    ptr->m_next = ptr->m_next->m_next;
    delete tmp->m_video;
    delete tmp;
    return true;
}
