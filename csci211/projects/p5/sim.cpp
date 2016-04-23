// McWilliams, Spencer
// smcwilliams
// sim.cpp

#include <iostream>
#include <cstdlib>
#include <fstream>
#include <string>
using namespace std;

#include "cust.h"
#include "pqueue.h"

bool legal_int(char *string);
bool is_shopper(string status);
bool one_checker_empty(Cust **checker, int number_of_checkers);
void initialize_array_to_null(Cust **array, int size);
void initialize_register_array(int *array, int size);
void run_simulation(Pqueue &arrival_queue, int number_of_checkers, int number_of_customers, ofstream &o_file);

int main(int argc, char *argv[])
{
    Pqueue arrival_queue;
    string  name, shopper_status;
    int     arrival_time;
    int     num_items;
    int     number_of_customers=0;
    int     number_of_checkers;

// Test for correct input
    if (argc != 4) {
        cerr << "Error: invalid number of command line arguments.\n";
        return 1;
    }
    
    if (!legal_int(argv[1])) {
        cerr << "Error: invalid number of checkers specified.\n";
        return 1;
    }

    ifstream i_file(argv[2], ios::in);
    ofstream o_file(argv[3], ios::out);

    if (!i_file) {
        cerr << "Error: could not open input file <" << argv[2] << ">.\n";
        return 1;
    }
    
    if (!o_file) {
        cerr << "Error: could not open output file <" << argv[3] << ">.\n";
        return 1;
    }
    
// READ IN CUSTOMERS
        while (i_file.peek() != -1) {
            i_file >> name;
            i_file >> shopper_status;
            i_file >> arrival_time;
            i_file >> num_items;
            arrival_queue.enqueue(new Cust(name,is_shopper(shopper_status),arrival_time,num_items),arrival_time);
            number_of_customers++;
            i_file.ignore();
        }

    number_of_checkers = atoi(argv[1]);
   
    run_simulation(arrival_queue, number_of_checkers, number_of_customers, o_file);

    return 0;
}



/*  -------------------------------------------
            OTHER FUNCTIONS BESIDES MAIN 
    ------------------------------------------- */



void run_simulation(Pqueue &arrival_queue, int number_of_checkers, int number_of_customers, ofstream &o_file) {
    Pqueue  shopping_queue, checkout_queue; 
    int    *cash_register = new int[number_of_checkers];
    Cust   *customer;
    Cust  **checker = new Cust*[number_of_checkers];

// Inititalize checker pointers to NULL.
    initialize_array_to_null(checker,number_of_checkers);
    initialize_register_array(cash_register,number_of_checkers);

// BEGIN THE SIMULATION* 
    for (int clock = 0; number_of_customers > 0; clock++) {

    // Checking if anyone is done checking out. If so, adjust the registers appropriately, and remove the customer.
        for (int i=0; i<number_of_checkers; i++) {
            if (checker[i])
                if (checker[i]->done_checking(clock)) {
                    checker[i]->print_checking_info(o_file,i,clock,&cash_register[i]);
                    number_of_customers--;
                    delete checker[i];
                    checker[i] = NULL;
                }
        }

    // Move customers in the arrival queue to the shopping queue when the clock == their arrival time (priority).
        while (!arrival_queue.is_empty() && arrival_queue.first_node_prio() == clock) {
            customer = arrival_queue.dequeue();
            customer->print_arrival(o_file,clock);
            shopping_queue.enqueue(customer,customer->time_done_shopping());
        }

    // Move customers from the shpping queue to the checkout queue when the clock == the time they should be done shopping (their new priority).
        while (!shopping_queue.is_empty() && shopping_queue.first_node_prio() == clock) {
            customer = shopping_queue.dequeue();
            customer->print_done_shopping(o_file,clock);
            checkout_queue.enqueue(customer,0);
        }

    // If one checker is free and the someone is in line, move them to a checker and determine at what time they will be finished checking out.
        for (int i=0; i<number_of_checkers && !checkout_queue.is_empty(); i++) {
            if(!checker[i]) {
                checker[i] = checkout_queue.dequeue();
                checker[i]->print_start_checking(o_file,i,clock);
                checker[i]->time_done_checking(clock);
            }
        } 
    }

    // Print remaining amount of money in each register.
    for (int i=0; i<number_of_checkers; i++) {
        o_file << "registers[" << i << "] = $" << cash_register[i] << endl;
    } 
    return;
}

bool legal_int(char *string) {
    char *tmp = string;
    while (*tmp) {
        if (!isdigit(*tmp))
            return false;
        tmp++;
    }
    return true;
}

bool is_shopper(string status) {
    if (status == "shopper")
        return true;
    else
        return false;
}

bool one_checker_empty(Cust **checker, int number_of_checkers) {
    for (int i=0; i<number_of_checkers; i++) {
        if (!checker[i])
            return true;
    }
    return false;
}

void initialize_array_to_null(Cust **array, int size) {
    for (int i=0; i<size; i++) {
        array[i] = NULL;
    }
    return;
}

void initialize_register_array(int *array, int size) {
    for (int i=0; i<size; i++) {
        array[i] = 100;
    }
    return;
}
