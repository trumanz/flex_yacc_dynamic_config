#include "ModuleLoader.h"
#include <stdio.h>
std::map<std::string, api_function*> ModuleLoader::apis;


api_function* ModuleLoader::SearchApi(const char *name){
   if(ModuleLoader::apis.find(name) != ModuleLoader::apis.end()) return ModuleLoader::apis[name];
   return NULL;
}
int  ModuleLoader::LoaderDynamicLibrary(const char *path){
   void *handle = dlopen(path, RTLD_NOW);
   if(!handle) {
         printf("Error, %s\n", dlerror());
         return -1;
   }
   struct module_api* mapi;
   mapi = (struct module_api*)dlsym(handle, "expotrs_api");
   printf("%s\n", mapi[0].name);
   int i = 0;
   while(1){
       if(mapi[i].name == NULL) break;
       printf("%s %p\n", mapi[i].name, mapi[i].api);
       ModuleLoader::apis[mapi[i].name] = mapi[i].api;
       printf("%d\n",mapi[i].api(3));
       i++;
   }
   dlclose(handle);
   return 0;
}

