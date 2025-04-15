%{
   #include "SymbolsTable.h" 
   #include "Syntax.tab.h"
   #include <stdio.h> 
   #include <stdlib.h>
   #include <string.h>
   extern int line_Number;
   extern int column_Number;
   extern YYSTYPE yylval;
%}

Identifier [a-zA-Z0-9_]+ 
single_line_comment "< !-"[^\n]*"- !>"
multi_line_comment "\{--"(.|\n)*?"--\}"
message \"[^\"]*\"
integer [0-9]+
signed_integer [+-][0-9]+
float [0-9]+\.[0-9]+
signed_float [+-][0-9]+\.[0-9]+

%%
"MainPrgm" { 
    column_Number += yyleng; 
    insert_into_keyword_table("MainPrgm", "keyword");
    return MainPrgm; 
}

"Var" { 
    column_Number += yyleng; 
    insert_into_keyword_table("Var", "keyword");
    return Var; 
}

"BeginPg" { 
    column_Number += yyleng; 
    insert_into_keyword_table("BeginPg", "keyword");
    return BeginPg; 
}

"EndPg" { 
    column_Number += yyleng; 
    insert_into_keyword_table("EndPg", "keyword");
    return EndPg; 
}

"let" { 
    column_Number += yyleng; 
    insert_into_keyword_table("let", "keyword");
    return let; 
}

"@define" { 
    column_Number += yyleng; 
    insert_into_keyword_table("@define", "keyword");
    return define; 
}

"Const" { 
    column_Number += yyleng; 
     insert_into_keyword_table("Const", "keyword");
    return Const; 
}

"Int" { 
    column_Number += yyleng; 
    insert_into_keyword_table("Int", "keyword");
    yylval.str = strdup("int");
    return Int_keyword; 
}

"Float" { 
    column_Number += yyleng; 
    insert_into_keyword_table("Float", "keyword");
     yylval.str = strdup("float");
    return Float_keyword; 
}

"if" { 
    column_Number += yyleng; 
    insert_into_keyword_table("if", "keyword");
    return IF; 
}

"then" { 
    column_Number += yyleng; 
    insert_into_keyword_table("then", "keyword");
    return THEN; 
}

"else" { 
    column_Number += yyleng; 
    insert_into_keyword_table("else", "keyword");
    return ELSE; 
}

"do" { 
    column_Number += yyleng; 
    insert_into_keyword_table("do", "keyword");
    return DO; 
}

"while" { 
    column_Number += yyleng; 
    insert_into_keyword_table("while", "keyword");
    return WHILE; 
}

"for" { 
    column_Number += yyleng; 
    insert_into_keyword_table("for", "keyword");
    return FOR; 
}

"from" { 
    column_Number += yyleng; 
    insert_into_keyword_table("from", "keyword");
    return FROM; 
}

"to" { 
    column_Number += yyleng; 
    insert_into_keyword_table("to", "keyword");
    return TO; 
}

"step" { 
    column_Number += yyleng; 
    insert_into_keyword_table("step", "keyword");
    return STEP; 
}

"input" { 
    column_Number += yyleng; 
    insert_into_keyword_table("input", "keyword");
    return INPUT; 
}

"output" { 
    column_Number += yyleng;
    insert_into_keyword_table("output", "keyword"); 
    return OUTPUT; 
}

"AND" { 
    column_Number += yyleng;
    insert_into_keyword_table("AND", "keyword"); 
    return AND; 
}

"OR" { 
    column_Number += yyleng;
    insert_into_keyword_table("OR", "keyword"); 
    return OR; 
}

{signed_integer} {
                 int numValue = atoi(yytext);
                 if(numValue > 32767 || numValue <-32768){printf("Found a lexical error at the line %d and the column %d : signed integer value can't be above 32767 or under -32768\n",line_Number,column_Number); return 0;}
                 printf("%s",yytext); 
                 column_Number+=yyleng;
                 yylval.str = strdup(yytext);
                 return signed_integer_value;
                 }
{integer} {
           int numValue = atoi(yytext);
           if(numValue > 32767){printf("Found a lexical error at the line %d and the column %d : integer value can't be above 32767\n",line_Number,column_Number); return 0;}
           printf("%s",yytext);
           column_Number+=yyleng; 
           yylval.str = strdup(yytext);
           return integer_value;
           }
{signed_float} {
                printf("%s ",yytext); 
                column_Number+=yyleng; 
                yylval.str = strdup(yytext);
                return signed_float_value;}
{float} {
        printf("%s ",yytext); 
        yylval.str = strdup(yytext);
        column_Number+=yyleng; 
        return float_value;}

