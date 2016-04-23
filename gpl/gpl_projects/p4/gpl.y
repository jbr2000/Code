%{
  extern int yylex();
extern int yyerror(const char *);

#include "error.h"
#include "parser.h"
#include "symbol_table.h"
#include "gpl_type.h"
#include <iostream>
#include <string>
using namespace std;
%} 

%union {
  int            union_int;
  double         union_double;
  std::string    *union_string;
  int            union_gpl_type;
}

%error-verbose 

%token T_LPAREN             "("
%token T_RPAREN             ")"
%token T_LBRACE             "{"
%token T_RBRACE             "}"
%token T_LBRACKET           "["
%token T_RBRACKET           "]"
%token T_SEMIC              ";"
%token T_COMMA              ","
%token T_PERIOD             "."
%token T_ASSIGN             "="
%token T_ASTERISK           "*"
%token T_DIVIDE             "/"
%token T_PLUS               "+"
%token T_MINUS              "-"
%token T_MOD                "%"
%token T_LESS               "<"
%token T_GREATER            ">"
%token T_LESS_EQUAL         "<="
%token T_GREATER_EQUAL      ">="
%token T_EQUAL              "=="
%token T_NOT_EQUAL          "!="
%token T_NOT                "!"
%token T_AND                "&&"
%token T_OR                 "||"
%token T_MINUS_ASSIGN       "-="
%token T_PLUS_ASSIGN        "+="
%token T_INT                "int"
%token T_DOUBLE             "double"
%token T_STRING             "string"
%token T_TRIANGLE           "triangle"
%token T_PIXMAP             "pixmap"
%token T_CIRCLE             "circle"
%token T_RECTANGLE          "rectangle"
%token T_TEXTBOX            "textbox"
%token T_FORWARD            "forward"
%token T_INITIALIZATION     "initialization"
%token T_ON                 "on"
%token T_ANIMATION          "animation"
%token T_IF                 "if"
%token T_FOR                "for"
%token T_ELSE               "else"
%token T_EXIT               "exit"
%token T_PRINT              "print"
%token T_TRUE               "true"
%token T_FALSE              "false"
%token T_SPACE              "space"
%token T_LEFTARROW          "left arrow"
%token T_RIGHTARROW         "right arrow"
%token T_UPARROW            "up arrow"
%token T_DOWNARROW          "down arrow"
%token T_LEFTMOUSE_DOWN     "left mouse down"
%token T_MIDDLEMOUSE_DOWN   "middle mouse down"
%token T_RIGHTMOUSE_DOWN    "right mouse down"
%token T_LEFTMOUSE_UP       "left mouse up"
%token T_MIDDLEMOUSE_UP     "middle mouse up"
%token T_RIGHTMOUSE_UP      "right mouse up"
%token T_MOUSE_MOVE         "mouse move"
%token T_MOUSE_DRAG         "mouse drag"
%token T_F1                 "F1"
%token T_WKEY               "W key"
%token T_AKEY               "A key"
%token T_SKEY               "S key"
%token T_DKEY               "D key"
%token T_FKEY               "F key"
%token T_HKEY               "H key"
%token T_JKEY               "J key"
%token T_KKEY               "K key"
%token T_LKEY               "L key"
%token T_TOUCHES            "touches"
%token T_NEAR               "near"
%token T_SIN                "sin"
%token T_COS                "cos"
%token T_TAN                "tan"
%token T_ASIN               "asin"
%token T_ACOS               "acos"
%token T_ATAN               "atan"
%token T_SQRT               "sqrt"
%token T_ABS                "abs"
%token T_FLOOR              "floor"
%token T_RANDOM             "random"

%token <union_int>    T_INT_CONSTANT      "int constant"
%token <union_string> T_STRING_CONSTANT   "string constant"
%token <union_double> T_DOUBLE_CONSTANT   "double constant"
%token <union_string> T_MONTH             "month"
%token <union_string> T_ID                "identifier"
%token <union_string> T_ERROR             "error"

