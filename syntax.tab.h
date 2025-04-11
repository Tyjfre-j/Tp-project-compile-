
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
     pvg = 259,
     Var = 260,
     let = 261,
     define = 262,
     Const = 263,
     t_int = 264,
     t_float = 265,
     BeginPg = 266,
     ocb = 267,
     ccb = 268,
     EndPg = 269,
     egual = 270,
     tp = 271,
     vg = 272,
     ob = 273,
     cb = 274,
     signed_int = 275,
     signed_float = 276,
     op = 277,
     cp = 278,
     aff = 279,
     add = 280,
     sub = 281,
     divide = 282,
     mult = 283,
     IF = 284,
     THEN = 285,
     ELSE = 286,
     DO = 287,
     WHILE = 288,
     FOR = 289,
     FROM = 290,
     TO = 291,
     STEP = 292,
     lt = 293,
     gt = 294,
     NOT = 295,
     AND = 296,
     OR = 297,
     eq = 298,
     ge = 299,
     le = 300,
     ne = 301,
     INPUT = 302,
     OUTPUT = 303,
     STRING = 304,
     identifier = 305,
     Int = 306,
     Float = 307
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 1676 of yacc.c  */
#line 12 "syntax.y"

int entier;
char* str;
float floatval;



/* Line 1676 of yacc.c  */
#line 112 "syntax.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


