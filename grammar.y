%{
#include <stdlib.h>
#include <stdio.h>
#include "Expr.h"
int yylex(void);
void yyerror(const char *msg);
static void* mk_inval(int val);
#define YYERROR_VERBOSE  1
%}
%token INT INPUT FUNCNAME
%left '+' '-'
%left '*' '/'
%union
{
   int intval;
   char *strval;
   Expr *expr;
}
%token<intval> INTVAL
%token<strval> FUNCNAMEVAL
%type <expr> expr
%%


statement:
    statement expr
    |
;
expr: INTVAL { $$=0;}
  | INPUT { ; }
  | expr '+' expr {  ; }
  | expr '-' expr {  ; }
  | '(' expr ')'  {  ;     }
  | FUNCNAMEVAL '(' expr ')'  {  printf("Function name: %s\n", $1); }
;

%%


