#ifndef __FUNCTION_LOADER__H__
#define __FUNCTION_LOADER__H__
typedef  int(FuncType)(int);

FuncType* SearchFunction(const char *name);

#endif
