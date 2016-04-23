// Spencer McWilliams
// CSCI 340
// smcwilliams

// includes and defines
using namespace std;

#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <ctype.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <errno.h>
#include <string>
#include <limits.h>
#include <sys/time.h>

#include "helper-routines.h"

#define BUFFER_SIZE 25
#define READ_END 0
#define WRITE_END 1

// Define Global Variables
pid_t   pid;
timeval t1,  t2,
        rt1, rt2;
int     numtests, signal_count(0);
double  elapsedTime(0);
double  avg_t(0), max_t(0), min_t(42);

// Function Declarations
// Signal handlers 
void sigusr1_handler(int sig);
void sigusr2_handler(int sig);
void sigint_handler (int sig);
void calculate_time();
void print_results(pid_t pid);

int main(int argc, char **argv) {
    //Variables for Pipe
    int fd1[2],fd2[2], nbytes;    
    //Byte size messages to be passed through pipes
    char    childmsg[] = "1";
    char    parentmsg[] = "2";
    char    quitmsg[] = "q";
    char    readmsg[BUFFER_SIZE];
    
    // Signal Handler Installation
    Signal(SIGUSR1,  sigusr1_handler);
    Signal(SIGUSR2,  sigusr2_handler);
    Signal(SIGINT,   sigint_handler );
    
    numtests=100;
    if(argc<2){
        printf("Not enough arguments\n");
        exit(0);
    }
    if(argv[2]) numtests = atoi(argv[2]);

    printf("Number of Tests %d\n", numtests);
    gettimeofday(&t1, NULL); // start timer
    /*
    elapsedTime = (t1.tv_sec) * 1000.0;      // sec to ms
    elapsedTime += (t1.tv_usec) / 1000.0;   // us to ms
    printf("t1 : %f\n", elapsedTime);
    */

    //Test pipes
    if(strcmp(argv[1],"-p")==0) {
        //Code for benchmarking pipes over numtests
        //Create pipe
        if (pipe(fd1) == -1) {
            fprintf(stderr, "Pipe failed\n");
            return 1;
        }
        if (pipe(fd2) == -1) {
            fprintf(stderr, "Pipe failed\n");
            return 1;
        }
        pid = fork();
        if (pid < 0) {
            fprintf(stderr, "Fork failed");
            return 1;
        }
        for (int i=0; i<numtests; i++) {
            if (pid > 0) { //Parent process
                // write to fd1
                close(fd1[READ_END]);
                gettimeofday(&rt1, NULL); // start timing parent round trip
                write(fd1[WRITE_END], parentmsg, strlen(parentmsg)+1);
                
                // read from fd2
                close(fd2[WRITE_END]);
                read(fd2[READ_END], readmsg, BUFFER_SIZE); // stall
                gettimeofday(&rt2, NULL); // stop timing parent round trip

                // evaluate time
                calculate_time();
            }
            if (pid == 0) { //Child process
                // read from fd1
                close(fd1[WRITE_END]);
                read(fd1[READ_END], readmsg, BUFFER_SIZE);
                if (i) {
                    gettimeofday(&rt2, NULL);
                    calculate_time();
                }
                // write to fd2
                close(fd2[READ_END]);
                write(fd2[WRITE_END], childmsg, BUFFER_SIZE);
                gettimeofday(&rt1, NULL);
            }
        }
        // stop timer
        gettimeofday(&t2, NULL);
        print_results(pid);
    }

    //Test signals
    if(strcmp(argv[1],"-s")==0){
        pid = fork();
        if (pid < 0) {
            fprintf(stderr, "Fork failed");
            return 1;
        }
        if (pid > 0) { //parent
            gettimeofday(&rt1, NULL); // start parent timer
            kill(pid,SIGUSR1);
            while(!waitpid(-1, NULL, 0));
        }
        if (!pid) while(1); // child
        print_results(pid);
    }
    return 0;
}


// Functions Definitions

// Signal handlers
void sigusr1_handler(int sig) // parent to child
{    
    if (signal_count) {
        gettimeofday(&rt2, NULL);
        calculate_time();
    }
    gettimeofday(&rt1, NULL);
    kill(getppid(),SIGUSR2);
    signal_count++;
}

void sigusr2_handler(int sig) // child to parent
{ 
    gettimeofday(&rt2, NULL);
    calculate_time();
    if (signal_count < numtests) {
        signal_count++;
        gettimeofday(&rt1, NULL);
        kill(pid,SIGUSR1);
    }
    else kill(pid, SIGINT);
}

void sigint_handler(int sig)
{
    gettimeofday(&rt2, NULL);
    calculate_time();
    print_results(pid);
    exit(0);
}

// Misc functions
void calculate_time() {
    double time = (rt2.tv_sec  - rt1.tv_sec ) * 1000.0; // sec to ms
    time  +=      (rt2.tv_usec - rt1.tv_usec) / 1000.0; // us to ms
    avg_t += time;
//    if (pid) printf ("time for parent : %f\n", time);
//    if (!pid) printf("time for child  : %f\n", time);
    if (time > max_t) max_t = time;
    if (time < min_t) min_t = time;
}

void print_results(pid_t pid) {
    if (pid > 0) { //parent
        while(!waitpid(-1,NULL,0));
        printf("Parent's results for Pipe IPC mechanisms\n");
    }
    else if (!pid) { //child
        printf("Child's results for Pipe IPC mechanisms\n");
    }
    gettimeofday(&t2, NULL);
    /*
    elapsedTime = (t2.tv_sec) * 1000.0;      // sec to ms
    elapsedTime += (t2.tv_usec) / 1000.0;   // us to ms
    printf("t2 : %f\n", elapsedTime);
    */
    printf("Process ID is %d, Group ID is %d\n", getpid(), getgid());
    avg_t = avg_t/numtests;
    printf("Average %f\n",avg_t);
    printf("Maximum %f\n",max_t);
    printf("Minimum %f\n",min_t);
    elapsedTime = (t2.tv_sec - t1.tv_sec) * 1000.0;      // sec to ms
    elapsedTime += (t2.tv_usec - t1.tv_usec) / 1000.0;   // us to ms
    printf("Elapsed Time %f\n", elapsedTime);
}


