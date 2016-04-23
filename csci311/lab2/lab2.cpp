// Spencer McWilliams
// smcwilliams
// lab1.cpp

#include <fstream>
#include <iostream>
#include <assert.h>
#include <ctype.h>
#include <map>
#include <vector>
#include <utility>
#include <string>
using namespace std;

#include "lab2.h"


// FileParse Class Definitions
FileParse::FileParse(){}
FileParse::~FileParse(){}
void FileParse::open(char file_in_name[]){
    file_in.open(file_in_name);
} 
bool FileParse::get_word(string &word){
    string buffer;
    char next;
    while(!isspace(file_in.peek()) and file_in.peek() != -1){
        next = file_in.get(); 
        if(isalnum(next))
            buffer += tolower(next);
    }
    if(file_in.peek() == -1){
        if (!buffer.empty()) {
            word = buffer;
            return true;
        }
        else return false;
    }
    file_in.ignore();
    if(!buffer.empty())
        word = buffer;
    return true;
}

// MapInterface Class Definitions
MapInterface::MapInterface(){}
MapInterface::~MapInterface(){} 
void MapInterface::put_word(string word){
    map<string,int>::iterator iter;
    iter = m_word_map.find(word);
    
    if(iter == m_word_map.end()){
        m_word_map.insert(pair<string,int>(word,1));
    }
    else{
        m_word_map[word] += 1;
    }
}
void MapInterface::print(){
    map<string,int>::iterator iter;
    
    for(iter = m_word_map.begin(); iter != m_word_map.end(); iter++){
        cout << (*iter).first << " " << (*iter).second << endl;
    }
}

// VectorInterface Class Definitions
VectorInterface::VectorInterface(){}
VectorInterface::~VectorInterface(){} 
void VectorInterface::print(){
    for(vector<pair<string,int> >::iterator iter = m_word_vector.begin(); iter != m_word_vector.end(); iter++){
        cout << (*iter).first << " " << (*iter).second << endl;
    }
}

void VectorInterface::sort(string method, string key){
    if(key == "VALUE"){
        if(method == "QUICK"){
            cout << "QuickSort by Values\n";
            VectorInterface::quicksort_by_value(m_word_vector,0,m_word_vector.size()-1);
        }
        if(method == "HEAP"){
            cout << "HeapSort by Values\n";
            VectorInterface::heapsort_by_value(m_word_vector);
        }
        if(method == "MERGE"){
            cout << "MergeSort by Values\n";
            VectorInterface::mergesort_by_value(m_word_vector,0,m_word_vector.size()-1);
        }
        if(method == "INSERTION"){
            cout << "InsertionSort by Values\n";
            VectorInterface::insertionsort_by_key(m_word_vector);
        }
    }
    if(key == "KEY"){
        if(method == "QUICK"){
            cout << "QuickSort by Keys\n";
            VectorInterface::quicksort_by_key(m_word_vector, 0, m_word_vector.size()-1);
        }
        if(method == "HEAP"){
            cout << "HeapSort by Keys\n";
            VectorInterface::heapsort_by_key(m_word_vector);
        }
        if(method == "MERGE"){
            cout << "MergeSort by Keys\n";
            VectorInterface::mergesort_by_key(m_word_vector, 0, m_word_vector.size()-1);
        }
        if(method == "INSERTION"){
            cout << "InsertoinSort by Keys\n";
            VectorInterface::insertionsort_by_key(m_word_vector);
        }
    }
}



// QUICKSORT -------------------------------------------------------------------------------------------------------------------------------
void VectorInterface::quicksort_by_value(vector<pair<string,int> > &A, int p, int r){
    if(p < r){
        int q = partition_by_value(A,p,r);
        quicksort_by_value(A,p,q-1);
        quicksort_by_value(A, q+1, r);
    }
}
int VectorInterface::partition_by_value(vector<pair<string,int> > &A, int p, int r){
    int pivot = A[r].second;
    int i = p-1;
    pair<string,int> temporary;
    for(int j = p; j < r; j++){
        if (A[j].second <= pivot){
            i++;
            swap(A[i],A[j]);
        }
    }
    swap(A[i+1],A[r]);
    return i+1;
}

