#ifndef __MODUME_AP_HH_
#define __MODUME_AP_HH_

typedef int (api_function)(int);

struct module_api{
   const char *name;
   int (*api)(int);
};

#endif
