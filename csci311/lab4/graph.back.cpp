// Spencer McWilliams
// smwcwilliams
// graph.cpp

#include <iostream>
#include <map>
#include <vector>
#include <queue>
#include <utility>
using namespace std;

#include "graph.h"

Graph::Graph(){}
Graph::~Graph(){}
void Graph::insertvertex(string name){
    graph.insert(pair<string,Vertex*>(name, new Vertex(name)));
}
void Graph::printstructure(){
    map<string,Vertex*>::iterator it;
    vector<Edge*>::iterator vit;
    for(it = graph.begin(); it != graph.end(); it++){
        cout << (*it).first << " -> ";
        for(vit = graph[((*it).first)]->adjlist.begin(); vit != graph[((*it).first)]->adjlist.end(); vit++){
            cout << (*vit)->name << "/" << (*vit)->weight << " -> ";
        }
        cout << "NULL\n";
    }
}
void Graph::insertedge(string start, string dest, int weight){
    graph[start]->adjlist.push_back(new Edge(dest,weight));
    graph[dest]->adjlist.push_back(new Edge(start,weight));
}















//BFS Helper Function
void Graph::BFS(Graph &G){
    map<string,Vertex*>::iterator it = G.graph.begin();
    BFS(G.graph, (*it).second);
}
void Graph::BFS(map<string,Vertex*> &G, Vertex* s){
    Vertex* v;
    Vertex* u;
    queue<Vertex*> q;
    map<string,Vertex*>::iterator mit;
    vector<Edge*>::iterator vit;

    for(mit = G.begin(); mit != G.end(); mit++){
        (*mit).second->color = "WHITE";
        (*mit).second->distance = 51;
        (*mit).second->pre = "NIL";
    }
    s->color = "GRAY";
    s->distance = 0;
    s->pre = "NIL";
    while(!q.empty())
        q.pop();
    q.push(s);
    while(!q.empty()){
        u = q.front();
        q.pop();
        cout << "Visiting vertex: " << u->name << " Distance: " << u->distance << endl;
        for(vit = G[u->name]->adjlist.begin(); vit != G[u->name]->adjlist.end(); vit++){
            v = G[(*vit)->name];
            if(v->color == "WHITE"){
                v->color = "GRAY";
                v->distance = u->distance + 1;
                v->pre = u->name;
                q.push(v);
            }
        }
        u->color = "BLACK";
    }
}

//DFS Helper Function
void Graph::DFS(Graph &G){
    DFS(G.graph, 0);
}
void Graph::DFS(map<string,Vertex*> &G, int time){
    map<string,Vertex*>::iterator mit;
    for(mit = G.begin(); mit != G.end(); mit++){
        (*mit).second->color = "WHITE";
        (*mit).second->pre = "NIL";
    }
    time = 0;
    for(mit = G.begin(); mit != G.end(); mit++){
        if((*mit).second->color == "WHITE")
            DFSVisit(G,(*mit).second,time);
    }
}
void Graph::DFSVisit(map<string,Vertex*> &G, Vertex* u, int &time){
    cout << "Visiting Vertex: " << u->name << " Time: " << time << endl;
    vector<Edge*>::iterator vit;
    time++;
    u->distance = time;
    u->color = "GRAY";
    for(vit = G[(u->name)]->adjlist.begin(); vit != G[(u->name)]->adjlist.end(); vit++){
        if(G[(*vit)->name]->color == "WHITE"){
            G[(*vit)->name]->pre == u->name;
            DFSVisit(G,G[(*vit)->name],time);
        }
    }
    u->color = "BLACK";
    time++;
    u->f = time;
    cout << "Finished Verted: " << u->name << " Time: " << time << endl;
}
void Graph::MSTPrim(Graph &G){
    map<string,Vertex*>::iterator it = G.graph.begin();
    MSTPrim(G.graph, 0, (*it).second);
}
void Graph::MSTPrim(map<string,Vertex*> &G, int w, Vertex* r){
    map<string,Vertex*>::iterator mit;
    vector<Edge*>::iterator vit;
    vector<Vertex*> Q;
    vector<Vertex*>::iterator vit2;
    priority_queue<Vertex*,vector<Vertex*>,CompareVertex> pq;
    Vertex* u;
    Vertex* v;

    for(mit = G.begin(); mit != G.end(); mit++){
        u = (*mit).second;
        u->key = 51;
        u->pre = "NIL";
    }
    r->key = 0;
// Q = G.V
    for(mit = G.begin(); mit != G.end(); mit++){
        (*mit).second->isinqueue = true;
        pq.push((*mit).second);
    }
    while(!pq.empty()){
        u = pq.top();
        pq.pop();
        G[u->name]->isinqueue = false;
        for(vit = G[u->name]->adjlist.begin(); vit != G[u->name]->adjlist.end(); vit++){
            v = G[(*vit)->name];
            // u = (*vit);
            if(v->isinqueue and (*vit)->weight < v->key){
                v->pre = (*vit)->name;
                v->key = (*vit)->weight;
            }
        }
        cout << "Vertex: " << u->name << " Key: " << u->key << endl;
    }
}