void VectorInterface::quicksort_by_key(vector<pair<string,int> > &A, int p, int r){
    if(p < r){
        int q = partition_by_key(A,p,r);
        quicksort_by_key(A,p,q-1);
        quicksort_by_key(A, q+1, r);
    }
}
int VectorInterface::partition_by_key(vector<pair<string,int> > &A, int p, int r){
    string pivot = A[r].first;
    int i = p-1;
    pair<string,int> temporary;
    for(int j = p; j < r; j++){
        if (A[j].first <= pivot){
            i++;
            swap(A[i],A[j]);
        }
    }
    swap(A[i+1],A[r]);
    return i+1;
}

// HEAPSORT -------------------------------------------------------------------------------------------------------------------------------
int VectorInterface::parent(int i){
    return (i/2);
}
int VectorInterface::left(int i){
    return (2*i);
}
int VectorInterface::right(int i){
    return (2*i)+1;
}

void VectorInterface::max_heapify_by_value(vector<pair<string,int> > &A, int i){
    int l = left(i);
    int r = right(i);
    int largest = 0;
    if((l <= heapsize) and (A[l].second > A[i].second))
        largest = l;
    else
        largest = i;
    if((r <= heapsize) and (A[r].second > A[largest].second))
        largest = r;
    if(largest != i){
        swap(A[i],A[largest]);
        max_heapify_by_value(A,largest);
    }
}

void VectorInterface::build_max_heap_by_value(vector<pair<string,int> > &A){
    heapsize = A.size()-1;
    // possibly i >= 1
    for(int i = (A.size()-1)/2; i >= 1; i--){
        max_heapify_by_value(A, i);
    }
}

void VectorInterface::heapsort_by_value(vector<pair<string, int> > &A){
    build_max_heap_by_value(A);
    for (int i = A.size()-1; i >= 2; i--) {
        swap(A[1],A[i]);
        heapsize--;
        max_heapify_by_value(A, 1);
    }
}

void VectorInterface::max_heapify_by_key(vector<pair<string,int> > &A, int i){
    int l = left(i);
    int r = right(i);
    int largest = 0;
    if((l <= heapsize) and (A[l].first > A[i].first))
        largest = l;
    else
        largest = i;
    if((r <= heapsize) and (A[r].first > A[largest].first))
        largest = r;
    if(largest != i){
        swap(A[i],A[largest]);
        max_heapify_by_key(A,largest);
    }
}

void VectorInterface::build_max_heap_by_key(vector<pair<string,int> > &A){
    heapsize = A.size()-1;
    // possibly i >= 1
    for(int i = (A.size()-1)/2; i >= 1; i--){
        max_heapify_by_key(A, i);
    }
}

void VectorInterface::heapsort_by_key(vector<pair<string, int> > &A){
    build_max_heap_by_key(A);
    for (int i = A.size()-1; i >= 2; i--) {
        swap(A[1],A[i]);
        heapsize--;
        max_heapify_by_key(A, 1);
    }
}

// MERGESORT -------------------------------------------------------------------------------------------------------------------------------
void VectorInterface::mergesort_by_value(vector<pair<string,int> > &A, int p, int r){
    if (p < r){
        int q = ((p+r)/2);
        mergesort_by_value(A, p, q);
        mergesort_by_value(A, q+1, r);
        merge_by_value(A, p, q, r);
    }
}

void VectorInterface::merge_by_value(vector<pair<string,int> > &A, int p, int q, int r){
    int n1 = (q-p)+1;
    int n2 = (r-q);
    vector<pair<string,int> > L (n1+1);
    vector<pair<string,int> > R (n2+1);
    for(int i = 0; i < n1; i++){
        L[i] = A[p+i];
    }
    for(int j = 0; j < n2; j++){
        R[j] = A[q+1+j];
    }
    L[n1].second = 32766;
    R[n2].second = 32766;
    int i = 0;
    int j = 0;
    for(int k = p; k <= r; k++){
        if(L[i].second <= R[j].second){
            A[k] = L[i];
            i++;
        }
        else{
            A[k] = R[j];
            j++;
        }
    }
}



