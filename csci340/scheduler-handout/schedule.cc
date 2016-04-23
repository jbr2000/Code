#include "schedule.h"
#include <stdlib.h>
#include <stdio.h>
#include "assert.h"

#define DEBUGGING 0
#define NUM_QS 4

struct node{
    int   pid;
    struct node *prev;
    struct node *next;
};

node* queues[NUM_QS];
int i;
int q_index;

/**
 * Function to initialize any global variables for the scheduler. 
 */
void init(){
    q_index = 0;
}

/**
 * Function to add a process to the scheduler
 * @Param pid - the ID for the process/thread to be added to the 
 *      scheduler queue
 * @Param priority - priority of the process being added
 * @return true/false response for if the addition was successful
 */
int addProcess(int pid, int priority){
    node* cur;
    // quanta   4 - 1
    // priority 1 - 4
    // queue    0 - 3
    cur = queues[priority-1];
    if (!cur) {
        queues[priority-1] = (node*) malloc (sizeof(node));
        cur = queues[priority-1];
        cur->pid = pid;
        cur->prev = NULL;
        cur->next = NULL;
        return 1;
    }
    while(cur->next) cur = cur->next;
    cur->next = (node*) malloc (sizeof(node));
    cur->next->pid = pid;
    cur->next->prev = cur;
    cur->next->next = NULL;
    return 1;
}

/*
 * Function to remove a process from the scheduler queue
 * @Param pid - the ID for the process/thread to be removed from the
 *      scheduler queue
 * @Return true/false response for if the removal was successful
 */
int removeProcess(int pid){
    node* cur;
    for (i=0; i<NUM_QS; i++) {
        cur = queues[i];
        if (cur) { /* queue is not empty */
            do {
                if (cur->pid == pid) {
                    if (!cur->next && !cur->prev) {
                        queues[i] = NULL;
                        if(DEBUGGING)printf("Killing Queue[%d]\n", i);
                        //free(cur);
                        return 1;
                    }
                    if (cur->prev) cur->prev->next = cur->next;
                    if (cur->next) cur->next->prev = cur->prev;
                    //free(cur);
                    return 1;
                }
                cur = cur->next;
            } while (cur);
        }
    }
    return 0;
}
/*
 * Function to get the next process from the scheduler
 * @Param time - pass by reference variable to store the quanta of time
 * 		the scheduled process should run for
 * @Return returns the thread id of the next process that should be 
 *      executed, returns -1 if there are no processes
 */
int nextProcess(int &time){
    node* cur;
    int job;
    cur = queues[q_index];
    if (cur) {
        time = 4-q_index;
        job = cur->pid;

        queues[q_index] = cur->next;
        removeProcess(cur->pid);
        assert(addProcess(cur->pid, q_index+1));

        q_index++;
        if (q_index == 4) q_index = 0;

        return job;
    }
    else {
        time=0;
        q_index++;
        if (q_index == 4) q_index = 0;
        return -1;
    }
}

/*
 * Function that returns a boolean 1 True/0 False based on if there are any 
 * processes still scheduled
 * @Return 1 if there are processes still scheduled 0 if there are no more 
 *		scheduled processes
 */
int hasProcess(){
	for (i=0; i<NUM_QS; i++)
        if (queues[i]) return 1;
    return 0;
}

void print(int q) {
    node* tmp = queues[q];
    if (!tmp->next) {
        if(DEBUGGING)printf("%d -> NULL\n", tmp->pid);
        return;
    }
    while (tmp) {
        if(DEBUGGING)printf("%d -> ", tmp->pid);
        tmp = tmp->next;
    }
    if(DEBUGGING)printf("NULL\n");
    return;
}

















