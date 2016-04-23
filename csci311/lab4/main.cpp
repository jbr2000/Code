// Spencer McWilliams
// smcwilliams
// main.cpp

#include <iostream>
#include <fstream>
#include <vector>
#include <assert.h>
using namespace std;

#include "graph.h"

int main(int argc, char *argv[]){
    assert(argc == 2);

    fstream infile;
    Graph   graph;
    string  word,
            start,
            dest;
    int     weight;

    infile.open(argv[1]);
    if(!infile.is_open()){
        cout << "The input file was unable to open...\n";
        return 1;
    }

    while(infile.peek() != '\n'){
        infile >> word;
        graph.insertvertex(word);
        if(infile.peek() == ' '){
            infile.ignore();
        }
    }

    //cout << graph.G.size() << endl;

    while(infile >> start){
        infile >> dest;
        infile >> weight;
        graph.insertedge(start,dest,weight);
    }
    
    graph.BFS(graph);
    graph.DFS(graph);
    graph.MSTPrim(graph);

    return 0;
}