void VectorInterface::mergesort_by_key(vector<pair<string,int> > &A, int p, int r){
    if (p < r){
        int q = ((p+r)/2);
        mergesort_by_key(A, p, q);
        mergesort_by_key(A, q+1, r);
        merge_by_key(A, p, q, r);
    }
}

void VectorInterface::merge_by_key(vector<pair<string,int> > &A, int p, int q, int r){
    int n1 = (q-p)+1;
    int n2 = (r-q);
    vector<pair<string,int> > L (n1+1);
    vector<pair<string,int> > R (n2+1);
    for(int i = 0; i < n1; i++){
        L[i] = A[p+i];
    }
    for(int j = 0; j < n2; j++){
        R[j] = A[q+1+j];
    }
    L[n1].first = "~";
    R[n2].first = "~";
    int i = 0;
    int j = 0;
    for(int k = p; k <= r; k++){
        if(L[i].first <= R[j].first){
            A[k] = L[i];
            i++;
        }
        else{
            A[k] = R[j];
            j++;
        }
    }
}

//INSERTION SORT -------------------------------------------------------------------------------------------------------------------------------
void VectorInterface::insertionsort_by_value(vector<pair<string,int> > &A){
    int length = A.size();
    int i;
    pair<string,int> key;
    for(int j = 1; j < length; j++){
        key = A[j];
        i = j-1;
        while((A[i].second > key.second) and (i >= 0)){
            A[i+1] = A[i];
            i--;
        }
        A[i+1] = key;
    }
}

void VectorInterface::insertionsort_by_key(vector<pair<string,int> > &A){
    int length = A.size();
    int i;
    pair<string,int> key;
    for(int j = 1; j < length; j++){
        key = A[j];
        i = j-1;
        while((A[i].first > key.first) and (i >= 0)){
            A[i+1] = A[i];
            i--;
        }
        A[i+1] = key;
    }
}





