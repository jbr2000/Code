// Mcwilliams, Spencer
// smcwilliams
// main.cpp

#include <iostream>
#include <fstream>
#include <map>
#include <utility>
#include <vector>
#include <assert.h>
#include <time.h>
using namespace std;

#include "lab2.h"

timespec diff(timespec start, timespec end);

int main(int argc, char *argv[]) {
    // check for correct amount of arguments
    assert(argc == 2);
    
    string word;
    FileParse fileparse;
    MapInterface wordmap;
    VectorInterface wordvector;
    pair<string,int> target_pair;
    map<string,int>::iterator miter;
    fileparse.open(argv[1]);
    
    timespec start,end;
    
    while(fileparse.get_word(word)){
        if(!word.empty())
            wordmap.put_word(word);
        word.clear();
    }

    miter = wordmap.m_word_map.begin();

    if(miter == wordmap.m_word_map.end()){
        cout << "No words in m_word_map...\n";
        return 1;
    }
    
    wordvector.print();
    
    while(miter != wordmap.m_word_map.end()){
        target_pair.first = (*miter).first;
        target_pair.second = (*miter).second;
        
        wordvector.m_word_vector.push_back(target_pair);
        miter++;
    }
    
    //clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &start);
    wordvector.sort("QUICK", "VALUE");
    //clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &end);
    wordvector.print();

    //clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &start);
    wordvector.sort("QUICK", "KEY");
    //clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &end);
    wordvector.print();

    //clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &start);
    wordvector.sort("MERGE", "VALUE");
    //clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &end);
    wordvector.print();

    //clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &start);
    wordvector.sort("MERGE", "KEY");
    //clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &end);
    wordvector.print();

    //clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &start);
    wordvector.sort("HEAP", "VALUE");
    //clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &end);
    wordvector.print();
    
    //clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &start);
    wordvector.sort("HEAP", "KEY");
    //clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &end);
    wordvector.print();
    
    //clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &start);
    wordvector.sort("INSERTION", "VALUE");
    //clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &end);
    wordvector.print();
    
    //clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &start);
    wordvector.sort("INSERTION", "KEY");
    //clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &end);
    wordvector.print();
    
    return 0;
}


timespec diff(timespec start, timespec end)
{
	timespec temp;
	if ((end.tv_nsec-start.tv_nsec)<0) {
		temp.tv_sec = end.tv_sec-start.tv_sec-1;
		temp.tv_nsec = 1000000000+end.tv_nsec-start.tv_nsec;
	} else {
		temp.tv_sec = end.tv_sec-start.tv_sec;
		temp.tv_nsec = end.tv_nsec-start.tv_nsec;
	}
	return temp;
}
