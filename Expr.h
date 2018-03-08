#ifndef __EXPR_H_
#define __EXPR_H_
#include "module_api.h"
#include <string>
#include <sstream> 

class Expr{
public:
   virtual std::string getValueAsStr() = 0;
};

class IntExpr : public Expr{
public:
   virtual int getValue() = 0;
   virtual std::string getValueAsStr(){
       std::stringstream ss;
       ss << this->getValue();
       return ss.str();
   }
};

class BoolExpr : public Expr{
public:
   virtual bool getValue() = 0;
   virtual std::string getValueAsStr(){
       return this->getValue() ? "true" : "false";
   }
};


class NumIntExpr : public IntExpr{
public:
   NumIntExpr(int val) { this->val  = val;}
   int getValue() { return val; }
private:
   int val;
};

class IntArithOper : public IntExpr{
protected:
   IntExpr* l;
   IntExpr* r;
   IntArithOper(IntExpr* _l, IntExpr* _r){ this->l = _l;   this->r = _r; }
};

class IntAddExpr : public IntArithOper {
public:
   IntAddExpr(IntExpr* l, IntExpr* r): IntArithOper(l,r){}
   int getValue() { return l->getValue() + r->getValue(); }
};

class IntSubExpr : public IntArithOper {
public:
   IntSubExpr(IntExpr* l, IntExpr* r): IntArithOper(l,r){}
   int getValue() { return l->getValue() - r->getValue(); }
};

class IntFromBoolExpr : public IntExpr {
    BoolExpr* be;
public:
   IntFromBoolExpr(BoolExpr* _be) {this->be = _be;}
   int getValue() { return be->getValue() ? 1 : 0; }
};

class FuncExpr : public IntExpr{
public:
   FuncExpr(api_function *f, IntExpr *parameter){ this->f = f; this-> p = parameter;}
   int getValue() { 
          int pval = p->getValue();
          pval = f(pval);
          return pval; }
protected:
   IntExpr* p;
   api_function *f;
};


class IntLessExpr : public BoolExpr {
protected:
   IntExpr* l;
   IntExpr* r;
public:
   IntLessExpr(IntExpr* _l, IntExpr* _r){
       this->l = _l;
       this->r = _r;
   }
   bool getValue() { return l->getValue() < r->getValue();}
};

class IntThanExpr : public BoolExpr {
protected:
   IntExpr* l;
   IntExpr* r;
public:
   IntThanExpr(IntExpr* _l, IntExpr* _r){
       this->l = _l;
       this->r = _r;
   }
   bool getValue() { return l->getValue() > r->getValue();}
};


#endif
