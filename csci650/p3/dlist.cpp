#include<iostream>
#include<string>
using namespace std;

#include "dlist.h"

template <typename T>
DList<T>::~DList(){
        Node<T> *ptr = head;
        while( ptr != NULL){
                Node<T> *temp = ptr;
                ptr = ptr->next;
                delete temp;
                temp = NULL;
        }//while
}//destructor

template <typename T>
DList<T*>::~DList(){
        Node<T*> *ptr = head;
        while( ptr != NULL){
                Node<T*> *temp = ptr;
                ptr = ptr->next;
                if(temp->value != NULL)
                        delete temp->value;
                delete temp;
                temp = NULL;
        }//while
}//destructor

//inserts an item in front of the list
template <typename T>
void DList<T>::insert_front(T v, int prior){
        //parameters to constructor: value, next, prev
        Node<T> *ptr = new Node<T>(v, head, NULL, prior); //previous is NULL because it becomes the first item in the list
        if(head == NULL){ //list is empty
                tail = ptr; //set tail to point  to the single item on the list 
        }
        else{
                //set prev pointer of the former first item
                head->prev = ptr;
        }
        head = ptr;
        size++;
}//insert_front

//inserts an item in front of the list
template <typename T>
void DList<T*>::insert_front(T v, int prior){
        //parameters to constructor: value, next, prev
        T *val_ptr = new T(v);
        Node<T*> *ptr = new Node<T*>(val_ptr, head, NULL, prior); //previous is NULL because it becomes the first item in the list
        if(head == NULL){ //list is empty
                tail = ptr; //set tail to point  to the single item on the list
        }
        else{
                //set prev pointer of the former first item
                head->prev = ptr;
        }
        head = ptr;
        size++;
}//insert_front

template <typename T>
void DList<T*>::insert_front(T* vptr, int prior){
        //parameters to constructor: value, next, prev
        Node<T*> *ptr = new Node<T*>(vptr, head, NULL, prior); //previous is NULL because it becomes the first item in the list
        if(head == NULL){ //list is empty
                tail = ptr; //set tail to point  to the single item on the list
        }
        else{
                //set prev pointer of the former first item
                head->prev = ptr;
        }
        head = ptr;
        size++;
}//insert_front


//inserts an item at the back of the list
template <typename T>
void DList<T>::insert_back(T v, int prior){
        //parameters of constructor: value, next, prev
        Node<T> *ptr = new Node<T>( v, NULL, tail, prior);
        if(head == NULL)//list is empty
                head = ptr;
        else
                tail->next = ptr;//the former last item 
        tail = ptr;//tail points to the last item, new one
        size++;
}//insert_back

template <typename T>
void DList<T*>::insert_back(T v, int prior){
        //parameters of constructor: value, next, prev
        T *vptr = new T(v);
        Node<T*> *ptr = new Node<T*>( vptr, NULL, tail, prior);
        if(head == NULL)//list is empty
                head = ptr;
        else
                tail->next = ptr;//the former last item
        tail = ptr;//tail points to the last item, new one
        size++;
}//insert_back

template <typename T>
void DList<T*>::insert_back(T* vptr, int prior){
        //parameters of constructor: value, next, prev
        Node<T*> *ptr = new Node<T*>( vptr, NULL, tail, prior);
        if(head == NULL)//list is empty
                head = ptr;
        else
                tail->next = ptr;//the former last item
        tail = ptr;//tail points to the last item, new one
        size++;
}//insert_back

//inserts items in increasing order
//to call this function, class(type) of *value* must
//have overloaded operator < 
template <typename T>
void DList<T>::insert_sorted(T v, int prior){
        Node<T> *ptr = head;
        while(ptr != NULL){
                if(prior < ptr->priority){
                        if(ptr == head){
                                insert_front(v, prior);
                                return;
                        }//if
                        else{//
                                Node<T> *temp = new Node<T>( v, ptr, ptr->prev, prior);
                                ptr->prev->next = temp;
                                ptr->prev = temp;
                                size++;
                                return;
                        }
                }//if
                ptr = ptr->next;
        }//while
        insert_back(v, prior);//size is incremented inside function

}//insert_sorted

