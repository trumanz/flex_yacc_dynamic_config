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

%left '<' '>'
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
%type <expr> intexpr
%type <expr> boolexpr
%type <expr> expr
%%


statement:
    statement expr { Executor::Add($2); } 
    |
;

expr:  boolexpr | intexpr;

boolexpr: intexpr '<' intexpr { $$ = new LessExpr($1, $3); }
 | intexpr '>' intexpr { $$ = new ThanExpr($1, $3); }
;

intexpr: INTVAL { $$= new IntExpr($1);}
  | INPUT { $$ = new IntExpr(GetInput());}
  | intexpr '+' intexpr {  $$ = new AddExpr($1, $3); }
  | intexpr '-' intexpr {  $$ = new SubExpr($1, $3); }
  | '(' intexpr ')'  {  $$ = $2; }
  | FUNCNAMEVAL '(' intexpr ')' { 
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


