// McWilliams, Spencer
// smcwilliams
// train.cpp

#include <vector>
#include <iostream>
using namespace std;

#include "stree.h"


void notintreeerror(string target);
void removalerror(string target);
void insertionerror(string origination, string destination);
void patherror(string origination, string destination);
void inputerror(string command);


int main(){

    Stree tree;
    string command;
    string cur_path;
    string target, left, right;
    string origination, destination;
    vector<string> pathvector;

    while(cin >> command){

        if(command == "insert"){
            cin >> origination;
            cin >> destination;
            if(!tree.insert(origination,destination))
                insertionerror(origination,destination);
        }

        else if(command == "print"){
            cin >> target;
            if(tree.lookup(target,left,right)){
                cout << target << ": "
                     << left << ", "
                     << right << endl;
            }
            else
                notintreeerror(target);
        }

        else if(command == "path"){
            cin >> origination;
            cin >> destination;
            if(!tree.path(pathvector,origination,destination))
                patherror(origination,destination);
            else{
                for(int iter = pathvector.size()-1; iter >=  0; iter--){
                    cout << pathvector[iter];
                    if(iter > 0)
                        cout << " to ";
                }
                cout << endl;
            }
        }
        else if(command == "remove"){
            cin >> target;
            if(!tree.remove(target))
                removalerror(target);
        }

        else if(command == "distance"){
            cin >> origination;
            cin >> destination;
            int distance = tree.distance(origination,destination);
            if(distance > 0){
                cout << origination << " to "
                     << destination << " is "
                     << distance;
                if(distance > 1)
                    cout << " trains\n";
                else
                    cout << " train\n";
            }
            else
                patherror(origination,destination);
        }
        else{
            while(cin.peek() != '\n')
                cin.ignore();
            inputerror(command);
        }
}

    return 0;
}









void notintreeerror(string target){
    cerr << "Error: <" << target
         << "> not in tree" << endl;
}

void insertionerror(string origination, string destination){
    cerr << "Error: could not insert <" << origination 
         << ", " << destination << ">\n";
}

void removalerror(string target){
    cerr << "Error: could not remove <" << target
         << ">" << endl;
}

void patherror(string origination, string destination){
    cerr << "Error: no path between <" << origination 
         << "> and <" << destination << ">" << endl;
}

void inputerror(string command){
    cerr << "Error: <" << command << "> is not a valid command" << endl;
}
