// Endque function
Void Queue::enqueue(Video *video)
{
    if(m_head == NULL)
        m_head = m_tail = new Node(video, NULL);

    else
    {
        m_tail->m_next = new Node(video, NULL);
        m_tail = m_tail->m_next;
    }
}


//Will execute while something is being dequeue'd

while (video = q.dequeue())
{
    video -> print();
}

Video *Queue::dequeue()
{
    if(!m_head)
        return NULL;

    Video *video = m_head -> m_video;
    Node *tmp = m_head;
    m_head = m_head -> m_next;
    delete tmp;
    return video;




//Array Queue

Class Iqueue
{
    public:
        Iqueue (int max_size);
        ~Iqueue ();
        void enqueue (int value);
        bool dequeue (int &value);
    private:
        int m_size;
        int m_first;
        int m_last;
        int m_max_size;
        int *m_values;
};


Inqueue::Iqueue(int max_size)
{
    assert(max_size > 0);

    m_max_size = max_size;
    m_values = new int[m_max_size];
    m_size = 0;
}

Iqueue::dequeue (int &value)
{
    
}
