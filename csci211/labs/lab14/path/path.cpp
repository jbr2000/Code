#include "location.h"

#include <vector>
#include <iostream>
using namespace std;

int main()
{
    double lat,lon;
    vector<Location *> myvector;

    while(cin >> lat){
        cin >> lon;
        myvector.push_back(new Location(lat,lon));
    }

    for(int i=0; myvector[i]; i++){
        myvector.at(i)->print(cout);
        cout << endl;
    }

    return 0;
}
