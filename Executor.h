#ifndef __EXECUTOR__H__
#define __EXECUTOR__H__
#include "Expr.h"
#include <list>
class Executor{
public:
   static void Add(Expr *expr){ Executor::exprs.push_back(expr); }
   static std::list<Expr*> exprs;
};


#endif


