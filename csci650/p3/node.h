#include<iostream>
using namespace std;

#ifndef NODE_H
#define NODE_H

template <typename T>
class Node{
    public:
    Node(): next(NULL), prev(NULL), priority(1) {};
    Node(T v, Node *n, Node *p, int pr): value(v), next(n), prev(p), priority(pr) {};
    Node(const Node &acopy): value(acopy.value), next(acopy.next), prev(acopy.prev), priority(acopy.priority) {};
        T value;
        Node* next;
        Node* prev;
        int priority;
};
#endif
