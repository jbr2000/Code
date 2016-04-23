#include "event_manager.h"
#include "gpl_assert.h"
using namespace std;

/* static */ Event_manager *Event_manager::m_instance = 0;

/* static */ Event_manager * Event_manager::instance()
{
  if (!m_instance)
    m_instance = new Event_manager();
  return m_instance;
}

Event_manager::Event_manager()
{
}

Event_manager::~Event_manager()
{
}


void Event_manager::execute_handlers(Window::Keystroke keystroke)
{
    vector<Statement_block*> vec = Event_manager::instance()->events[keystroke];
    for (unsigned int i=0; i < vec.size(); i++) {
        vec[i]->execute();
    }
}

void Event_manager::register_event(Window::Keystroke p_key, Statement_block* p_stmt_block)
{
    Event_manager::instance()->events[p_key].push_back(p_stmt_block);
    assert(Event_manager::instance()->events[p_key].size() > 0);
}
