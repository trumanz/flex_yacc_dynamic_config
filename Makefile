all : grammar.y word.lex main.c
	bison -d grammar.y
	flex  word.lex
	gcc  grammar.tab.c  lex.yy.c  main.c
test: all
	./a.out <  userdef.txt