%nonassoc   IF_NO_ELSE
%nonassoc   T_ELSE
%right      T_OR
%right      T_AND
%right      T_NOT_EQUAL T_EQUAL
%right      T_GREATER   T_LESS      T_LESS_EQUAL T_GREATER_EQUAL
%left       T_PLUS      T_MINUS
%left       T_ASTERISK  T_DIVIDE    T_MOD
%nonassoc   UNARY_OPS

%type <union_gpl_type> simple_type

%%

//---------------------------------------------------------------------
program:
    declaration_list block_list
    ;

//---------------------------------------------------------------------
declaration_list:
    declaration_list declaration
    | empty
    ;

//---------------------------------------------------------------------
declaration:
    variable_declaration T_SEMIC
    | object_declaration T_SEMIC
    | forward_declaration T_SEMIC
    ;

//---------------------------------------------------------------------
variable_declaration:
    simple_type  T_ID  optional_initializer
    {
      Symbol *symbol;
      if($1==INT)
        symbol = new Symbol(*$2, INT, new int(42), false);
      else if($1==DOUBLE)
        symbol = new Symbol(*$2, DOUBLE, new double(3.14159), false);
      else if($1==STRING)
        symbol = new Symbol(*$2, STRING, new string("Hello world"), false);

      Symbol_table::instance()->add_symbol(symbol);
    }
    | simple_type  T_ID  T_LBRACKET T_INT_CONSTANT T_RBRACKET
    {
      //change expression to T_INT_CONST
      Symbol *symbol;
      if($1==INT)
        symbol = new Symbol(*$2, INT, new int($4), true);
      else if($1==DOUBLE)
        symbol = new Symbol(*$2, DOUBLE, new int($4), true);
      else if($1==STRING)
        symbol = new Symbol(*$2, STRING, new int($4), true);
        
      Symbol_table::instance()->add_symbol(symbol);
    }
    ;

//---------------------------------------------------------------------
simple_type:
    T_INT
    { $$ = INT; }
    | T_DOUBLE
    { $$ = DOUBLE; }
    | T_STRING
    { $$ = STRING; }
    ;

//---------------------------------------------------------------------
optional_initializer:
    T_ASSIGN expression
    | empty
    ;

//---------------------------------------------------------------------
object_declaration:
    object_type T_ID T_LPAREN parameter_list_or_empty T_RPAREN
    | object_type T_ID T_LBRACKET expression T_RBRACKET
    ;

//---------------------------------------------------------------------
object_type:
    T_TRIANGLE | T_PIXMAP
    | T_CIRCLE
    | T_RECTANGLE
    | T_TEXTBOX
    ;

//---------------------------------------------------------------------
parameter_list_or_empty :
    parameter_list
    | empty
    ;

//---------------------------------------------------------------------
parameter_list :
    parameter_list T_COMMA parameter
    | parameter
    ;

//---------------------------------------------------------------------
parameter:
    T_ID T_ASSIGN expression
    ;

//---------------------------------------------------------------------
forward_declaration:
    T_FORWARD T_ANIMATION T_ID T_LPAREN animation_parameter T_RPAREN
    ;

//---------------------------------------------------------------------
block_list:
    block_list block
    | empty
    ;

//---------------------------------------------------------------------
block:
    initialization_block
    | animation_block
    | on_block
    ;

//---------------------------------------------------------------------
initialization_block:
    T_INITIALIZATION statement_block
    ;

//---------------------------------------------------------------------
animation_block:
    T_ANIMATION T_ID T_LPAREN check_animation_parameter T_RPAREN T_LBRACE { } statement_list T_RBRACE end_of_statement_block
    ;

//---------------------------------------------------------------------
animation_parameter:
    object_type T_ID
    ;

//---------------------------------------------------------------------
check_animation_parameter:
    T_TRIANGLE T_ID
    | T_PIXMAP T_ID
    | T_CIRCLE T_ID
    | T_RECTANGLE T_ID
    | T_TEXTBOX T_ID
    ;

//---------------------------------------------------------------------
on_block:
    T_ON keystroke statement_block
    ;

