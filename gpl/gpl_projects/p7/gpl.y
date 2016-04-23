%{
#include "error.h"
#include "parser.h"
#include "symbol_table.h"
#include "gpl_type.h"
#include "variable.h"
#include "rectangle.h"
#include "triangle.h"
#include "circle.h"
#include "pixmap.h"
#include "textbox.h"
#include "event_manager.h"
#include "animation_block.h"
#include "if_stmt.h"
#include "print_stmt.h"
#include "assignment_stmt.h"
#include "exit_stmt.h"
#include "for_stmt.h"

#include <iostream>
#include <string>
#include <sstream>
#include <stack>
using namespace std;

extern int yylex();
extern int yyerror(const char *);
Game_object* cur_obj;
string cur_obj_name;
stack<Statement_block*> global_stack;

%} 

%union {
  int            union_int;
  double         union_double;
  std::string   *union_string;
  Gpl_type       union_gpl_type;
  Window::Keystroke union_keystroke;
  Expression    *union_expression;
  Variable      *union_variable;
  Statement_block *union_statement_block;
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
%token <union_int> T_EXIT   "exit"
%token <union_int> T_PRINT  "print"
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
%token <union_string> T_ID                "identifier"
%token <union_string> T_ERROR             "error"

%nonassoc   IF_NO_ELSE
%nonassoc   T_ELSE
%left       T_OR
%left       T_AND
%left       T_NOT_EQUAL T_EQUAL
%left       T_GREATER   T_GREATER_EQUAL     T_LESS  T_LESS_EQUAL
%left       T_PLUS      T_MINUS
%left       T_ASTERISK  T_DIVIDE    T_MOD
%nonassoc   UNARY_OPS

%type <union_int> object_type
%type <union_keystroke> keystroke
%type <union_string> animation_parameter
%type <union_gpl_type> simple_type
%type <union_expression> math_operator
%type <union_expression> expression
%type <union_expression> primary_expression
%type <union_expression> optional_initializer
%type <union_variable>   variable
%type <union_statement_block> statement_block
%type <union_statement_block> statement_block_creator
%type <union_statement_block> if_block

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
        if ($3 && ($3->return_type <= $1)) {
            symbol = new Symbol(*$2, $1, $3->evaluate_to_type($1)->value);
        }
        else { // no initializer
            if ($3 && ($3->return_type > $1))
                Error::error(Error::INVALID_TYPE_FOR_INITIAL_VALUE, *$2);
            switch ($1) {
                case INT: symbol = new Symbol(*$2, $1, new int(0)); break;
                case DOUBLE: symbol = new Symbol(*$2, $1, new double(0)); break;
                case STRING: symbol = new Symbol(*$2, $1, new string()); break;
                case GAME_OBJECT: assert(false); break;
                default: assert(false); break;
            }
        }
        if (!(Symbol_table::instance()->add_symbol(symbol)))
            Error::error(Error::PREVIOUSLY_DECLARED_VARIABLE, symbol->name);
    }
    | simple_type  T_ID  T_LBRACKET expression T_RBRACKET
    {
        Expression *index_expression = $4;
        switch (index_expression->return_type) {
            case DOUBLE:
            case STRING:
                Error::error(Error::INVALID_ARRAY_SIZE, *$2, *((string*)(index_expression->evaluate_to_type(STRING)->value)));
                break;
            case ANIMATION_BLOCK:
                assert(false);
                // implement in future
            case INT: {
                if (*((int*)(index_expression->evaluate_to_type(INT)->value)) < 1) {
                    Error::error(Error::INVALID_ARRAY_SIZE, *$2, *((string*)(index_expression->evaluate_to_type(STRING)->value)));
                    break;
                }
                // create new array symbol
                Symbol *symbol = new Symbol(*$2, $1, *((int*)($4->evaluate_to_type(INT)->value)));
                if (!(Symbol_table::instance()->add_symbol(symbol)))
                    Error::error(Error::PREVIOUSLY_DECLARED_VARIABLE, symbol->name);
                break;
            }
            default: cerr << "Error while making sure index is of type INT (1)\n"; break;
        }
    }
    ;

