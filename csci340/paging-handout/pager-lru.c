/*
 * File: pager-lru.c
 * Author:     Andy Sayler
 *         http://www.andysayler.com
 * Adopted From: Dr. Alva Couch
 *         http://www.cs.tufts.edu/~couch/
 *
 * Project: CSCI 3753 Programming Assignment 4
 * Create Date: Unknown
 * Modify Date: 2012/04/03
 * Description:
 *   This file contains an lru pageit
 *    implmentation.
 */

#include <stdio.h> 
#include <stdlib.h>

#include "simulator.h"

void pageit(Pentry q[MAXPROCESSES]) { 
  
  /* This file contains the stub for an LRU pager */
  /* You may need to add/remove/modify any part of this file */

  /* Static vars */
  static int initialized = 0;
  static int tick = 1; // artificial time
  static int timestamps[MAXPROCESSES][MAXPROCPAGES];

  /* Local vars */
  int proctmp;
  int pagetmp;
  int i;
  int j;
  int min;
  min = 0x7fffffff;

  /* initialize static vars on first run */
  if(!initialized){
    for(proctmp=0; proctmp < MAXPROCESSES; proctmp++){
      for(pagetmp=0; pagetmp < MAXPROCPAGES; pagetmp++){
      timestamps[proctmp][pagetmp] = 0; 
      }
    }
    initialized = 1;
  }

  /* select a process */
  for (proctmp = 0; proctmp<MAXPROCESSES; proctmp++) {
    /* first active process */
    if (q[proctmp].active) {
      /* determine current page */
      pagetmp = q[proctmp].pc/PAGESIZE;
      /* is page swapped in? */
      if (!q[proctmp].pages[pagetmp]) {
        /* try to page in */
        if (!pagein(proctmp, pagetmp)) {
          /* select a page to evict */
          int eproc=-1;
          int epage=-1;
          min = 0x7fffffff;
          for (i=0; i<MAXPROCESSES; i++) {
            for (j=0; j<MAXPROCPAGES; j++) {
              /* page in memory and minimum */
              if (q[i].pages[j] && (timestamps[i][j] < min)) {
                min = timestamps[i][j];
                eproc=i;
                epage=j;
              }
            }
          }
          pageout(eproc,epage); 
          break; 
        } else {
          timestamps[proctmp][pagetmp] = tick;
        }
      }
    }
  }
  tick++;
} 
