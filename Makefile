all : grammar.y word.lex main.cpp
	bison -d grammar.y
	flex  word.lex
	g++  grammar.tab.c  lex.yy.c  main.cpp
test: all
	./a.out <  userdef.txt
