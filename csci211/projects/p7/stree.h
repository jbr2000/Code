// McWilliams, Spencer
// smcwilliams
// stree.h

#ifndef STREE_H
#define STREE_H

#include <vector>
using namespace std;

class Stree
{
    public:
        Stree();
        ~Stree();
        bool insert(string origination, string destination){return insert(m_root, origination, destination);}
        bool remove(string target){return remove(m_root,target);}
        bool lookup(string target, string &left, string &right);
        int distance(string origination, string destination){
            return distance(m_root,destination)-distance(m_root,origination);}
        bool path(vector<string> &pathvector, string origination, string destination){
            return path(pathvector,m_root,origination,destination);}

    private:
        class Node
        {
            public:
                Node(string city, Node* parent);
                ~Node();
                Node* m_right;
                Node* m_left;
                Node* m_parent;
                string m_city;
        };
        bool insert(Node* root, string origination, string destination);
        bool remove(Node* root, string target);
        int  distance(Node* root, string target);
        bool path(vector<string> &pathvector, Node* root,string origination,string destination);
        Node* find_node(Node* root, string target);
        Node* m_root;
};

#endif
