#include <vector>
#include "animation_block.h"
#include "game_object.h"
#include "indent.h"
#include "gpl_assert.h"
using namespace std;

Animation_block::Animation_block(Symbol *parameter_symbol, string name)
{
  m_name = name;
  m_parameter_symbol = parameter_symbol;
  m_complete = false;
}

void Animation_block::mark_complete()
{
  m_complete = true;
}

bool Animation_block::complete()
{
  return this->m_complete;
}

void Animation_block::execute(Game_object *argument)
{
  m_parameter_symbol->value = argument;
  Statement_block::execute();
}
