// main.cpp

#include <iostream>
#include <string>
using namespace std;

#include "video.h"
#include "vlist.h"

int main()
{
    string command, title, url, description;
    int    rating;
    double length;
    Vlist  vlist;

    while (getline(cin,command))
    {

        if (command == "insert")
        {
            getline(cin,title);
            getline(cin,url);
            getline(cin,description);
            cin >> length;
            cin >> rating;
        
            vlist.insert(new Video(title,url,description,length,rating));

            cin.ignore();
        }

        if (command == "length")
            cout << vlist.length() << endl;

        if (command == "print")        
            vlist.print();

        if (command == "lookup")
        {
            string input;
            getline(cin,input);
            vlist.lookup(input);
        }

        if (command == "remove")
        {
            string input;
            getline(cin,input);
            vlist.remove(input);
        }

        if (command != "insert" &&
            command != "print"  &&
            command != "length" &&
            command != "length" &&
            command != "lookup" &&
            command != "remove")
        {
            cerr << "<" << command << "> is not a legal command, giving up." << endl;
            return 1;
        }
    }

    return 0;
}
