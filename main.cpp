#include <stdio.h>
#include "Executor.h"
#include "ModuleLoader.h"
#include <list>

std::list<Expr*> Executor::exprs;


typedef struct yy_buffer_state * YY_BUFFER_STATE;
extern int yyparse();
extern YY_BUFFER_STATE yy_scan_string(char * str);
extern void yy_delete_buffer(YY_BUFFER_STATE buffer);

int yyparse();
int GetInput(){
   return 5;
}
int main(void) {
  ModuleLoader::LoaderDynamicLibrary("./module_example/libextmath.so");
   if(yyparse() != 0) {
       printf("parse failed");
       return -1;
   }
  
  for( std::list<Expr*>::iterator it  = Executor::exprs.begin();
            it != Executor::exprs.end() ; it++) {
     printf("valu %s\n", (*it)->getValueAsStr().c_str());
  }
  return 0;
}

void yyerror(const char *msg){
   printf("%s\n", msg);
}
