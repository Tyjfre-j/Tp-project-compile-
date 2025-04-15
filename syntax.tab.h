
/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton interface for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.
   
   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     MainPrgm = 258,
     Var = 259,
     BeginPg = 260,
     EndPg = 261,
     let = 262,
     define = 263,
     Const = 264,
     IF = 265,
     THEN = 266,
     ELSE = 267,
     DO = 268,
     WHILE = 269,
     FOR = 270,
     FROM = 271,
     TO = 272,
     STEP = 273,
     INPUT = 274,
     OUTPUT = 275,
     AND = 276,
     OR = 277,
     COMMA = 278,
     SEMI_COLON = 279,
     AFFECTATION = 280,
     EQUAL = 281,
     EQUAL_TO = 282,
     LESS_OR_EQUAL = 283,
     GREATER_OR_EQUAL = 284,
     NOT_EQUAL = 285,
     COLON = 286,
     ADDITION = 287,
     SUBSTRACTION = 288,
     DIVISION = 289,
     MULTIPLICATION = 290,
     OPEN_PARENTHESIS = 291,
     CLOSE_PARENTHESIS = 292,
     OPEN_CURLY_BRACE = 293,
     CLOSE_CURLY_BRACE = 294,
     OPEN_SQUARE_BRACKET = 295,
     CLOSE_SQUARE_BRACKET = 296,
     LESS_THAN = 297,
     GREATER_THAN = 298,
     NOT = 299,
     identifier = 300,
     STRING = 301,
     Int_keyword = 302,
     Float_keyword = 303,
     integer_value = 304,
     signed_integer_value = 305,
     float_value = 306,
     signed_float_value = 307
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 1676 of yacc.c  */
#line 12 "Syntax.y"

int integer_value;
char* str;
float float_value;
struct {
        char** list;
        int number_of_elements;
}idf_list;



/* Line 1676 of yacc.c  */
#line 116 "Syntax.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


