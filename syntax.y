
%{
    #include "TS.h" 
    #include <stdio.h> 
    #include <stdlib.h>
    #include <string.h>
    extern char* yytext;
    int lineNumber = 1;   
    int columnNumber = 1; 
%}

%union {
int entier;
char* str;
float floatval;
}

%token MainPrgm pvg Var singleLineComment let define Const t_int 
       t_float BeginPg ocb multiLineComment ccb EndPg egual tp vg ob 
       cb 
%token<str> identifier
%token<entier> Int 
%token<floatval> Float 
%start program

%%
program:
    MainPrgm identifier pvg 
    Var
    singleLineComment
    declaration_part
    BeginPg 
    ocb 
    multiLineComment 
    ccb
    EndPg pvg {
    printf("syntaxe correcte");
    YYACCEPT;
    };

declaration_part:
    declaration_list ;

declaration_list:
    declaration_list declaration | declaration ;

declaration:
    variable_declaration | constant_declaration ;

variable_declaration:
    let var_list tp type pvg | let var_list tp ob type pvg t_int cb pvg ;

var_list:
    identifier | var_list vg identifier ;

type:
    Int | Float ;

constant_declaration:
    define Const identifier tp type egual nature pvg ;

nature:
    t_int | t_float ;
%%

main ()
{
 yyparse();
 afficher();
}
yywrap()
{}
int yyerror(char *msg)
{ printf("Found a syntax error at the line %d and the column %d \n",lineNumber,columnNumber - strlen(yytext));
    return 1;
}