#ifndef PRIORITY_QUEUE
#define PRIORITY_QUEUE

#include "dlist.cpp"

#include<iostream>
using namespace std;

template <typename T>
class PriorityQueue{

        private:
                DList<T> dlist;
        public:
                int size(){ return dlist.size; };
                bool empty(){ return dlist.empty(); }
                T front(){ return dlist.front(); }
                void enqueue(T val, int prior){ dlist.insert_sorted(val, prior); }
                bool dequeue(){ return dlist.remove_front();};
                void print(){ dlist.print(); };
};

template <typename T>
class PriorityQueue<T*>{

        private:
                DList<T*> dlist;
        public:
                int size(){ return dlist.size; };
                bool empty(){ return dlist.empty(); }
                T* front(){ return dlist.front(); }
                void enqueue(T* ptr, int prior){ dlist.insert_sorted(ptr, prior);}
                void enqueue(T val, int prior){ dlist.insert_sorted(val, prior); }
                bool dequeue(){ return dlist.remove_front();}
                void print(){ dlist.print(); }
};

#endif
