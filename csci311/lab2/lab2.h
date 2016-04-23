// Spencer McWilliams
// smcwilliams
// lab2.h

#include <map>
#include <vector>
#include <utility>
#include <fstream>
using namespace std;

#ifndef LAB2_H
#define LAB2_H

class FileParse
{
public:
    FileParse();
    ~FileParse();
    // Function: Opens file stream that is already instantiated as a private variable in FileParse class as <file_in>.
    // Expects: A cstring that is the name of the input file <file_in_name>.
    // Returns: Nothing
    void open(char file_in_name[]);
    // Function: Using the private input stream <file_in> it will pull one word, ignoring non-alphanumaric characters and return that word.
    // Expects: String by reference to store word.
    // Returns: True if word was parsed. False if EOF was reached.
    bool get_word(string &word); 
private:
    ifstream file_in;
};

class MapInterface
{
public:
    MapInterface();
    ~MapInterface();
    // Function: Puts given string <word> into the map that is already instantiated as a public variable of MapInterface. If the key is not already in the map, it will create a new branch in the map with the given key <word> and a value of 1. If the word already exists, it will add 1 to the paired integer value of the key.
    // Expects: String to be used as key for the map <word>.
    // Returns: Nothing.
    void put_word(string word);
    // Function: Prints out all of the elements of <word_map>
    // Expects: Nothing
    // Returns: Nothing
    void print();
    map<string,int> m_word_map;
    
};

class VectorInterface
{
public:
    VectorInterface();
    ~VectorInterface();
    vector<pair<string,int> > m_word_vector;
    void print();
    void sort(string method, string key);
private:
    // QUICKSORT
    void quicksort_by_value(vector<pair<string,int> > &A, int p, int r);
    int partition_by_value(vector<pair<string,int> > &A, int p, int r);
    
    void quicksort_by_key(vector<pair<string,int> > &A, int p, int r);
    int partition_by_key(vector<pair<string,int> > &A, int p, int r);
    
    //HEAPSORT
    int heapsize;
    int parent(int i);
    int left(int i);
    int right(int i);
    
    void max_heapify_by_value(vector<pair<string,int> > &A, int i);
    void build_max_heap_by_value(vector<pair<string,int> > &A);
    void heapsort_by_value(vector<pair<string, int> > &A);
    
    void max_heapify_by_key(vector<pair<string,int> > &A, int i);
    void build_max_heap_by_key(vector<pair<string,int> > &A);
    void heapsort_by_key(vector<pair<string, int> > &A);
    
    //MERGESORT
    void mergesort_by_value(vector<pair<string,int> > &A, int p, int q);
    void merge_by_value(vector<pair<string,int> > &A, int p, int q, int r);
    
    void mergesort_by_key(vector<pair<string,int> > &A, int p, int q);
    void merge_by_key(vector<pair<string,int> > &A, int p, int q, int r);
    
    //INSERTIONSORT
    void insertionsort_by_key(vector<pair<string,int> > &A);
    void insertionsort_by_value(vector<pair<string,int> > &A);
};

#endif
