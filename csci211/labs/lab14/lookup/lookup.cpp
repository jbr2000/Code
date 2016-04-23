#include "location.h"

#include <map>
#include <iostream>
using namespace std;

int main()
{
    double lat,lon;
    string location;
    map<string,Location *> mymap;
    map<string,Location *>::iterator iter;

    while(cin >> lat){
        if(lat==0)
            break;
        cin >> lon;
        cin >> location;
        mymap[location] = new Location(lat,lon);
    }
    
    while(cin >> location){
        iter = mymap.find(location);
        if(iter == mymap.end()){
            cout << location << " not in database\n";
        }
        else{
            cout << location << " is at ";
            mymap[location]->print(cout);
            cout << endl;
        }
    }
}
