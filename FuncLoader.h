#ifndef __FUNCTION_LOADER__H__
#define __FUNCTION_LOADER__H__
typedef  int(FuncType)(int);
class FuncLoader{
public:
static int dummy(int par){
   return par + 1;
}
static  FuncType* SearchFunction(const char *name){
   return dummy;
}
static int  LoaderDynamicLibrary(const char *path){
   handle = dlopen(path, RTLD_NOW);
   mr = (mod_register_function)dlsym(handle, "mod_register");
   dlclose(handle);
}
};

#endif
