%{
#include <stdio.h>
int count = 0;
%}
LETTER  [a-zA-Z]
DIGIT	[0-9]
DECNUMBER       0|([1-9]{DIGIT}*)
FUNCNAME {LETTER}+
%%
{DECNUMBER}  { printf("\nnumber\n"); }
{FUNCNAME}  { printf("\nfunction name %s\n", yytext); }
[\+\-\(\)]  { printf("\nmath symobl %c\n" , yytext[0]); }
"$input"    { printf("$input\n"); }
%%

int main()
{
   yylex();
   printf("count = %d\n", count);
}

int yywrap()
{
  return 1;
}

