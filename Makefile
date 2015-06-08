all : grammar.y word.lex ModuleLoader.cpp  main.cpp 
	bison -d grammar.y
	flex  word.lex
	g++  -g -O0  grammar.tab.c  lex.yy.c ModuleLoader.cpp  main.cpp -ldl
test: all
	./a.out <  userdef.txt
