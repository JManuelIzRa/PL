/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

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

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

#ifndef YY_YY_INTERPRETER_TAB_H_INCLUDED
# define YY_YY_INTERPRETER_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 1
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    SEMICOLON = 258,
    PRINT = 259,
    PRINT_STRING = 260,
    READ = 261,
    READ_STRING = 262,
    IF = 263,
    THEN = 264,
    END_IF = 265,
    ELSE = 266,
    WHILE = 267,
    REPEAT = 268,
    UNTIL = 269,
    FOR = 270,
    END_FOR = 271,
    FROM = 272,
    STEP = 273,
    DO = 274,
    END_WHILE = 275,
    CASES = 276,
    VALUE = 277,
    DEFAULT = 278,
    COLON = 279,
    END_CASES = 280,
    ERASE_SCREEN = 281,
    PLACE = 282,
    LETFCURLYBRACKET = 283,
    RIGHTCURLYBRACKET = 284,
    ASSIGNMENT = 285,
    COMMA = 286,
    NUMBER = 287,
    BOOL = 288,
    CADENA = 289,
    VARIABLE = 290,
    UNDEFINED = 291,
    CONSTANT = 292,
    BUILTIN = 293,
    OR = 294,
    AND = 295,
    GREATER_OR_EQUAL = 296,
    LESS_OR_EQUAL = 297,
    GREATER_THAN = 298,
    LESS_THAN = 299,
    EQUAL = 300,
    NOT_EQUAL = 301,
    NOT = 302,
    PLUS = 303,
    MINUS = 304,
    MULTIPLICATION = 305,
    DIVISION = 306,
    MODULO = 307,
    INTEGER_DIV = 308,
    CONCAT = 309,
    LPAREN = 310,
    RPAREN = 311,
    UNARY = 312,
    POWER = 313
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 142 "interpreter.y"

  char * identifier; 				 /* NEW in example 7 */
  double number;  
  bool logic;						 /* NEW in example 15 */
  char * cadena;
  lp::ExpNode *expNode;  			 /* NEW in example 16 */
  std::list<lp::ExpNode *>  *parameters;    // New in example 16; NOTE: #include<list> must be in interpreter.l, init.cpp, interpreter.cpp
  std::list<lp::Statement *> *stmts; /* NEW in example 16 */
  lp::Statement *st;				 /* NEW in example 16 */
  lp::AST *prog;					 /* NEW in example 16 */
  lp::CasesStmt *casos;

#line 129 "interpreter.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_INTERPRETER_TAB_H_INCLUDED  */
