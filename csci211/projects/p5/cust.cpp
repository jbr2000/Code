// McWilliams, Spencer
// smcwilliams
// cust.cpp

#include <fstream>
using namespace std;

#include "cust.h"

// Constructor
Cust::Cust(string name, bool is_shopper, int arrival_time, int num_items) {
    m_name = name;
    m_is_shopper = is_shopper;
    m_num_items = num_items;
    m_arrival_time = arrival_time;
}

Cust::~Cust()
{
    
}

void Cust::print() {
    cout << "Name: " << m_name << endl;
    cout << "Arrival time: " << m_arrival_time << endl;
    cout << "Num_items: " << m_num_items << endl;
    cout << "Shopper: " << m_is_shopper << endl;
    return;
}

int Cust::time_done_shopping() {
    return m_arrival_time+m_num_items; 
}

void Cust::time_done_checking(int clock) {
    if (m_is_shopper) {
        m_done_checking_time = clock+(m_num_items*2);
        return;
    }

    m_done_checking_time = clock+2;
    return;
}

int Cust::time_start_checking(int clock) {
    return 0;
}

void Cust::print_arrival(ostream &o_file, int clock) {
    o_file << clock << ": " << m_name << " entered store\n";
    return;
}

void Cust::print_done_shopping(ostream &o_file, int clock) {
    o_file << clock << ": " << m_name << " done shopping\n";
    return;
}

void Cust::print_start_checking(ostream &o_file, int checker, int clock) {
    o_file << clock << ": " << m_name << " started checkout with checker " << checker << endl;
    return;
}

void Cust::print_checking_info(ostream &o_file, int checker, int clock, int *money_in_register) {
    o_file << clock << ": " << m_name;

    if(m_is_shopper) {
        o_file << " paid $" << (m_num_items*3)
             << " for " << m_num_items << " item";
             if(m_num_items > 1)
                o_file << "s";
        o_file << " to checker "
             << checker << endl;
        *money_in_register += (m_num_items*3);
        return;
    }

    o_file << " stole $" << *money_in_register 
           << " and " << m_num_items << " item";
           if(m_num_items > 1)
               o_file << "s";
    o_file << " from checker "
           << checker << endl;
    *money_in_register = 0;
    return;
}

bool Cust::done_checking(int clock) {
    if(m_done_checking_time == clock)
        return true;
    else
        return false;
}
