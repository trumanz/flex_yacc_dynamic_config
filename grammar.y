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
%token INT XINT INPUT FUNCNAME

%left '<' '>'
%left '+' '-'
%left '*' '/'
%union
{
   int intval;
   char *strval;
   Expr *expr;
   IntExpr *intexpr;
   BoolExpr *boolexpr;
}
%token<intval> INTVAL
%token<strval> FUNCNAMEVAL
%type <expr> expr
%type <intexpr> intexpr
%type <boolexpr> boolexpr
%%


statement:
    statement expr { Executor::Add($2); } 
    |
;

expr:  boolexpr { $$ = $1;}
      | intexpr  { $$ = $1;}
;

boolexpr: intexpr '<' intexpr { $$ = new IntLessExpr($1, $3); }
 | intexpr '>' intexpr { $$ = new IntThanExpr($1, $3); }
;

intexpr: INTVAL { $$= new NumIntExpr($1);}
  | INPUT { $$ = new NumIntExpr(GetInput());}
  | intexpr '+' intexpr {  $$ = new IntAddExpr($1, $3); }
  | intexpr '-' intexpr {  $$ = new IntSubExpr($1, $3); }
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
   | XINT '(' boolexpr ')' {
         $$ = new IntFromBoolExpr($3);
     }
;



%%