//---------------------------------------------------------------------
simple_type:
    T_INT      { $$ = INT; }
    | T_DOUBLE { $$ = DOUBLE; }
    | T_STRING { $$ = STRING; }
    ;

//---------------------------------------------------------------------
optional_initializer:
    T_ASSIGN expression { $$ = $2; }
    | empty             { $$ = NULL; }
    ;

//---------------------------------------------------------------------
object_declaration:
    object_type T_ID {
        switch($1) {
            case T_RECTANGLE: cur_obj = new Rectangle(); break;
            case T_TRIANGLE: cur_obj = new Triangle(); break;
            case T_CIRCLE: cur_obj = new Circle(); break;
            case T_PIXMAP: cur_obj = new Pixmap(); break;
            case T_TEXTBOX: cur_obj = new Textbox(); break;
            default: cerr << "Error in gpl.y initializing cur_obj\n";
        }
        cur_obj_name = *$2;
    } T_LPAREN parameter_list_or_empty T_RPAREN {
        Symbol* symbol = new Symbol(*$2, GAME_OBJECT, cur_obj);
        Symbol_table::instance()->add_symbol(symbol);
    }
    | object_type T_ID T_LBRACKET expression T_RBRACKET {
        switch($1) {
            case T_RECTANGLE: cur_obj = new Rectangle(); break;
            case T_TRIANGLE: cur_obj = new Triangle(); break;
            case T_CIRCLE: cur_obj = new Circle(); break;
            case T_PIXMAP: cur_obj = new Pixmap(); break;
            case T_TEXTBOX: cur_obj = new Textbox(); break;
            default: cerr << "Error in gpl.y initializing cur_obj\n";
        }
        cur_obj->never_draw();
        cur_obj->never_animate();
        Symbol* symbol = new Symbol(*$2, cur_obj, *((int*)($4->evaluate_to_type(INT)->value)));
        Symbol_table::instance()->add_symbol(symbol);
    }
    ;

//---------------------------------------------------------------------
object_type:
    T_TRIANGLE { $$ = T_TRIANGLE; }
    | T_PIXMAP { $$ = T_PIXMAP; }
    | T_CIRCLE { $$ = T_CIRCLE; }
    | T_RECTANGLE { $$ = T_RECTANGLE; }
    | T_TEXTBOX { $$ = T_TEXTBOX; }
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
    T_ID T_ASSIGN expression {
        if (*$1 == "animation_block") {
            Animation_block *cur_block = ((Animation_block*)($3->variable->symbol->value));
            if (cur_obj->type() != ((Game_object*)(cur_block->get_parameter_symbol()->value))->type())
                Error::error(Error::TYPE_MISMATCH_BETWEEN_ANIMATION_BLOCK_AND_OBJECT, cur_obj_name, $3->variable->symbol->name);
            cur_obj->set_member_variable(*$1, cur_block);
        }
        else {
            Gpl_type return_type;
            Status status;
            status = cur_obj->get_member_variable_type(*$1, return_type);
            if (status == MEMBER_NOT_DECLARED)
                Error::error(Error::UNKNOWN_CONSTRUCTOR_PARAMETER, cur_obj->type(), *$1);
            else if (return_type < $3->return_type)
                Error::error(Error::INCORRECT_CONSTRUCTOR_PARAMETER_TYPE, cur_obj_name, *$1);
            else {
                switch (return_type) {
                    case INT:
                        status = cur_obj->set_member_variable(*$1, *((int*)($3->evaluate_to_type(INT)->value)));
                        break;
                    case DOUBLE:
                        status = cur_obj->set_member_variable(*$1, *((double*)($3->evaluate_to_type(DOUBLE)->value)));
                        break;
                    case STRING:
                        status = cur_obj->set_member_variable(*$1, *((string*)($3->evaluate_to_type(STRING)->value)));
                        break;
                    default: break;
                }
                switch (status) {
                    case MEMBER_NOT_DECLARED:
                        Error::error(Error::UNKNOWN_CONSTRUCTOR_PARAMETER, cur_obj->type(), *$1);
                        break;
                    case MEMBER_NOT_OF_GIVEN_TYPE:
                        Error::error(Error::INCORRECT_CONSTRUCTOR_PARAMETER_TYPE, cur_obj_name, *$1);
                        break;
                    default: break;
                }
            }
        }
    }
    ;

