// McWilliams, Spencer
// smcwilliams
// stree.cpp

#include <assert.h>
#include <iostream>
#include <vector>
using namespace std;

#include "stree.h"

Stree::Stree(){
    m_root = NULL;
}

Stree::~Stree(){
    delete m_root;
}

Stree::Node::Node(string city, Node* parent){
    m_right = NULL;
    m_left = NULL;
    m_parent = parent;
    m_city = city;
}

Stree::Node::~Node(){
    delete m_left;
    delete m_right;
}

bool Stree::insert(Node* root, string origination, string destination){
    // SC: Empty tree.
    if(!m_root){
        m_root = new Node(origination,NULL);
        m_root->m_left = new Node(destination,m_root);
        return true;
    }
    
    // Find if destination city is already in the current tree.
    if(find_node(m_root,destination))
        return false;

    // Find if origination city is already in the current tree.
    Node* ptr = find_node(m_root,origination);

    // SC: Target is not in tree.
    if(!ptr)
        return false;

    if(!ptr->m_left){
        ptr->m_left = new Node(destination,ptr);
        return true;
    }
    else if (!ptr->m_right){
        ptr->m_right = new Node(destination,ptr);
        return true;
    }
    else
        return false;
}

bool Stree::remove(Node* root, string target){
    Node* ptr = find_node(m_root,target);
    if(!ptr)
        return false;

    if (ptr == m_root)
    {
        delete m_root;
        m_root = NULL;
    }
    else
    {
        if(ptr->m_parent->m_left == ptr)
            ptr->m_parent->m_left = NULL;
        else if(ptr->m_parent->m_right == ptr)
             ptr->m_parent->m_right = NULL;
        delete ptr;
    }
    return true;
}

Stree::Node* Stree::find_node(Node* root, string target){
    // SC: Empty tree.
    if(!root)
        return NULL;
    if(root->m_city == target)
        return root;
    Node* left = find_node(root->m_left,target);
    if(left)
        return left;
    if(!left);
        return find_node(root->m_right,target);
    if(!right)
        return NULL;
}

bool Stree::lookup(string target, string &left, string &right){
    Node* ptr = find_node(m_root,target);
    if(!ptr)
        return false;
    assert(ptr);
    if(ptr->m_left)
        left = ptr->m_left->m_city;
    else
        left = "none";

    if(ptr->m_right)
        right = ptr->m_right->m_city;
    else
        right = "none";

    return true;
}

int Stree::distance(Node *root, string target){
    if(!root)
        return 0;
    if(root->m_city == target)
        return 1;

    int left = distance(root->m_left, target);
    if(left)
        return left+1;
    int right = distance(root->m_right, target);
    if(right)
        return right+1;
    else
        return 0;
}

bool Stree::path(vector<string> &pathvector, Node* root, string origination, string destination){
    Node* ptr = find_node(m_root,destination);

    if(!find_node(m_root,origination) || !find_node(m_root,destination))
        return false;
    if(ptr == m_root)
        return false;
    while((ptr != NULL) && (ptr->m_city != origination)) {
        pathvector.push_back(ptr->m_city);
        ptr = ptr->m_parent;
    }
    if(ptr == NULL && m_root->m_city != origination)
        return false;
    else{
        pathvector.push_back(ptr->m_city);
        return true;
    }
}
