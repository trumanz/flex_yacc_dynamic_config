%{
#include <stdio.h>
#include "grammar.tab.h"
int count = 0;
%}
LETTER  [a-zA-Z]
DIGIT	[0-9]
DECNUMBER       0|([1-9]{DIGIT}*)
FUNCNAME {LETTER}+
%%
{DECNUMBER}  { printf("\nnumber\n"); return  INT; }
{FUNCNAME}  { printf("\nfunction name %s\n", yytext);  return FUNCNAME;}
[\+\-\(\)]  { printf("\nmath symobl %c\n" , yytext[0]); return yytext[0];}
"$input"    { printf("$input\n"); return INPUT;}
%%

int yywrap()
{
  return 1;
}

