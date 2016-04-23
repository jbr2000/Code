#include <iostream>
#include <string>
using namespace std;

#include "video.h"

void sort_by_length(Video *videos[], int num_videos);
void sort_by_rating(Video *videos[], int num_videos);
void sort_by_title(Video *videos[], int num_videos);

int main()
{
    string title, url, description;
    double length;
    int    rating;
    int    num_videos=0;
    string sort_method;
    Video  *videos[100];

    getline(cin,sort_method);

    if ((sort_method != "rating") &&
        (sort_method != "title") &&
        (sort_method != "length"))
    {
        cerr << sort_method << " is not a legal sorting method, giving up." << endl;
        return 1;
    }

    while (getline(cin,title)) {
        getline(cin, url);
        getline(cin, description);
        cin >> length;
        cin >> rating;

    // Ignore the extra space before the '\n'
        cin.ignore();
        videos[num_videos] = new Video(title, url, description, length, rating);

        num_videos++;
    }

    if (num_videos > 100)
    {
        cerr << "Too many videos, giving up." << endl;
        return 1;
    }

    if (sort_method == "rating")
        sort_by_rating(videos,num_videos);

    if (sort_method == "length")
        sort_by_length(videos,num_videos);

    if (sort_method == "title")
        sort_by_title(videos,num_videos);

    for (int i=0; i<num_videos; i++)
        videos[i]->print();

    return 0;
}

void sort_by_length(Video *videos[], int num_videos)
{
    for (int last=num_videos-1; last>0; last--)
    {
        for (int cur=0; cur<last; cur++)
        {
            if (videos[cur]->longer(videos[cur+1]))
            {
                swap(videos[cur],videos[cur+1]);
            }
        }
    }
}

void sort_by_rating(Video *videos[], int num_videos)
{
    for (int last=num_videos-1; last>0; last--)
    {
        for (int cur=0; cur<last; cur++)
        {
            if (videos[cur]->better(videos[cur+1]))
            {
                swap(videos[cur],videos[cur+1]);
            }
        }
    }
}


void sort_by_title(Video *videos[], int num_videos)
{
    for (int last=num_videos-1; last>0; last--)
    {
        for (int cur=0; cur<last; cur++)
        {
            if (videos[cur]->first(videos[cur+1]))
            {
                swap(videos[cur],videos[cur+1]);
            }
        }
    }
}
