#include <stdio.h>
#include "Executor.h"
#include <list>

std::list<Expr*> Executor::exprs;

int yyparse();
int GetInput(){
   return 5;
}
int main(void) {
  if(yyparse() != 0) {
      printf("parse failed");
      return -1;
  }
  for( std::list<Expr*>::iterator it  = Executor::exprs.begin();
            it != Executor::exprs.end() ; it++) {
     printf("valu %d\n", (*it)->getValue());
  }
  return 0;
}

void yyerror(const char *msg){
   printf("%s\n", msg);
}
