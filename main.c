#include <stdio.h>

int main(void) {

yyparse();

return 0;

}

void yyerror(const char *msg){
   printf("%s\n", msg);
}
