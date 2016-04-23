/* Thread startup function
 * Used during creation of the Requester_Thread
 *   to add all URLs from a given file to the queue.
 * _params is a Thread_Parameters struct
 *   as specified in multi-lookup.c
 */
void* add_urls(void* _inpufp);

/* Thread startup function
 * Used during creation of Resolver_Thread
 *   to resolve IPs from URLs on the queue.
 * _params is a Thread_Parameters struct
 *   as specified in multi-lookup.c
 */
void* lookup(void* _outputfp);
