// Video.h File

#ifndef VIDEO_H
#define VIDEO_H

#include <iostream>
#include <string>
using namespace std;

class Video
{
    public:
        Video(string title, string url, string description, double length, int rating);
        
        bool    longer(Video *other);
        bool    comes_before(Video *other);
        bool    better(Video *other);
        void    print();
        string  get_title();
    private:
        string  m_title;
        string  m_url;
        string  m_description;
        double  m_length;
        int     m_rating;
};

#endif
