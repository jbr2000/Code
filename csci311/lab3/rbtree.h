// Spencer McWilliams
// smcwilliams
// rbtree.h

#include <utility>
using namespace std;

#ifndef RBTREE_H
#define RBTREE_H

class Node{
    public:
        Node(Node* p, Node* l, Node* r){
            parent = p;
            left = l;
            right = r;
        }
        ~Node(){}
        Node* left;
        Node* right;
        Node* parent;

        pair<string, int> data;
        bool black;
};

class RBTree{
    public:
        RBTree();
        ~RBTree();
        void treewalk(RBTree &T, Node* x);
    // Inserting on RB-Tree
        // Helper Function
        Node* rbinsert(RBTree &T, string word);
        Node* rbinsert(RBTree &T, Node* z);
        void rbinsertfixup(RBTree &T, Node* z);
    // Rotating in RB-Tree
        void leftrotate(RBTree &T, Node* x);
        void rightrotate(RBTree &T, Node* x);
        Node* root;
        Node* NIL;
};

#endif
