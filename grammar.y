%{
#include <stdlib.h>
#include <stdio.h>
#include "Expr.h"
#include "ModuleLoader.h"
#include "Executor.h"
int yylex(void);
void yyerror(const char *msg);
static void* mk_inval(int val);
int GetInput();
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
    statement expr { Executor::Add($2); } 
    |
;
expr: INTVAL { $$= new IntExpr($1);}
  | INPUT { $$ = new IntExpr(GetInput());}
  | expr '+' expr {  $$ = new AddExpr($1, $3); }
  | expr '-' expr {  $$ = new SubExpr($1, $3); }
  | '(' expr ')'  {  $$ = $2; }
  | FUNCNAMEVAL '(' expr ')' { 
         api_function* f =  ModuleLoader::SearchApi($1);
         if(f == NULL) { 
               char buf[100];
               snprintf(buf, sizeof(buf), "can not find function %s\n", $1);
               buf[sizeof(buf) -1 ] = '\0';
               $$ = NULL;
               yyerror(buf);
               YYABORT;
         }
         else  $$ = new FuncExpr(f, $3);
      }
;

%%


