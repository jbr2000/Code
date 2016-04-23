#ifndef DLIST_H
#define DLIST_H

#include<iostream>
using namespace std;

#include "node.h"

template <typename T>
class DList{
        private:
                Node<T> *head;
                Node<T> *tail;
        public:
                int size;//the number of items in a Dlist
                DList(): head(NULL), tail(NULL), size(0) {};
                ~DList(); //destructor of the class
                void insert_front(T v, int prior);
                void insert_back(T v, int prior);
                void insert_sorted(T v, int prior);
                bool remove_front();
                bool remove_back();
                bool empty();
                T front();
                T back();
                void print();
};

template <typename T>
class DList<T*>{
        private:
                Node<T*> *head;
                Node<T*> *tail;
        public:
                int size;//the number of items in a Dlist
                DList(): head(NULL), tail(NULL), size(0) {};
                ~DList(); //destructor of the class
                void insert_front(T v, int pr);
                void insert_back(T* vptr, int pr);
                void insert_front(T* vptr, int pr);
                void insert_back(T v, int pr);
                void insert_sorted(T v, int pr);
                void insert_sorted(T* ptr, int pr);
                bool remove_front();
                bool remove_back();
                bool empty();
                T* front();
                void print();
};

#endif
