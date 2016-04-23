/*
 * File: lookup.c * Author: Andy Sayler
 * Project: CSCI 3753 Programming Assignment 2
 * Create Date: 2012/02/01
 * Modify Date: 2012/02/01
 * Description:
 * 	This file contains the reference non-threaded
 *      solution to this assignment.
 *  
 */

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <pthread.h>
#include <unistd.h>

#include "util.h"
#include "queue.h"

#define DEBUGGING 0

#define MINARGS 3
#define USAGE "<inputFilePath> <outputFilePath>"
#define SBUFSIZE 1025
#define MAX_THREADS 10
#define INPUTFS "%1024s"

/* Mutex Locks */
pthread_mutex_t queue_lock;
pthread_mutex_t output_lock;

queue q;

int requesters_done;

void* add_urls(void* _inputfp);
void* lookup(void* _outputfp);

int main(int argc, char* argv[]) {
    /* Local Vars */
    FILE* inputfp = NULL;
    FILE* outputfp = NULL;
    char errorstr[SBUFSIZE];
    pthread_t requester_threads[MAX_THREADS];
    pthread_t resolver_threads[MAX_THREADS];
    int req_t;
    int requester_thread_count = 0;
    int res_t;

    requesters_done = 0;

    /* Set params */
    queue_init(&q, 50);
    
    /* Check Arguments */
    if(argc < MINARGS){
        fprintf(stderr, "Not enough arguments: %d\n", (argc - 1));
        fprintf(stderr, "Usage:\n %s %s\n", argv[0], USAGE);
        return EXIT_FAILURE;
    }

    /* Open Output File */
    outputfp = fopen(argv[(argc-1)], "w");
    if(!outputfp){
        perror("Error Opening Output File");
        return EXIT_FAILURE;
    }

    /* Create resolver threads */
    for (res_t=0; res_t<MAX_THREADS; res_t++) {
        pthread_create(&(resolver_threads[res_t]), NULL, lookup, outputfp);
        if(DEBUGGING) printf("resolver_thread[%d] created!\n", res_t);
    }
    
    /* Loop Through Input Files */
    for(req_t=1; req_t<(argc-1); req_t++){
        inputfp = fopen(argv[req_t], "r");
        if(!inputfp) { /* Error Checking */
            if(DEBUGGING) sprintf(errorstr, "Error Opening Input File: %s", argv[req_t]);
            perror(errorstr);
            break;
        }
        pthread_create(&(requester_threads[req_t-1]), NULL, add_urls, inputfp);
        if(DEBUGGING) printf("requester_thread[%d] created!\n", req_t-1);
        requester_thread_count++;
    }

    /* Join requester threads */
    for (req_t=0; req_t<requester_thread_count; req_t++)
        pthread_join(requester_threads[req_t], NULL);
    if(DEBUGGING) printf("Requester threads completed!\n");

    requesters_done = 1;

    /* Join resover threads */
    for (res_t=0; res_t<10; res_t++)
       pthread_join(resolver_threads[res_t], NULL);
    if(DEBUGGING) printf("Resolver threads completed!\n");
    fclose(outputfp);

    return EXIT_SUCCESS;
}

void* add_urls(void* _inputfp) {
    char* hostname = (char*) malloc (SBUFSIZE);
    while(fscanf((FILE*)_inputfp, INPUTFS, hostname) > 0) {
        pthread_mutex_lock(&queue_lock);
        if (queue_is_full(&q)) usleep(rand()%100);
        queue_push(&q, hostname);
        if(DEBUGGING) printf("pushed <%s>\n", hostname);
        pthread_mutex_unlock(&queue_lock);
        hostname = (char*) malloc (SBUFSIZE);
    }
    fclose(_inputfp);
    free(hostname);
    pthread_exit(NULL);
}

void* lookup(void* _outputfp) {
    char firstipstr[INET6_ADDRSTRLEN];
    char* hostname;
    while (1) {
        pthread_mutex_lock(&queue_lock);
        if(queue_is_empty(&q)) {
            pthread_mutex_unlock(&queue_lock);
            if(requesters_done) pthread_exit(NULL);
        }
        else{
            hostname = (char*) queue_pop(&q);
            if(DEBUGGING && hostname) printf("popped <%s>\n", hostname);
            pthread_mutex_unlock(&queue_lock);
            if (dnslookup(hostname, firstipstr, sizeof(firstipstr)) == UTIL_FAILURE) {
                fprintf(stderr, "dnslookup error: %s\n", hostname);
                strncpy(firstipstr, "", sizeof(firstipstr));
            }
            pthread_mutex_lock(&output_lock);
            fprintf((FILE*)_outputfp, "%s,%s\n", hostname, firstipstr);
            if(DEBUGGING) printf("Should have printed <%s,%s> to outputfp\n", hostname, firstipstr);
            pthread_mutex_unlock(&output_lock);
            free (hostname);
        }
    }
}
















/* END */
