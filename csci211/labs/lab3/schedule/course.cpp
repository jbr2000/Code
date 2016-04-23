// course.cpp file

#include <iostream>
#include <string>
using namespace std;

#include "course.h"

// constructor
Course::Course(string dept, int number, int time)
{
    m_dept = dept;
    m_number = number;
    m_time = time;
}

void Course::print()
{
    cout << m_dept << " " << m_number << " at " << m_time << endl;
    return;
}
