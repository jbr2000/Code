// Vlist.h File

#ifndef VLIST_H
#define VLIST_H

#include <string>
using namespace std;
#include "video.h"

class Vlist
{
    public:
        Vlist();
        ~Vlist();
        void insert(Video *video);
        void print();
        int  length();
        void lookup(string title);
        bool remove(string title);
    private:
        class Node
        {
            public:
                Node (Video *video, Node *next);
                Video *m_video;
                Node  *m_next;
        };

        Node *m_head;
};

#endif
