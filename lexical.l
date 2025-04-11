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
multiLineComment "\{--"(.|\n)*?"--\}"
chaine \"[^\"]*\" 
integer [0-9]+
signedInteger [+-][0-9]+
float [0-9]+\.[0-9]+
signedFloat [+-][0-9]+\.[0-9]+

%%
"MainPrgm" { 
    columnNumber += yyleng; 
    return MainPrgm; 
}

"Var" { 
    columnNumber += yyleng; 
    return Var; 
}

"BeginPg" { 
    columnNumber += yyleng; 
    return BeginPg; 
}

"EndPg" { 
    columnNumber += yyleng; 
    return EndPg; 
}

"let" { 
    columnNumber += yyleng; 
    return let; 
}

"@define" { 
    columnNumber += yyleng; 
    return define; 
}

"Const" { 
    columnNumber += yyleng; 
    return Const; 
}

"Int" { 
    columnNumber += yyleng; 
    return Int; 
}

"Float" { 
    columnNumber += yyleng; 
    return Float; 
}

"if" { 
    columnNumber += yyleng; 
    return IF; 
}

"then" { 
    columnNumber += yyleng; 
    return THEN; 
}

"else" { 
    columnNumber += yyleng; 
    return ELSE; 
}

"do" { 
    columnNumber += yyleng; 
    return DO; 
}

"while" { 
    columnNumber += yyleng; 
    return WHILE; 
}

"for" { 
    columnNumber += yyleng; 
    return FOR; 
}

"from" { 
    columnNumber += yyleng; 
    return FROM; 
}

"to" { 
    columnNumber += yyleng; 
    return TO; 
}

"step" { 
    columnNumber += yyleng; 
    return STEP; 
}

"input" { 
    columnNumber += yyleng; 
    return INPUT; 
}

"output" { 
    columnNumber += yyleng; 
    return OUTPUT; 
}

"AND" { 
    columnNumber += yyleng; 
    return AND; 
}

"OR" { 
    columnNumber += yyleng; 
    return OR; 
}

{Identifier} {
    columnNumber += yyleng;

    if (yyleng > 14) {
        printf("Found a lexical error at line %d, column %d: identifier is too long\n", lineNumber, columnNumber);
        return 0;
    }

    if (yytext[strlen(yytext) - 1] == '_') {
        printf("Found a lexical error at line %d, column %d: identifier can't end with '_'\n", lineNumber, columnNumber);
        return 0;
    }

    if (strstr(yytext, "__")) {
        printf("Found a lexical error at line %d, column %d: identifier can't have consecutive '_'\n", lineNumber, columnNumber);
        return 0;
    }

    printf("Identifier found: %s\n", yytext);
    int i;
    for (i = 0; i < 12; i++) {
        if (strcmp(yytext, keywords[i]) == 0) {
            yylval.str = strdup(yytext);
            inserer(yytext, "keyword", "keyword", (Value){.entier = 0}); 
            return identifier;
        }
    }
    char* endptr;
    int intValue = strtol(yytext, &endptr, 10);
    if (*endptr == '\0') {  
        yylval.entier = intValue;
        inserer(yytext, "variable", "int", (Value){.entier = intValue});  
        return identifier;
    }

    float floatValue = strtof(yytext, &endptr);
    if (*endptr == '\0') {  
        yylval.floatval = floatValue;
        inserer(yytext, "variable", "float", (Value){.floatval = floatValue});  
        return identifier;
    }

}

{singleLineComment} { 
    columnNumber += yyleng; 
}

{multiLineComment} {
    int i = 0;
    while (yytext[i] != '\0') {
        if (yytext[i] == '\n') {
            lineNumber++;
            columnNumber = 1;
        } else {
            columnNumber++;
        }
        i++;
    }
}

{chaine} {printf("%s ",yytext); columnNumber+=yyleng; return STRING;}
{signedInteger} {columnNumber+=yyleng;
                 int numValue = atoi(yytext);
                 if(numValue > 32767 || numValue <-32768){printf("Found a lexical error at the line %d and the column %d : signed integer value can't be above 32767 or under -32768\n",lineNumber,columnNumber); return 0;}
                 printf("%s",yytext); 
                 return signed_int;
                 }
{integer} {columnNumber+=yyleng;
           int numValue = atoi(yytext);
           if(numValue > 32767){printf("Found a lexical error at the line %d and the column %d : integer value can't be above 32767\n",lineNumber,columnNumber); return 0;}
           printf("%s",yytext); 
           yylval.entier=atoi(yytext);
           return t_int;
           }
{signedFloat} {printf("%s ",yytext); columnNumber+=yyleng; return signed_float;}
{float} {printf("%s ",yytext); yylval.floatval=atof(yytext); columnNumber+=yyleng; return t_float;}

\, { 
    columnNumber++; 
    return vg; 
}

\; { 
    columnNumber++; 
    return pvg; 
}

\= { 
    columnNumber++; 
    return egual; 
}

":=" { 
    columnNumber += 2; 
    return aff; 
}

"==" { 
    columnNumber += 2; 
    return eq; 
}

"<=" { 
    columnNumber += 2; 
    return le; 
}

">=" { 
    columnNumber += 2; 
    return ge; 
}

"!=" { 
    columnNumber += 2; 
    return ne; 
}

\: { 
    columnNumber++; 
    return tp; 
}

\+ { 
    columnNumber++; 
    return add; 
}

\- { 
    columnNumber++; 
    return sub; 
}

\/ { 
    columnNumber++; 
    return divide; 
}

\* { 
    columnNumber++; 
    return mult; 
}

\( { 
    columnNumber++; 
    return op; 
}

\) { 
    columnNumber++; 
    return cp; 
}

\{ { 
    columnNumber++; 
    return ocb; 
}

\} { 
    columnNumber++; 
    return ccb; 
}

\[ { 
    columnNumber++; 
    return ob; 
}

\] { 
    columnNumber++; 
    return cb; 
}

\< { 
    columnNumber++; 
    return lt; 
}

\> { 
    columnNumber++; 
    return gt; 
}

\! { 
    columnNumber++; 
    return NOT; 
}

[ ] columnNumber++; 

"\t" columnNumber += 4;

\n { 
    lineNumber++; 
    columnNumber = 1; 
}

. { 
    printf("Lexical error at line %d, column %d: unrecognized symbol '%s'\n", lineNumber, columnNumber, yytext); 
    columnNumber += yyleng; 
}

%%
