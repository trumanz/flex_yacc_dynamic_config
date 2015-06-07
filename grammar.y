%{
#include <stdlib.h>
#include <stdio.h>
int yylex(void);
void yyerror(const char *msg);
#define YYERROR_VERBOSE  1
%}
%token INT INPUT FUNCNAME
%left '+' '-'
%left '*' '/'
%union
{
   int intval;
   char *strval;
  // struct rval_expr* rval_expr;
}
%token<intval> INTVAL
%token<strval> FUNCNAMEVAL
%%

program:
program statement
|
;

statement:
     expr
;
expr:
INTVAL { printf("int value: %d\n", $1);}
| INPUT { ; }
| expr '+' expr {  ; }
| expr '-' expr {  ; }
| '(' expr ')'  {  ;     }
| FUNCNAMEVAL '(' expr ')'  {  printf("Function name: %s\n", $1); }
;

%%


