#include <stdio.h>
void yyparse();
int main(void) {
yyparse();
return 0;
}

void yyerror(const char *msg){
   printf("%s\n", msg);
}
