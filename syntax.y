
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

%token MainPrgm pvg Var let define Const t_int 
       t_float BeginPg ocb ccb EndPg egual tp vg ob cb  
       signed_int signed_float op cp aff add sub divide 
       mult IF THEN ELSE DO WHILE FOR FROM TO STEP lt gt NOT 
       AND OR eq ge le ne INPUT OUTPUT STRING

%token<str> identifier
%token<entier> Int 
%token<floatval> Float 

%left add sub
%left mult divide
%left AND OR
%right NOT
%right aff

%start program

%%
program:
    MainPrgm identifier pvg 
    Var
    declaration_part
    BeginPg 
    ocb 
    instruction_part
    ccb
    EndPg pvg 
    {
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
    t_int | t_float | op signed_float cp | op signed_int cp ;


instruction_part:
    instruction_list;

instruction_list:
    instruction_list instruction | instruction;

instruction:
    affectation
    | if_statement
    | do_while_loop
    | for_loop
    | input_statement 
    | output_statement
    ;

affectation:
    identifier aff expression pvg
    | identifier ob expression cb aff expression pvg ;

expression:
    identifier
    | nature
    | expression add expression
    | expression sub expression
    | expression mult expression
    | expression divide expression
    | op expression cp
    ;

if_statement:
    IF op condition cp THEN ocb instruction_list ccb 
    | IF op condition cp THEN ocb instruction_list ccb ELSE ocb instruction_list ccb


condition:
    expression gt expression
    | expression lt expression
    | expression ge expression  
    | expression le expression  
    | expression eq expression  
    | expression ne expression  
    | op condition cp
    | condition AND condition
    | condition OR condition
    | NOT condition
    ;

do_while_loop:
    DO ocb instruction_list ccb WHILE op condition cp pvg

for_loop:
    FOR identifier FROM expression TO expression STEP expression ocb instruction_list ccb

input_statement:
    INPUT op identifier cp pvg

output_statement:
    OUTPUT op STRING cp pvg
    | OUTPUT op STRING vg identifier cp pvg

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