//---------------------------------------------------------------------
keystroke:
    T_SPACE
    | T_UPARROW
    | T_DOWNARROW
    | T_LEFTARROW
    | T_RIGHTARROW
    | T_LEFTMOUSE_DOWN
    | T_MIDDLEMOUSE_DOWN
    | T_RIGHTMOUSE_DOWN
    | T_LEFTMOUSE_UP
    | T_MIDDLEMOUSE_UP
    | T_RIGHTMOUSE_UP
    | T_MOUSE_MOVE
    | T_MOUSE_DRAG
    | T_AKEY 
    | T_SKEY 
    | T_DKEY 
    | T_FKEY 
    | T_HKEY 
    | T_JKEY 
    | T_KKEY 
    | T_LKEY 
    | T_WKEY 
    | T_F1
    ;

//---------------------------------------------------------------------
if_block:
    statement_block_creator statement end_of_statement_block
    | statement_block
    ;

//---------------------------------------------------------------------
statement_block:
    T_LBRACE statement_block_creator statement_list T_RBRACE end_of_statement_block
    ;

//---------------------------------------------------------------------
statement_block_creator:
    // this goes to nothing so that you can put an action here in p7
    ;

//---------------------------------------------------------------------
end_of_statement_block:
    // this goes to nothing so that you can put an action here in p7
    ;

//---------------------------------------------------------------------
statement_list:
    statement_list statement
    | empty
    ;

//---------------------------------------------------------------------
statement:
    if_statement
    | for_statement
    | assign_statement T_SEMIC
    | print_statement T_SEMIC
    | exit_statement T_SEMIC
    ;

//---------------------------------------------------------------------
if_statement:
    T_IF T_LPAREN expression T_RPAREN if_block %prec IF_NO_ELSE
    | T_IF T_LPAREN expression T_RPAREN if_block T_ELSE if_block
    ;

//---------------------------------------------------------------------
for_statement:
    T_FOR T_LPAREN statement_block_creator assign_statement end_of_statement_block T_SEMIC expression T_SEMIC statement_block_creator assign_statement end_of_statement_block T_RPAREN statement_block
    ;

//---------------------------------------------------------------------
print_statement:
    T_PRINT T_LPAREN expression T_RPAREN
    ;

//---------------------------------------------------------------------
exit_statement:
    T_EXIT T_LPAREN expression T_RPAREN
    ;

//---------------------------------------------------------------------
assign_statement:
    variable T_ASSIGN expression
    | variable T_PLUS_ASSIGN expression
    | variable T_MINUS_ASSIGN expression
    ;

//---------------------------------------------------------------------
variable:
    T_ID
    | T_ID T_LBRACKET expression T_RBRACKET
    | T_ID T_PERIOD T_ID
    | T_ID T_LBRACKET expression T_RBRACKET T_PERIOD T_ID
    ;

//---------------------------------------------------------------------
expression:
    primary_expression
    | expression T_OR expression
    | expression T_AND expression
    | expression T_LESS_EQUAL expression
    | expression T_GREATER_EQUAL  expression
    | expression T_LESS expression 
    | expression T_GREATER  expression
    | expression T_EQUAL expression
    | expression T_NOT_EQUAL expression
    | expression T_PLUS expression 
    | expression T_MINUS expression
    | expression T_ASTERISK expression
    | expression T_DIVIDE expression
    | expression T_MOD expression
    | T_MINUS  expression %prec UNARY_OPS
    | T_NOT  expression %prec UNARY_OPS
    | math_operator T_LPAREN expression T_RPAREN
    | variable geometric_operator variable
    ;

//---------------------------------------------------------------------
primary_expression:
    T_LPAREN  expression T_RPAREN
    | variable
    | T_INT_CONSTANT
    | T_TRUE
    | T_FALSE
    | T_DOUBLE_CONSTANT
    | T_STRING_CONSTANT
    ;

//---------------------------------------------------------------------
geometric_operator:
    T_TOUCHES
    | T_NEAR
    ;

//---------------------------------------------------------------------
math_operator:
    T_SIN
    | T_COS
    | T_TAN
    | T_ASIN
    | T_ACOS
    | T_ATAN
    | T_SQRT
    | T_ABS
    | T_FLOOR
    | T_RANDOM
    ;

//---------------------------------------------------------------------
empty:
    // empty goes to nothing so that you can use empty in productions
    // when you want a production to go to nothing
    ;
