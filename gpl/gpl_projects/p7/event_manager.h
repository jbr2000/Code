#ifndef EVENT_MANAGER_H
#define EVENT_MANAGER_H

#include <iostream>
#include <string>
#include <vector>
using namespace std;

#include "window.h" // for Keystroke enum
#include "statement_block.h"

class Event_manager
{
  public:
    vector<Statement_block*> events[Window::NUMBER_OF_KEYS];
    static Event_manager *instance();
    void execute_handlers(Window::Keystroke keystroke);
    ~Event_manager();
    // index addressable by key, vector to store statement_blocks
    // for given keystroke
    void register_event(Window::Keystroke p_key, Statement_block* p_stmt_block);

  private:
    // hide default constructor because this is a singleton
    Event_manager();
    static Event_manager *m_instance;
    // disable default copy constructor and default assignment
    // done as a precaution, they should never be called
    Event_manager(const Event_manager&); 
    const Event_manager &operator=(const Event_manager&); 
};

#endif // #ifndef EVENT_MANAGER_H