//---------------------------------------------------------------------
forward_declaration:
    T_FORWARD T_ANIMATION T_ID T_LPAREN animation_parameter T_RPAREN {
        Symbol* symbol = new Symbol(*$3,
                                    ANIMATION_BLOCK,
                                    new Animation_block(Symbol_table::instance()->get_symbol(*$5), *$3));
        if (!(Symbol_table::instance()->add_symbol(symbol)))
            Error::error(Error::PREVIOUSLY_DECLARED_VARIABLE, *$3);
    }
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
    object_type T_ID {
        if (Symbol_table::instance()->get_symbol(*$2))
            Error::error(Error::ANIMATION_PARAMETER_NAME_NOT_UNIQUE, *$2);
        switch($1) {
            case T_RECTANGLE: cur_obj = new Rectangle(); break;
            case T_TRIANGLE: cur_obj = new Triangle(); break;
            case T_CIRCLE: cur_obj = new Circle(); break;
            case T_PIXMAP: cur_obj = new Pixmap(); break;
            case T_TEXTBOX: cur_obj = new Textbox(); break;
            default: cerr << "Error in gpl.y initializing cur_obj (2)\n";
        }
        cur_obj->never_animate();
        cur_obj->never_draw();
        Symbol* symbol = new Symbol(*$2, GAME_OBJECT, cur_obj);
        Symbol_table::instance()->add_symbol(symbol);
        $$ = $2;
    }
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
    T_ON keystroke statement_block {
        Event_manager::instance()->register_event($2, $3);
    }
    ;

//---------------------------------------------------------------------
keystroke:
    T_SPACE { $$ = Window::SPACE; }
    | T_UPARROW { $$ = Window::UPARROW; }
    | T_DOWNARROW { $$ = Window::DOWNARROW; }
    | T_LEFTARROW { $$ = Window::LEFTARROW; }
    | T_RIGHTARROW { $$ = Window::RIGHTARROW; }
    | T_LEFTMOUSE_DOWN { $$ = Window::LEFTMOUSE_DOWN; }
    | T_MIDDLEMOUSE_DOWN { $$ = Window::MIDDLEMOUSE_DOWN; }
    | T_RIGHTMOUSE_DOWN { $$ = Window::RIGHTMOUSE_DOWN; }
    | T_LEFTMOUSE_UP { $$ = Window::LEFTMOUSE_UP; }
    | T_MIDDLEMOUSE_UP { $$ = Window::MIDDLEMOUSE_UP; }
    | T_RIGHTMOUSE_UP { $$ = Window::RIGHTMOUSE_UP; }
    | T_MOUSE_MOVE { $$ = Window::MOUSE_MOVE; }
    | T_MOUSE_DRAG { $$ = Window::MOUSE_DRAG; }
    | T_AKEY { $$ = Window::AKEY; }
    | T_SKEY { $$ = Window::SKEY; }
    | T_DKEY { $$ = Window::DKEY; }
    | T_FKEY { $$ = Window::FKEY; }
    | T_HKEY { $$ = Window::HKEY; }
    | T_JKEY { $$ = Window::JKEY; }
    | T_KKEY { $$ = Window::KKEY; }
    | T_LKEY { $$ = Window::LKEY; }
    | T_WKEY { $$ = Window::WKEY; }
    | T_F1 { $$ = Window::F1; }
    ;

//---------------------------------------------------------------------
if_block:
    statement_block_creator statement end_of_statement_block
    {
        $$ = $1; 
    }
    | statement_block
    ;

//---------------------------------------------------------------------
statement_block:
    T_LBRACE statement_block_creator statement_list T_RBRACE end_of_statement_block
    {
        $$ = $2;
    }
    ;

//---------------------------------------------------------------------
statement_block_creator:
    {
        Statement_block* stmt = new Statement_block();
        global_stack.push(stmt);
        $$ = stmt;
    }
    ;

