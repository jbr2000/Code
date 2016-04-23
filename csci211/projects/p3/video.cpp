#include <iostream>
#include <string>
using namespace std;

#include "video.h"

// constructor
Video::Video(string title, string url, string description, double length, int rating)
{
    m_title = title;
    m_url = url;
    m_description = description;
    m_length = length;
    m_rating = rating;
}

void Video::print()
{

//  "title, url, description, length, ***"

    cout << m_title;
    cout << ", "
         << m_url;
    cout << ", "
         << m_description;
    cout << ", "
         << m_length;
    cout << ", ";
    
    for (int i=0; i<m_rating; i++)
    {
        cout << "*";
    }
    
    cout << endl;
}

bool Video::longer(Video *other)
{
    return (m_length > other->m_length);
}

bool Video::comes_before(Video *other)
{
    return (m_title <= other->m_title);
}

bool Video::better(Video *other)
{
    return (m_rating < other->m_rating);
}

string Video::get_title()
{
    return m_title;
}
