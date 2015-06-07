%{
#include <stdlib.h>
#include <stdio.h>
int yylex(void);
#define YYERROR_VERBOSE  1
%}
%token INT INPUT FUNCNAME
%left '+' '-'
%left '*' '/'
%%

program:
program statement
|
;

statement:
     expr
;
expr:
INT {  ;  }
| INPUT { ; }
| expr '+' expr {  ; }
| expr '-' expr {  ; }
| '(' expr ')'  {  ;     }
| FUNCNAME '(' expr ')'  { ; }
;

%%