/*
 // MERGESORT
 void VectorInterface::merge_by_value(vector<pair<string,int> > &A, int p, int q, int r){
 int n1 = (q-p);
 int n2 = (r-q);
 vector<pair<string,int> > L (n1+1);
 vector<pair<string,int> > R (n2+1);
 for(int i = 0; i < n1; i++){
 L[i] = A[p+i];
 }
 for(int j = 0; j < n2; j++){
 R[j] = A[q+j];
 }
 L[n1].second = 32766;
 R[n2].second = 32766;
 int i = 0;
 int j = 0;
 for(int k = p; k < r; k++){
 if(L[i].second <= R[j].second){
 A[k] = L[i];
 i++;
 }
 else{
 A[k] = R[j];
 j++;
 }
 }
 }
 void VectorInterface::mergesort_by_vlaue(vector<pair<string,int> > &A, int p, int r){
 if (p<r){
 int q = (p+r)/2;
 mergesort_by_vlaue(A,p,q);
 mergesort_by_vlaue(A,q+1,r);
 merge_by_value(A,p,q,r);
 }
 }
 
 void VectorInterface::merge_by_value(vector<pair<string,int> > &A, int p, int r){
 int mid = ((p+r)/2);
 int i1 = 0;
 int i2 = p;
 int i3 = mid+1;
 vector<pair<string,int> > temp (r-p+1);
 while ((i2 <= mid) and (i3 <= r)) {
 if (A[i2].second < A[i3].second) {
 temp[i1] = A[i2];
 i1++;
 i2++;
 }
 else{
 temp[i1] = A[i3];
 i1++;
 i3++;
 }
 }
 
 while (i2 <= mid) {
 temp[i1] = A[i2];
 i1++;
 i2++;
 }
 while (i3 <= r){
 temp[i1] = A[i3];
 i1++;
 i3++;
 }
 for (int i = p; i <= r; i++) {
 A[i] = temp[i-p];
 }
 }
 
 
 void VectorInterface::merge_by_key(int low, int mid, int high){
 int h, i, j, k;
 const int size = m_word_vector.size();
 vector<pair<string, int> > tmp_vector (size);
 h = low;
 i = low;
 j = mid+1;
 
 while((h <= mid) and (j <= high)){
 if(m_word_vector[h].first < m_word_vector[j].first){
 tmp_vector[i] = m_word_vector[h];
 h++;
 }
 else{
 tmp_vector[i] = m_word_vector[j];
 j++;
 }
 i++;
 }
 if(h > mid){
 for(k = j; k <= high; k++){
 tmp_vector[i] = m_word_vector[k];
 i++;
 }
 }
 else{
 for(k = h; k <= mid; k++){
 tmp_vector[i] = m_word_vector[k];
 i++;
 }
 }
 for(k = low; k <= high; k++)
 m_word_vector[k] = tmp_vector[k];
 }
 
 // HEAPSORT
 void VectorInterface::heapify_by_value(int i){
 int l = (2*i)+1, greatest;
 int r = (2*i)+2;
 if((l < heapsize) and (m_word_vector[l].second > m_word_vector[i].second))
 greatest = l;
 else
 greatest = i;
 if((r < heapsize) and (m_word_vector[r].second > m_word_vector[greatest].second))
 greatest = r;
 if(greatest != i){
 pair<string,int> temp = m_word_vector[i];
 m_word_vector[i] = m_word_vector[greatest];
 m_word_vector[greatest] = temp;
 heapify_by_value(greatest);
 }
 }
 void VectorInterface::build_max_heap_by_value(){
 heapsize = m_word_vector.size();
 for(int i = (heapsize-1)/2; i >= 0; i--){
 heapify_by_value(i);
 }
 }
 void VectorInterface::heapsort_by_value(){
 build_max_heap_by_value();
 for(int i = heapsize; i > 0; i--){
 pair<string,int> temp = m_word_vector[0];
 m_word_vector[0] = m_word_vector[heapsize-1];
 m_word_vector[heapsize-1] = temp;
 heapsize--;
 heapify_by_value(0);
 }
 }
 
 void VectorInterface::heapify_by_key(int i){
 int l = (2*i)+1, greatest;
 int r = (2*i)+2;
 if((l < heapsize) and (m_word_vector[l].first > m_word_vector[i].first))
 greatest = l;
 else
 greatest = i;
 if((r < heapsize) and (m_word_vector[r].first > m_word_vector[greatest].first))
 greatest = r;
 if(greatest != i){
 pair<string,int> temp = m_word_vector[i];
 m_word_vector[i] = m_word_vector[greatest];
 m_word_vector[greatest] = temp;
 heapify_by_key(greatest);
 }
 }
 void VectorInterface::build_max_heap_by_key(){
 heapsize = m_word_vector.size();
 for(int i = (heapsize-1)/2; i >= 0; i--){
 heapify_by_key(i);
 }
 }
 void VectorInterface::heapsort_by_key(){
 build_max_heap_by_key();
 for(int i = heapsize; i > 0; i--){
 pair<string,int> temp = m_word_vector[0];
 m_word_vector[0] = m_word_vector[heapsize-1];
 m_word_vector[heapsize-1] = temp;
 heapsize--;
 heapify_by_key(0);
 }
 }
 
 
 //INSERTION SORT
 
 void VectorInterface::insertionsort_by_value(){
 int length = m_word_vector.size();
 int i;
 pair<string,int> key;
 for(int j = 1; j < length; j++){
 key = m_word_vector[j];
 i = j-1;
 while((m_word_vector[i].second > key.second) and (i >= 0)){
 m_word_vector[i+1] = m_word_vector[i];
 i--;
 }
 m_word_vector[i+1] = key;
 }
 }
 
 void VectorInterface::insertionsort_by_key(){
 int length = m_word_vector.size();
 int i;
 pair<string,int> key;
 for(int j = 1; j < length; j++){
 key = m_word_vector[j];
 i = j-1;
 while((m_word_vector[i].first > key.first) and (i >= 0)){
 m_word_vector[i+1] = m_word_vector[i];
 i--;
 }
 m_word_vector[i+1] = key;
 }
 }
 */
