
flex Lexical.l
bison -d -v Syntax.y
gcc lex.yy.c Syntax.tab.c SymbolsTable.c -lfl -ly -o compil
compil.exe<Input.txt