//---------------------------------------------------------------------
end_of_statement_block:
    {
        global_stack.pop();
    }
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
    {
        if ($3->return_type != INT)
            Error::error(Error::INVALID_TYPE_FOR_IF_STMT_EXPRESSION);
        If_stmt* stmt = new If_stmt($3, $5);
        global_stack.top()->statements.push_back(stmt);
    }
    | T_IF T_LPAREN expression T_RPAREN if_block T_ELSE if_block
    {
        if ($3->return_type != INT)
            Error::error(Error::INVALID_TYPE_FOR_IF_STMT_EXPRESSION);
        If_stmt* stmt = new If_stmt($3, $5, $7);
        global_stack.top()->statements.push_back(stmt);
    }
    ;

//---------------------------------------------------------------------
for_statement:
    T_FOR T_LPAREN statement_block_creator assign_statement end_of_statement_block T_SEMIC expression T_SEMIC statement_block_creator assign_statement end_of_statement_block T_RPAREN statement_block
    {
        if ($7->return_type != INT)
            Error::error(Error::INVALID_TYPE_FOR_FOR_STMT_EXPRESSION);
        For_stmt* stmt = new For_stmt($3, $7, $9, $13);
        global_stack.top()->statements.push_back(stmt);
    }
    ;

//---------------------------------------------------------------------
print_statement:
    T_PRINT T_LPAREN expression T_RPAREN {
        if ($3->return_type == GAME_OBJECT)
            Error::error(Error::INVALID_TYPE_FOR_PRINT_STMT_EXPRESSION);
        Print_stmt* stmt = new Print_stmt($1, $3);
        global_stack.top()->statements.push_back(stmt);
    }
    ;

//---------------------------------------------------------------------
exit_statement:
    T_EXIT T_LPAREN expression T_RPAREN
    {
        if ($3->return_type != INT) {
            string s;
            switch ($3->return_type) {
                case 2: s = "double"; break;
                case 4: s = "string"; break;
                default: assert(0); break;
            }
            Error::error(Error::EXIT_STATUS_MUST_BE_AN_INTEGER, s);
        }
        Exit_stmt* stmt = new Exit_stmt($1, $3);
        global_stack.top()->statements.push_back(stmt);
    }
    ;

//---------------------------------------------------------------------
assign_statement:
    variable T_ASSIGN expression
    {
        if ($1->return_type < $3->return_type) {
            stringstream ss;
            ss << $1->return_type;
            string s1 = ss.str();
            ss.str("");
            ss << $3->return_type;
            string s2 = ss.str();
            Error::error(Error::ASSIGNMENT_TYPE_ERROR, s1, s2);
        }
        else if ($1->return_type == GAME_OBJECT) {
            string s1, s2;
            s1 = $1->symbol->name;
            Error::error(Error::INVALID_LHS_OF_ASSIGNMENT, s1, "game_object");
        }
        Assignment_stmt* stmt = new Assignment_stmt($1, ASSIGN, $3);
        global_stack.top()->statements.push_back(stmt);
    }
    | variable T_PLUS_ASSIGN expression
    {
        if ($1->return_type == GAME_OBJECT)
            Error::error(Error::INVALID_LHS_OF_PLUS_ASSIGNMENT, $1->symbol->name, "game_object");

        if ($1->return_type < $3->return_type) {
            stringstream ss;
            ss << $1->return_type;
            string s1 = ss.str();
            ss.str("");
            ss << $3->return_type;
            string s2 = ss.str();
            Error::error(Error::PLUS_ASSIGNMENT_TYPE_ERROR, s1, s2);
        }
        Assignment_stmt* stmt = new Assignment_stmt($1, PLUS_ASSIGN, $3);
        global_stack.top()->statements.push_back(stmt);
    }
    | variable T_MINUS_ASSIGN expression
    {
        if ($1->return_type < $3->return_type) {
            stringstream ss;
            ss << $1->return_type;
            string s1 = ss.str();
            ss.str("");
            ss << $3->return_type;
            string s2 = ss.str();
            Error::error(Error::MINUS_ASSIGNMENT_TYPE_ERROR, s1, s2);
        } else if ($1->return_type > 2) {
            stringstream ss;
            ss << $1->symbol->name;
            string s1 = ss.str();
            ss.str("");
            ss << $1->return_type;
            string s2 = ss.str();
            Error::error(Error::INVALID_LHS_OF_MINUS_ASSIGNMENT, s1, s2);
        }
        Assignment_stmt* stmt = new Assignment_stmt($1, MINUS_ASSIGN, $3);
        global_stack.top()->statements.push_back(stmt);
    }
    ;