template <typename T>
void DList<T*>::insert_sorted(T val, int prior){
        Node<T*> *ptr = head;
        while(ptr != NULL){
                if(prior < ptr->priority ){
                        if(ptr == head){
                                insert_front(val, prior);
                                return;
                        }//if
                        else{//
                                T *vptr = new T(val);
                                Node<T*> *temp = new Node<T*>( vptr, ptr, ptr->prev, prior);
                                ptr->prev->next = temp;
                                ptr->prev = temp;
                                size++;
                                return;
                        }
                }//if
                ptr = ptr->next;
        }//while
        insert_back(val, prior);//size is incremented inside function
}//insert_sorted

template <typename T>
void DList<T*>::insert_sorted(T* val_ptr, int prior){
        Node<T*> *ptr = head;
        while(ptr != NULL){
                if(prior < ptr->priority ){
                        if(ptr == head){
                                insert_front(val_ptr, prior);
                                return;
                        }//if
                        else{//
                                Node<T*> *temp = new Node<T*>( val_ptr, ptr, ptr->prev, prior);
                                ptr->prev->next = temp;
                                ptr->prev = temp;
                                size++;
                                return;
                        }
                }//if
                ptr = ptr->next;

        }//while
        insert_back(val_ptr, prior);//size is incremented inside function
}//insert_sorted


template <typename T> 
bool DList<T>::remove_front(){
        if(head == NULL)//list is empty
                return false; //can't remove an item from empty list
        if(head == tail){//list has a single item in the list
                delete head;
                head = NULL;
                tail = NULL;
        }
        else{ //at least two items in the list
                Node<T> *ptr = head;//the first item
                ptr->next->prev = NULL;
                head = ptr->next;
                delete ptr;
        }
        size--;
        return true;//item was removed
}//remove_front

template <typename T>
bool DList<T*>::remove_front(){
        if(head == NULL)//list is empty
                return false; //can't remove an item from empty list
        if(head == tail){//list has a single item in the list
                delete head->value;
                delete head;
                head = NULL;
                tail = NULL;
        }
        else{ //at least two items in the list
                Node<T*> *ptr = head;//the first item
                ptr->next->prev = NULL;
                head = ptr->next;
                delete ptr->value;
                delete ptr;
        }
        size--;
        return true;//item was removed
}
template <typename T>
bool DList<T>::remove_back(){
        if(head == NULL)//list is empty
        {
                return false;
        }
        else if(head == tail){ // a single item in the list
                delete head;//
                head = NULL;
                tail = NULL;
        }//single item
        else{
                Node<T> *ptr = tail;
                tail = tail->prev;
                tail->next = NULL;
                delete ptr;
        }//else at least two items
        size--;
        return true;
}//remove_back

template <typename T>
bool DList<T*>::remove_back(){
        if(head == NULL)//list is empty
        {
                return false;
        }
        else if(head == tail){ // a single item in the list

                delete head->value;
                delete head;//
                head = NULL;
                tail = NULL;
        }//single item
        else{
                Node<T*> *ptr = tail;
                tail = tail->prev;
                tail->next = NULL;
                delete ptr->value;
                delete ptr;
        }//else at least two items
        size--;
        return true;
}

template <typename T>
bool DList<T>::empty(){
        if(head == NULL)
                return true;
        else 
                return false;
}//empty

template <typename T>
bool DList<T*>::empty(){
        if(head == NULL)
                return true;
        else
                return false;
}//empty


template <typename T>
T DList<T>::front(){
        if(empty()){
                cerr << "ERROR: the dlist is empty." << endl;
                exit(0);//terminates program
        }//list is empty
        else{
                return head->value;
        }//else
}//front()
template <typename T>
T* DList<T*>::front(){
    if(empty()){
        cerr << "ERROR: the dlist is empty." << endl;
        exit(0);
    }
    else
        return head->value;
}//front


template <typename T>
void DList<T>::print(){
        Node<T> *ptr = head;
        while(ptr != NULL){
                cout << ptr->value << endl;
                ptr = ptr->next;
        }//while
}//print

template <typename T>
void DList<T*>::print(){
        Node<T*> *ptr = head;
        while(ptr != NULL){
                cout << *(ptr->value) << endl;
                ptr = ptr->next;
        }//while
}//print


