%{
#include "error.h"
#include "parser.h"
#include "symbol_table.h"
#include "gpl_type.h"
#include "variable.h"
#include <iostream>
#include <string>

//ask about this!
#define DOMINANT_TYPE (($1->return_type > $3->return_type)?$1->return_type:$3->return_type)

extern int yylex();
extern int yyerror(const char *);

using namespace std;
%} 

%union {
  int            union_int;
  double         union_double;
  std::string   *union_string;
  Gpl_type       union_gpl_type;
  Expression    *union_expression;
  Variable      *union_variable;
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
%left       T_OR
%left       T_AND
%left       T_NOT_EQUAL T_EQUAL
%left       T_GREATER   T_GREATER_EQUAL     T_LESS  T_LESS_EQUAL
%left       T_PLUS      T_MINUS
%left       T_ASTERISK  T_DIVIDE    T_MOD
%nonassoc   UNARY_OPS

%type <union_gpl_type> simple_type
%type <union_expression> math_operator
%type <union_expression> expression
%type <union_expression> primary_expression
%type <union_expression> optional_initializer
%type <union_variable>   variable

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
            symbol = new Symbol(*$2, $1, $3->evaluate_to_type($1)->value, false);
        }
        else { // no initializer
            if ($3 && ($3->return_type > $1))
                Error::error(Error::INVALID_TYPE_FOR_INITIAL_VALUE, *$2);
            switch ($1) {
                case INT: symbol = new Symbol(*$2, $1, new int(0), false); break;
                case DOUBLE: symbol = new Symbol(*$2, $1, new double(0), false); break;
                case STRING: symbol = new Symbol(*$2, $1, new string(), false); break;
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
                // implement in future
            case INT: {
                if (*((int*)(index_expression->evaluate_to_type(INT)->value)) < 1) {
                    Error::error(Error::INVALID_ARRAY_SIZE, *$2, *((string*)(index_expression->evaluate_to_type(STRING)->value)));
                    break;
                }
                // create new array symbol
                Symbol *symbol = new Symbol(*$2, $1, $4->evaluate_to_type(INT)->value, true);
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
    { $$ = $2; }
    | empty
    { $$ = NULL; }
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
    { 
        if (Symbol_table::instance()->get_symbol(*$1))
            $$ = new Variable(*$1);
        else {
            Error::error(Error::UNDECLARED_VARIABLE, *$1);
            $$ = new Variable("DUMMY_VARIABLE");
        }
    }
    | T_ID T_LBRACKET expression T_RBRACKET
    {
        Expression *index_expression = $3;
        switch (index_expression->return_type) {
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
                vector<void*>* vec = (vector<void*>*)(Symbol_table::instance()->get_symbol(*$1)->value);
                int desired_index = *((int*)(index_expression->evaluate_to_type(INT)->value));
                if (desired_index > vec->size()-1) {
                    Error::error(Error::ARRAY_INDEX_OUT_OF_BOUNDS, *$1, std::to_string(desired_index));
                    $$ = new Variable("DUMMY_VARIABLE");
                }
                else { $$ = new Variable(*$1, index_expression); }
                break;
            }
            default: cerr << "Error while making sure index is of type INT (2)\n"; break;
        }
    }
    | T_ID T_PERIOD T_ID
    | T_ID T_LBRACKET expression T_RBRACKET T_PERIOD T_ID
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
    ;

//---------------------------------------------------------------------
primary_expression:
    T_LPAREN  expression T_RPAREN
    { $$ = $2; }
    | variable
    { $$ = new Expression($1); }
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
