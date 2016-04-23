// Spencer McWilliams
// smwcwilliams
// graph.h

#include <utility>
#include <vector>
#include <map>
#include <string>
using namespace std;

#ifndef GRAPH_H
#define GRAPH_H

class Edge{
    public:
        Edge(string n, int w){
            name = n;
            weight = w;
        }
        ~Edge(){}
        string name;
        int weight;
};

class Vertex{
    public:
        // create a new Vertex with the name "name".
        Vertex(string n){
            name = n;
            isinqueue = false;
        }
        ~Vertex(){}
        string  color,
                name,
                pre;
        int     distance,
                f,
                key;
        bool    isinqueue;
        vector<Edge*> adjlist;
};

class Graph{
    public:
        Graph();
        ~Graph();
        map<string,Vertex*> graph;
        void insertvertex(string key);
            // insertedge will search the vector of verticies for the given start and "draw"
            // a relation from start -> dest. It will then search the vector for the
            // destination vertex and "draw" a relation from dest -> start.
        void insertedge(string start, string dest, int weight);
        void printstructure();
        void BFS(Graph &G);
        void BFS(map<string,Vertex*> &G, Vertex* s);
        void DFS(Graph &G);
        void DFS(map<string,Vertex*> &G, int time);
        void DFSVisit(map<string,Vertex*> &G, Vertex* u, int &time);
        void MSTPrim(Graph &G);
        void MSTPrim(map<string,Vertex*> &G, int w, Vertex* r);
        
        struct CompareVertex{
            bool operator()(Vertex* lhs,Vertex* rhs){
                if(lhs->key == rhs->key)
                    return (lhs->name.compare(rhs->name) > 0);
                else
                    return (lhs->key > rhs->key);
            }
        };
};

#endif