//---------------------------------------------------------------------
variable:
    T_ID
    { 
        if (Symbol_table::instance()->get_symbol(*$1)) {
            $$ = new Variable(*$1); }
        else {
            Error::error(Error::UNDECLARED_VARIABLE, *$1);
            $$ = NULL;
        }
    }
    | T_ID T_LBRACKET expression T_RBRACKET
    {
        switch ($3->return_type) {
            case DOUBLE:
                Error::error(Error::ARRAY_INDEX_MUST_BE_AN_INTEGER, *$1, "A double expression");
                $$ = new Variable("DUMMY_VARIABLE");
                break;
            case STRING:
                Error::error(Error::ARRAY_INDEX_MUST_BE_AN_INTEGER, *$1, "A string expression");
                $$ = new Variable("DUMMY_VARIABLE");
                break;
            case ANIMATION_BLOCK:
                Error::error(Error::ARRAY_INDEX_MUST_BE_AN_INTEGER, *$1, "A animation_block expression");
                $$ = new Variable("DUMMY_VARIABLE");
                break;
            case INT: {
                if (!((Symbol_table::instance()->get_symbol(*$1))->array_size))
                    Error::error(Error::VARIABLE_NOT_AN_ARRAY, *$1);
                $$ = new Variable(*$1, $3);
                break; }
            default: cerr << "Error while making sure index is of type INT (2)\n"; break;
        }
    }
    | T_ID T_PERIOD T_ID
    {
        Symbol* sym = Symbol_table::instance()->get_symbol(*$1);
        if (sym) {
            if (sym->type != GAME_OBJECT) {
                Error::error(Error::LHS_OF_PERIOD_MUST_BE_OBJECT, *$1);
                $$ = NULL;
            }
            else {
                Gpl_type type;
                if (((Game_object*)(sym->value))->get_member_variable_type(*$3, type) == MEMBER_NOT_DECLARED) {
                    Error::error(Error::UNDECLARED_MEMBER, *$1, *$3);
                    $$ = NULL;
                }
                else $$ = new Variable(*$1, *$3);
            }
        }
        else {
            Error::error(Error::UNDECLARED_VARIABLE, *$1);
            $$ = new Variable("DUMMY_VARIABLE");
        }
    }
    | T_ID T_LBRACKET expression T_RBRACKET T_PERIOD T_ID
    {
        Symbol *sym = Symbol_table::instance()->get_symbol(*$1);
        if (sym) {
            if (sym->type != GAME_OBJECT){
                Error::error(Error::LHS_OF_PERIOD_MUST_BE_OBJECT, *$1);
                $$ = NULL;
            }
            else $$ = new Variable(*$1, *$6, $3);
        } else {
            Error::error(Error::UNDECLARED_VARIABLE, *$1);
            $$ = new Variable("DUMMY_VARIABLE");
        }
    }
    ;

