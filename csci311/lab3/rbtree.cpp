// Spencer McWilliams
// smcwilliams
// rbtree.cpp

#include <iostream>
using namespace std;

#include "rbtree.h"

RBTree::RBTree(){
    NIL = new Node(NULL,NULL,NULL); NIL->black = true;
    root = NIL;
}
RBTree::~RBTree(){}
void RBTree::treewalk(RBTree &T, Node* x){
    if(x != T.NIL){
        treewalk(T, x->left);
        cout << x->data.first << " " << x->data.second << endl;
        treewalk(T, x->right);
    }
}

// &x = 0x0001
// x = addres of node (0x0002)
// *x = Node
// x->b = (*x).b

// Insertions 
Node* RBTree::rbinsert(RBTree &T, string word){
    Node* z = new Node(T.NIL,T.NIL,T.NIL);
    z->data.first = word;
    z->data.second = 1;
    return rbinsert(T, z);
}
Node* RBTree::rbinsert(RBTree &T, Node* z){
    Node* y = T.NIL;
    Node* x = T.root;
    while(x != T.NIL){
        y = x;
        // if the current node contains the same data.first as the new node "z"
        // then the node already exits. return a pointer to the node to incriment
        // data.second.
        if(z->data.first == x->data.first){
            return x;
        }
        if(z->data.first < x->data.first)
            x = x->left;
        else
            x = x->right;
    }
    z->parent = y;
    if(y == T.NIL)
        T.root = z;
    else if (z->data.first < y->data.first)
        y->left = z;
    else
        y->right = z;
    z->left = T.NIL;
    z->right = T.NIL;
    z->black = false;
    rbinsertfixup(T, z);
    return NULL;
}

void RBTree::rbinsertfixup(RBTree &T, Node* z){
    Node* y;
    while(!z->parent->black){
        if(z->parent == z->parent->parent->left){
            y = z->parent->parent->right;
            if(!y->black){
                z->parent->black = true;            // case 1
                y->black = true;                    // case 1
                z->parent->parent->black = false;   // case 1
                z = z->parent->parent;              // case 1
            }
            else{
                if(z == z->parent->right){
                    z = z->parent;              // case 2
                    leftrotate(T, z);           // case 2
                }
                z->parent->black = true;            // case 3
                z->parent->parent->black = false;   // case 3
                rightrotate(T, z->parent->parent);  // case 3
            }
        }
        else{
            y = z->parent->parent->left;
            if(!y->black){
                z->parent->black = true;
                y->black = true;
                z->parent->parent->black = false;
                z = z->parent->parent;
            }
            else{
                if(z == z->parent->left){
                    z = z->parent;
                    rightrotate(T, z);
                }
                z->parent->black = true;
                z->parent->parent->black = false;
                leftrotate(T, z->parent->parent);
            }
        }
    }
    T.root->black = true;
    return;
}
// Rotations 
void RBTree::leftrotate(RBTree &T, Node* x){
    Node* y = x->right;
    x->right = y->left;
    if(y->left != T.NIL)
        y->left->parent = x;
    y->parent = x->parent;
    if(x->parent == T.NIL)
        T.root = y;
    else if(x == x->parent->left)
        x->parent->left = y;
    else
        x->parent->right = y;
    y->left = x;
    x->parent = y;
}
void RBTree::rightrotate(RBTree &T, Node* x){
    Node* y = x->left;
    x->left= y->right;
    if(y->right != T.NIL)
        y->right->parent = x;
    y->parent = x->parent;
    if(x->parent == T.NIL)
        T.root = y;
    else if(x == x->parent->right)
        x->parent->right = y;
    else
        x->parent->left= y;
    y->right = x;
    x->parent = y;
}
