// McWilliams, Spencer
// smcwilliams
// cust.h
#include <iostream>
#include <string>
using namespace std;

#ifndef CUST_H
#define CUST_H

class Cust
{
    public:
        Cust(string name, bool is_shopper, int arrival_time, int num_items);
        ~Cust();
        int  time_done_shopping();
        int  time_start_checking(int clock);
        bool done_checking(int clock);
        bool is_shopper();
        void print();
        void time_done_checking(int clock);
        void print_arrival(ostream &o_file, int clock);
        void print_done_shopping(ostream &o_file, int clock);
        void print_start_checking(ostream &o_file, int checker, int clock);
        void print_checking_info(ostream &o_file, int checker, int clock, int *money_in_register);
    private:
        string m_name;
        // if m_is_shopper is true, the customer is a shopper, otherwise they are a robber.
        int    m_arrival_time;
        int    m_num_items;
        int    m_done_checking_time;
        bool   m_is_shopper;
};

#endif