//---------------------------------------------------------------------
expression:
    primary_expression
    { $$ = $1; }
    | expression T_OR expression
    {
        if ($1->return_type == STRING) {
            Error::error(Error::INVALID_LEFT_OPERAND_TYPE, "||");
            $1 = new Expression(new int(0), INT, NULL, NULL);
        }
        // just if would be better...
        else if ($3->return_type == STRING) {
            Error::error(Error::INVALID_RIGHT_OPERAND_TYPE, "||");
            $3 = new Expression(new int(0), INT, NULL, NULL);
        }
        $$ = new Expression(OR, INT, $1, $3);
    }
    | expression T_AND expression
    {
        if ($1->return_type == STRING) {
            Error::error(Error::INVALID_LEFT_OPERAND_TYPE, "&&");
            $1 = new Expression(new int(0), INT, NULL, NULL);
        }
        else if ($3->return_type == STRING) {
            Error::error(Error::INVALID_RIGHT_OPERAND_TYPE, "&&");
            $3 = new Expression(new int(0), INT, NULL, NULL);
        }
        $$ = new Expression(AND, INT, $1, $3);
    }
    | expression T_LESS_EQUAL expression
    { $$ = new Expression(LESS_THAN_EQUAL, INT, $1, $3); }
    | expression T_GREATER_EQUAL  expression
    { $$ = new Expression(GREATER_THAN_EQUAL, INT, $1, $3); }
    | expression T_LESS expression 
    { $$ = new Expression(LESS_THAN, INT, $1, $3); }
    | expression T_GREATER expression
    { $$ = new Expression(GREATER_THAN, INT, $1, $3); }
    | expression T_EQUAL expression
    { $$ = new Expression(EQUAL, INT, $1, $3); }
    | expression T_NOT_EQUAL expression
    { $$ = new Expression(NOT_EQUAL, INT, $1, $3); }
    | expression T_PLUS expression 
    { $$ = new Expression(PLUS, (($1->return_type > $3->return_type)?$1->return_type:$3->return_type), $1, $3); }
    | expression T_MINUS expression
    { 
        if ($1->return_type == STRING) {
            Error::error(Error::INVALID_LEFT_OPERAND_TYPE, "-");
            $1 = new Expression(new int(0), INT, NULL, NULL);
        }
        else if ($3->return_type == STRING) {
            Error::error(Error::INVALID_RIGHT_OPERAND_TYPE, "-");
            $3 = new Expression(new int(0), INT, NULL, NULL);
        }
        $$ = new Expression(MINUS, (($1->return_type > $3->return_type)?$1->return_type:$3->return_type), $1, $3);
    }
    | expression T_ASTERISK expression
    {
        if ($1->return_type == STRING) {
            Error::error(Error::INVALID_LEFT_OPERAND_TYPE, "*");
            $1 = new Expression(new int(0), INT, NULL, NULL);
        }
        else if ($3->return_type == STRING) {
            Error::error(Error::INVALID_RIGHT_OPERAND_TYPE, "*");
            $3 = new Expression(new int(0), INT, NULL, NULL);
        }
        $$ = new Expression(MULTIPLY, (($1->return_type > $3->return_type)?$1->return_type:$3->return_type), $1, $3);
    }
    | expression T_DIVIDE expression
    {
        if (*((double*)($3->evaluate_to_type(DOUBLE)->value)) == 0) {
            Error::error(Error::DIVIDE_BY_ZERO_AT_PARSE_TIME);
            $1 = new Expression(new int(0), INT, NULL, NULL);
            $3 = new Expression(new int(1), INT, NULL, NULL);
        }
        $$ = new Expression(DIVIDE, (($1->return_type > $3->return_type)?$1->return_type:$3->return_type), $1, $3); }
    | expression T_MOD expression
    {
        if ($1->return_type != INT) {
            Error::error(Error::INVALID_LEFT_OPERAND_TYPE, "mod");
            $1 = new Expression(new int(1), INT, NULL, NULL);
        }
        else if ($3->return_type != INT) {
            Error::error(Error::INVALID_RIGHT_OPERAND_TYPE, "mod");
            $3 = new Expression(new int(1), INT, NULL, NULL);
        }
        if (*((int*)($3->evaluate_to_type(INT)->value)) == 0) {
            Error::error(Error::MOD_BY_ZERO_AT_PARSE_TIME);
            $1 = new Expression(new int(0), INT, NULL, NULL);
            $3 = new Expression(new int(1), INT, NULL, NULL);
        }
        $$ = new Expression(MOD, (($1->return_type > $3->return_type)?$1->return_type:$3->return_type), $1, $3);
    }
    | T_MINUS  expression %prec UNARY_OPS
    { $$ = new Expression(UNARY_MINUS, $2->return_type, $2, NULL); }
    | T_NOT  expression %prec UNARY_OPS
    {
        if ($2->return_type == STRING) {
            Error::error(Error::INVALID_RIGHT_OPERAND_TYPE, "!");
            $2 = new Expression(new int(0), INT, NULL, NULL);
        }
        $$ = new Expression(NOT, INT, $2, NULL);
    }
    | math_operator T_LPAREN expression T_RPAREN
    {
        $1->left = $3;
        if ($3->return_type == STRING) {
            switch ($1->operator_type) {
                case SIN: Error::error(Error::INVALID_RIGHT_OPERAND_TYPE, "sin"); break;
                case COS: Error::error(Error::INVALID_RIGHT_OPERAND_TYPE, "cos"); break;
                case TAN: Error::error(Error::INVALID_RIGHT_OPERAND_TYPE, "tan"); break;
                case ASIN: Error::error(Error::INVALID_RIGHT_OPERAND_TYPE, "asin"); break;
                case ACOS: Error::error(Error::INVALID_RIGHT_OPERAND_TYPE, "acos"); break;
                case ATAN: Error::error(Error::INVALID_RIGHT_OPERAND_TYPE, "atan"); break;
                case SQRT: Error::error(Error::INVALID_RIGHT_OPERAND_TYPE, "sqrt"); break;
                case ABS: Error::error(Error::INVALID_RIGHT_OPERAND_TYPE, "abs"); break;
                case FLOOR: Error::error(Error::INVALID_RIGHT_OPERAND_TYPE, "floor"); break;
                case RANDOM: Error::error(Error::INVALID_RIGHT_OPERAND_TYPE, "random"); break;
                default: break;
            }
            $1->left = new Expression(new int(1), INT, NULL, NULL);
        }
        if ($1->operator_type == ABS) // Can return either int or double based on input
            $1->return_type = $1->left->return_type;
        $$ = $1;
    }
    | variable geometric_operator variable
    { $$ = NULL; }
    ;

