#ifndef __FUNCTION_LOADER__H__
#define __FUNCTION_LOADER__H__
#include "module_api.h"
#include <dlfcn.h>
#include <map>
#include <string>
class ModuleLoader{
public:
static  api_function* SearchApi(const char *name);
static int  LoaderDynamicLibrary(const char *path);
private:
static std::map<std::string, api_function*> apis;
};

#endif
