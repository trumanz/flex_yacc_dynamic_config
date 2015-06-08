#ifndef __EXPR_H_
#define __EXPR_H_
#include "module_api.h"
class Expr{
public:
   virtual int getValue() = 0;
};

class IntExpr : public Expr{
public:
   IntExpr(int val) { this->val  = val;}
   int getValue() { return val; }
private:
   int val;
};

class AddExpr : public Expr {
public:
   AddExpr(Expr* l, Expr* r){ this->l = l;   this->r = r; }
   int getValue() { return l->getValue() + r->getValue(); }
protected:
   Expr* l;
   Expr* r;
};

class SubExpr : public AddExpr {
public:
   SubExpr(Expr* l, Expr* r): AddExpr(l,r){}
   int getValue() { return l->getValue() - r->getValue(); }
};

class FuncExpr : public Expr{
public:
   FuncExpr(api_function *f, Expr *parameter){ this->f = f; this-> p = parameter;}
   int getValue() { 
          int pval = p->getValue();
          pval = f(pval);
          return pval; }
protected:
   Expr* p;
   api_function *f;
};


#endif
