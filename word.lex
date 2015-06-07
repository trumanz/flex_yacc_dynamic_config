%{
#include <stdio.h>
#include <string.h>
#include "Expr.h"
#include "grammar.tab.h"
int count = 0;
%}
LETTER  [a-zA-Z]
DIGIT	[0-9]
DECNUMBER       0|([1-9]{DIGIT}*)
FUNCNAME {LETTER}+
%%
{DECNUMBER} { yylval.intval = atoi(yytext);  return  INTVAL; }
{FUNCNAME}  { yylval.strval = strdup(yytext); return FUNCNAMEVAL;}
[\+\-\(\)]  { return yytext[0];}
"$input"    { return INPUT;}
%%

int yywrap()
{
  return 1;
}

