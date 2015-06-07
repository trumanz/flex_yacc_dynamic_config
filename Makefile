all : grammar.y word.lex main.c
	bison -d grammar.y
	flex  word.lex
	g++  grammar.tab.c  lex.yy.c  main.c FuncLoader.cpp
test: all
	./a.out <  userdef.txt
