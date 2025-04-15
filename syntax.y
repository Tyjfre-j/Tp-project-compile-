
%{
    #include "SymbolsTable.h" 
    #include <stdio.h> 
    #include <stdlib.h>
    #include <string.h>
    extern char* yytext;
    int line_Number = 1;   
    int column_Number = 1; 
%}

%union {
int integer_value;
char* str;
float float_value;
struct {
        char** list;
        int number_of_elements;
}idf_list;
}

%token MainPrgm Var BeginPg EndPg let define Const IF THEN ELSE DO WHILE FOR FROM TO STEP INPUT OUTPUT AND OR
%token COMMA SEMI_COLON AFFECTATION EQUAL EQUAL_TO LESS_OR_EQUAL GREATER_OR_EQUAL NOT_EQUAL COLON ADDITION SUBSTRACTION DIVISION MULTIPLICATION OPEN_PARENTHESIS CLOSE_PARENTHESIS OPEN_CURLY_BRACE CLOSE_CURLY_BRACE OPEN_SQUARE_BRACKET CLOSE_SQUARE_BRACKET LESS_THAN GREATER_THAN NOT
%token <str> identifier
%token <str> STRING
%token <str> Int_keyword Float_keyword
%token <str> integer_value
%token <str> signed_integer_value
%token <str> float_value
%token <str> signed_float_value
%type <idf_list> var_list
%type <str> type
%type <str> nature

%left ADDITION SUBSTRACTION
%left MULTIPLICATION DIVISION
%left AND OR
%right NOT
%right AFFECTATION

%start program

%%
program:
    MainPrgm identifier SEMI_COLON Var
    declaration_part
    BeginPg 
    OPEN_CURLY_BRACE
    instruction_part
    CLOSE_CURLY_BRACE
    EndPg SEMI_COLON
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
    let var_list COLON type SEMI_COLON {
      int i;
      for (i = 0; i < $2.number_of_elements; i++) {
            insert_into_idf_table($2.list[i], "identifier", "var", $4, "", "");
            free($2.list[i]);  
        }
        free($2.list); 
        free($4);      
    }
    | let var_list COLON OPEN_SQUARE_BRACKET type SEMI_COLON integer_value CLOSE_SQUARE_BRACKET SEMI_COLON {
        int i;
        for (i = 0; i < $2.number_of_elements; i++) {
            insert_into_idf_table($2.list[i], "identifier", "array", $5, $7, "");
            free($2.list[i]);
        }
        free($2.list);
        free($5);
    }
    ;

var_list:
    identifier {
        $$ .list = malloc(sizeof(char*));   
        $$ .list[0] = $1;                  
        $$ .number_of_elements = 1;
    }
    | var_list COMMA identifier {
        $$ .number_of_elements = $1.number_of_elements + 1;
        $$ .list = realloc($1.list, $$ .number_of_elements * sizeof(char*));
        $$ .list[$$ .number_of_elements - 1] = $3
    }
    ;

type:
    Int_keyword {$$ = $1;}
    | Float_keyword {$$ = $1;}
    ;

constant_declaration:
    define Const identifier COLON type EQUAL nature SEMI_COLON{
        insert_into_idf_table($3, "identifier", "const",  $5, "", $7);
        free($3);
        free($5);
        free($7);
    }
    ;

nature:
    integer_value {$$ = $1;}
    | float_value {$$ = $1;}
    | OPEN_PARENTHESIS signed_float_value CLOSE_PARENTHESIS {$$ = $2;}
    | OPEN_PARENTHESIS signed_integer_value CLOSE_PARENTHESIS {$$ = $2;}
    ;


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
    identifier AFFECTATION expression SEMI_COLON
    | identifier OPEN_SQUARE_BRACKET expression CLOSE_SQUARE_BRACKET AFFECTATION expression SEMI_COLON ;

expression:
    identifier
    | nature
    | expression ADDITION expression
    | expression SUBSTRACTION expression
    | expression MULTIPLICATION expression
    | expression DIVISION expression
    | OPEN_PARENTHESIS expression CLOSE_PARENTHESIS
    ;

if_statement:
    IF OPEN_PARENTHESIS condition CLOSE_PARENTHESIS THEN OPEN_CURLY_BRACE instruction_list CLOSE_CURLY_BRACE 
    | IF OPEN_PARENTHESIS condition CLOSE_PARENTHESIS THEN OPEN_CURLY_BRACE instruction_list CLOSE_CURLY_BRACE ELSE OPEN_CURLY_BRACE instruction_list CLOSE_CURLY_BRACE ;


condition:
    expression GREATER_THAN expression
    | expression LESS_THAN expression
    | expression GREATER_OR_EQUAL expression  
    | expression LESS_OR_EQUAL expression  
    | expression EQUAL_TO expression  
    | expression NOT_EQUAL expression  
    | OPEN_PARENTHESIS condition CLOSE_PARENTHESIS
    | condition AND condition
    | condition OR condition
    | NOT condition
    ;

do_while_loop:
    DO OPEN_CURLY_BRACE instruction_list CLOSE_CURLY_BRACE WHILE OPEN_PARENTHESIS condition CLOSE_PARENTHESIS SEMI_COLON ;

for_loop:
    FOR identifier FROM expression TO expression STEP expression OPEN_CURLY_BRACE instruction_list CLOSE_CURLY_BRACE ;

input_statement:
    INPUT OPEN_PARENTHESIS identifier CLOSE_PARENTHESIS SEMI_COLON ;

output_statement:
    OUTPUT OPEN_PARENTHESIS STRING CLOSE_PARENTHESIS SEMI_COLON
    | OUTPUT OPEN_PARENTHESIS STRING COMMA identifier CLOSE_PARENTHESIS SEMI_COLON ;

%%

main ()
{
yyparse();
show_idf_table();
show_keyword_table();
show_seperator_table(); 
}
yywrap(){}
int yyerror(char *msg)
{ printf("Found a syntax error at the line %d and the column %d \n",line_Number,column_Number - strlen(yytext));
    return 1;
}