//---------------------------------------------------------------------
primary_expression:
    T_LPAREN  expression T_RPAREN
    { $$ = $2; }
    | variable
    {
        if ($1) {
            $$ = new Expression($1);
        }
        else {
            $$ = NULL;
        }
    }
    | T_INT_CONSTANT
    { $$ = new Expression(new int($1), INT, NULL, NULL); }
    | T_TRUE
    { $$ = new Expression(new int(1), INT, NULL, NULL); }
    | T_FALSE
    { $$ = new Expression(new int(0), INT, NULL, NULL); }
    | T_DOUBLE_CONSTANT
    { $$ = new Expression(new double($1), DOUBLE, NULL, NULL); }
    | T_STRING_CONSTANT
    { $$ = new Expression(new string(*$1), STRING, NULL, NULL); }
    ;

//---------------------------------------------------------------------
geometric_operator:
    T_TOUCHES
    | T_NEAR
    ;

//---------------------------------------------------------------------
math_operator:
    T_SIN
    { $$ = new Expression(SIN, DOUBLE, NULL, NULL); }
    | T_COS
    { $$ = new Expression(COS, DOUBLE, NULL, NULL); }
    | T_TAN
    { $$ = new Expression(TAN, DOUBLE, NULL, NULL); }
    | T_ASIN
    { $$ = new Expression(ASIN, DOUBLE, NULL, NULL); }
    | T_ACOS
    { $$ = new Expression(ACOS, DOUBLE, NULL, NULL); }
    | T_ATAN
    { $$ = new Expression(ATAN, DOUBLE, NULL, NULL); }
    | T_SQRT
    { $$ = new Expression(SQRT, DOUBLE, NULL, NULL); }
    | T_ABS
    { $$ = new Expression(ABS, INT, NULL, NULL); }
    | T_FLOOR
    { $$ = new Expression(FLOOR, INT, NULL, NULL); }
    | T_RANDOM
    { $$ = new Expression(RANDOM, INT, NULL, NULL); }
    ;

//---------------------------------------------------------------------
empty:
    // empty goes to nothing so that you can use empty in productions
    // when you want a production to go to nothing
    ;
