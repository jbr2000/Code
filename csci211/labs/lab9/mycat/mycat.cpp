/*
    Simple program to demonstrate file I/O and 
    how to access command line arguments.  For example:

        $ mycat myinput 

    "myinput" is specified on the command line when the program mycat is started.

    This string (called a command line argument) is available in the main() 

    This program is similar to the Linux cat program.  It accepts a single
    command line argument (the name of a file), then it opens the file and 
    reads each line from the file and writes that line to standard output

        $ cat myfile
        one
        two
        three
        $ mycat myfile
        one
        two
        three
        $

*/

#include <iostream>
#include <fstream>
#include <string>
#include <assert.h>

using namespace std;

int main(int argc, char *argv[])
{
    if (argc == 1)
    {
        cerr << "no filename specified" << endl;
        return 1;
    }

    if (argc > 3)
    {
        cerr << "too many arguments specified on the command line" << endl;
        return 1;
    }

    assert(argc == 3);

    ifstream my_ifile(argv[1], ios::in);
    ofstream my_ofile(argv[2], ios::out);

    if (!my_ifile)
    {
        cerr << "could not open input file <" << argv[1] << ">" << endl;
        return 1;
    }

    if (!my_ofile)
    {
        cerr << "could not open output file <" << argv[2] << ">" << endl;
        return 1;
    }

    string buffer;

    while (getline(my_ifile, buffer, '\n') != false)
    {
        my_ofile << buffer << endl;
    }

    return 0;
}
