%{
   #include "TS.h" 
   #include "syntax.tab.h"
   #include <stdio.h> 
   #include <stdlib.h>
   #include <string.h>
   extern int lineNumber;
   extern int columnNumber;
   extern YYSTYPE yylval;
%}

Identifier [a-zA-Z]([a-zA-Z0-9]*_?[a-zA-Z0-9])*
singleLineComment "< !-"[^\n]*"- !>"
multiLineComment "{--"(.|\n)*?"--}"
chaine \"[^\"]*\"
integer [0-9]+
signedInteger [+-][0-9]+
float [0-9]+\.[0-9]+
signedFloat [+-][0-9]+\.[0-9]+

%%
"MainPrgm" {printf("MainPrgm "); columnNumber+=yyleng; return MainPrgm;}
"Var" {printf("Var\n"); columnNumber+=yyleng; return Var;}
"BeginPg" {printf("BeginPg\n"); columnNumber+=yyleng; return BeginPg;}
"EndPg" {printf("EndPg"); columnNumber+=yyleng; return EndPg;}
"let" {printf("let "); columnNumber+=yyleng; return let;}
"@define" {printf("@define "); columnNumber+=yyleng; return define;}
"Const" {printf("Const "); columnNumber+=yyleng; return Const;}
"Int" {printf("Int"); columnNumber+=yyleng; return Int;}
"Float" {printf("Float"); columnNumber+=yyleng; return Float;}
"if" {printf("if"); columnNumber+=yyleng;}
"then" {printf("then"); columnNumber+=yyleng;}
"else" {printf("else"); columnNumber+=yyleng;}
"do" {printf("do"); columnNumber+=yyleng;}
"while" {printf("while"); columnNumber+=yyleng;}
"for" {printf("for"); columnNumber+=yyleng;}
"from" {printf("from"); columnNumber+=yyleng;}
"to" {printf("to"); columnNumber+=yyleng;}
"step" {printf("step"); columnNumber+=yyleng;}
"input" {printf("input"); columnNumber+=yyleng;}
"output" {printf("output"); columnNumber+=yyleng;}
"AND" {printf("AND"); columnNumber+=yyleng;}
"OR" {printf("OR"); columnNumber+=yyleng;}
{Identifier} {columnNumber+=yyleng; 
              if (yyleng > 14) { printf ("Found a lexical error at the line %d and the column %d : identifier is too long",lineNumber,columnNumber); return 0;}
              if (yytext[strlen(yytext) - 1] == '_') { printf("Found a lexical error at the line %d and the column %d : identifier can't end with _",lineNumber,columnNumber); return 0;}
              if (strstr(yytext,"__")) {printf("Found a lexical error at the line %d and the column %d : identifier can't have consecutive _",lineNumber,columnNumber); return 0;}
              printf("%s",yytext);
              yylval.str=strdup(yytext);
              inserer(yytext,"idf");
              return identifier;
              }

{singleLineComment} {printf("one line comment\n"); columnNumber+=yyleng; return singleLineComment;}
{multiLineComment} {printf("multi-line comment\n"); 
                    int i = 0;
                    while (yytext[i] != '\0') {
                       if (yytext[i] == '\n') {
                          lineNumber += 1;
                          columnNumber = 1;
                       }else{
                          columnNumber += 1;
                       }
                       i += 1;   
                    }
                    return multiLineComment;
                    }

{chaine} {printf("%s ",yytext); columnNumber+=yyleng;}
{signedInteger} {columnNumber+=yyleng;
                 int numValue = atoi(yytext);
                 if(numValue > 32767 || numValue <-32768){printf("Found a lexical error at the line %d and the column %d : signed integer value can't be above 32767 or under -32768\n",lineNumber,columnNumber); return 0;}
                 printf("%s",yytext); 
                 }
{integer} {columnNumber+=yyleng;
           int numValue = atoi(yytext);
           if(numValue > 32767){printf("Found a lexical error at the line %d and the column %d : integer value can't be above 32767\n",lineNumber,columnNumber); return 0;}
           printf("%s",yytext); 
           yylval.entier=atoi(yytext);
           return t_int;
           }
{signedFloat} {printf("%s ",yytext); columnNumber+=yyleng;}
{float} {printf("%s ",yytext); yylval.floatval=atof(yytext); columnNumber+=yyleng; return t_float;}
\, {printf(","); columnNumber+=1; return vg;}
\; {printf(";\n"); columnNumber+=1; return pvg;}
\= {printf(" = "); columnNumber+=1; return egual;}
":=" {printf(" aff "); columnNumber+=2;}
\: {printf(" : "); columnNumber+=1; return tp;}
\+ {printf(" add "); columnNumber+=1;}
\- {printf(" substract "); columnNumber+=1;}
\/ {printf(" divide "); columnNumber+=1;}
\* {printf(" multiply "); columnNumber+=1;}
\( {printf("("); columnNumber+=1;}
\) {printf(")"); columnNumber+=1;}
\{ {printf("{\n"); columnNumber+=1; return ocb;}
\} {printf("}\n"); columnNumber+=1; return ccb;}
\[ {printf("["); columnNumber+=1; return ob;}
\] {printf("]"); columnNumber+=1; return cb;}
\< {printf("<\n"); columnNumber+=1;}
\> {printf(">\n"); columnNumber+=1;}
\! {printf("!\n"); columnNumber+=1;}
[ ] columnNumber+=1;
"\t" columnNumber+=4;
\n {lineNumber+=1; columnNumber = 1;}
. {printf("Found a lexical error at the line %d and the column %d \n",lineNumber,columnNumber); columnNumber+=yyleng;}
%%

