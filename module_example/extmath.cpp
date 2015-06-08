#include "../module_api.h"
#include "stdlib.h"
static int factorial(int n);
static int addten(int n);


struct module_api expotrs_api[] = {
   {"factorial",  factorial },
   {"addten",   addten },
   {NULL,   NULL }
};


static int factorial(int n){
     int ret = 1;
     if(n < 0) n = -n;
     for(int  i = 1; i <= n; i++) ret = ret*i;
     return ret;
}

static int addten(int n){
     return n+10;
}