{Identifier} {

    // check if the length of the idf is correct
    if (yyleng > 14) {
        printf("Found a lexical error at line %d, column %d: identifier is too long\n", line_Number, column_Number);
        return 0;
    }
    // check if the idf doesn't end with _
    if (yytext[strlen(yytext) - 1] == '_') {
        printf("Found a lexical error at line %d, column %d: identifier can't end with _\n", line_Number, column_Number);
        return 0;
    }
    // check if the idf doesn't contain __
    if (strstr(yytext, "__")) {
        printf("Found a lexical error at line %d, column %d: identifier can't have consecutive _\n", line_Number, column_Number);
        return 0;
    }
    // check if the idf doesn't start with a letter
    if ( !((yytext[0] >= 'a' && yytext[0] <= 'z') || (yytext[0] >= 'A' && yytext[0] <= 'Z')) )
    {
        printf("Found a lexical error at line %d, column %d: identifier must start with a letter\n", line_Number, column_Number);
        return 0;
    }
    // check if the idf contains capital letters other then the first letter
    int i;
    for (i = 1; yytext[i] != '\0'; i++) {
    if (yytext[i] >= 'A' && yytext[i] <= 'Z') {
        printf("Found a lexical error at line %d, column %d: identifier must not contain uppercase letters after the first character\n", line_Number, column_Number + i);
        return 0;
    }
    }
    column_Number += yyleng;
    printf("Identifier found: %s\n", yytext);
    yylval.str = strdup(yytext);
    return identifier;

}

{single_line_comment} { 
    column_Number += yyleng; 
}

{multi_line_comment} {
    int i = 0;
    while (yytext[i] != '\0') {
        if (yytext[i] == '\n') {
            line_Number++;
            column_Number = 1;
        } else {
            column_Number++;
        }
        i++;
    }
}

{message} {printf("%s ",yytext); column_Number+=yyleng; return STRING;}

\, { 
    column_Number++; 
    insert_into_seperator_table(",","seperator");
    return COMMA; 
}

\; { 
    column_Number++; 
    insert_into_seperator_table(";","seperator");
    return SEMI_COLON; 
}

"=" { 
    column_Number += 2; 
    insert_into_seperator_table(":=","seperator");
    return EQUAL; 
}

":=" { 
    column_Number += 2; 
    insert_into_seperator_table(":=","seperator");
    return AFFECTATION; 
}

"==" { 
    column_Number += 2; 
    insert_into_seperator_table("==","seperator");
    return EQUAL_TO; 
}

"<=" { 
    column_Number += 2; 
    insert_into_seperator_table("<=","seperator");
    return LESS_OR_EQUAL; 
}

">=" { 
    column_Number += 2; 
    insert_into_seperator_table(">=","seperator");
    return GREATER_OR_EQUAL; 
}

"!=" { 
    column_Number += 2; 
    insert_into_seperator_table("!=","seperator");
    return NOT_EQUAL; 
}

\: { 
    column_Number++;
    insert_into_seperator_table(":","seperator"); 
    return COLON; 
}

\+ { 
    column_Number++;
    insert_into_seperator_table("+","seperator"); 
    return ADDITION; 
}

\- { 
    column_Number++;
    insert_into_seperator_table("-","seperator"); 
    return SUBSTRACTION; 
}

\/ { 
    column_Number++;
    insert_into_seperator_table("/","seperator"); 
    return DIVISION; 
}

\* { 
    column_Number++;
    insert_into_seperator_table("*","seperator"); 
    return MULTIPLICATION; 
}

\( { 
    column_Number++;
    insert_into_seperator_table("(","seperator"); 
    return OPEN_PARENTHESIS; 
}

\) { 
    column_Number++;
    insert_into_seperator_table(")","seperator"); 
    return CLOSE_PARENTHESIS; 
}

\{ { 
    column_Number++;
    insert_into_seperator_table("{","seperator"); 
    return OPEN_CURLY_BRACE; 
}

\} { 
    column_Number++;
    insert_into_seperator_table("}","seperator"); 
    return CLOSE_CURLY_BRACE; 
}

\[ { 
    column_Number++;
    insert_into_seperator_table("[","seperator"); 
    return OPEN_SQUARE_BRACKET; 
}

\] { 
    column_Number++;
    insert_into_seperator_table("]","seperator"); 
    return CLOSE_SQUARE_BRACKET; 
}

\< { 
    column_Number++;
    insert_into_seperator_table("<","seperator"); 
    return LESS_THAN; 
}

\> { 
    column_Number++;
    insert_into_seperator_table(">","seperator"); 
    return GREATER_THAN; 
}

\! { 
    column_Number++;
    insert_into_seperator_table("!","seperator"); 
    return NOT; 
}

[ ] column_Number++; 

"\t" column_Number += 4;

\n { 
    line_Number++; 
    column_Number = 1; 
}

. { 
    printf("Lexical error at line %d, column %d: unrecognized symbol '%s'\n", line_Number, column_Number, yytext); 
    column_Number += yyleng; 
}

%%
