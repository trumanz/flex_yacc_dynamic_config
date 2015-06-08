#ifndef __MODUME_AP_HH_
#define __MODUME_AP_HH_

struct module_api{
   const char *name;
   int (*api_function)(int);
};

#endif
