/*! 
  \file interpreter.l
  \brief Lexical or scanner file
*/
%{
#include <iostream>

/*********************/
/* NEW in example 4 */
/* atof */
#include <stdlib.h>
/*********************/

/* Macros for the screen */
#include "../includes/macros.hpp"

/*********************/
/* 
  NEW in example 16 
  AST class
  IMPORTANT: must be written before interpreter.tab.h
*/
#include "../ast/ast.hpp"
/*********************/

/*  interpreter.tab.h contains the numeric values of the tokens produced by the parser */
#include "interpreter.tab.h"

/********************/
/* NEW in example 3 */
#include "../error/error.hpp"
/********************/


/*********************************************/
/* NEW in example 7 */
/* Table of symbols */
#include "../table/table.hpp"

#include "../table/numericVariable.hpp"

extern lp::Table table; //!< External Table of Symbols
/*********************************************/

extern int lineNumber; //!< External line counter

/* uso de strdup */
#include <string.h>


%}


/*! \name REGULAR DEFINITIONS  */

DIGIT  [0-9] 

LETTER [a-zA-Z]

NUMBER {DIGIT}+(\.{DIGIT}+)?([Ee][+|-]?{DIGIT}+)?

IDENTIFIER  {LETTER}({LETTER}|{DIGIT}|"_"({LETTER}|{DIGIT}))*

SYMBOL "@"|"$"

ERRORIDa {IDENTIFIER}"_"
ERRORIDb ({DIGIT}|"_"){IDENTIFIER}
ERRORIDc {LETTER}({LETTER}|{DIGIT}|"__"({LETTER}|{DIGIT}))*

ERRORDIGa 	"."{DIGIT}+
ERRORDIGb 	{DIGIT}+"."

CADENA	 "'"([^']|"\\\'")*"'"

BIG_COMMENT 	<<([^(>>)])*>>

ONE_LINE_COMMENT	#([^(\n)])*


/* NEW in example 3 */
/* STATE  */
%x ERROR

/*! \name REGULAR EXPRESSIONS  */
%%

[ \t] 	{ ; }    /* skip white space and tabular */

\n      { 
			/* Line counter */
           	lineNumber++; 
	
			/* MODIFIED in example 3 */
			/* COMMENTED in example 5 */
        	/* return NEWLINE; */
        }

";"		{
			/* NEW in example 5 */
			return SEMICOLON;
		}


","		{
			/* NEW in example 14 */
			return COMMA;
		}

{NUMBER}  {
					  /* MODIFIED in example 4 */
					  /* Conversion of type and sending of the numerical value to the parser */
					   yylval.number = atof(yytext); 

                       return NUMBER; 
                      }


{IDENTIFIER}   		 {
						/* Convertir la entrada a minúscula */
						for (int i = 0; yytext[i] != '\0'; i++)
						{
							yytext[i] = tolower(yytext[i]);
						}
	
						 /* NEW in example 7 */
						 std::string identifier(yytext);

						/* 
                          strdup() function returns a pointer to a new string 
                          which  is a duplicate of the string yytext
                        */
						  yylval.identifier =  strdup(yytext); 

						/* If the identifier is not in the table of symbols then it is inserted */	
						 if (table.lookupSymbol(identifier) == false)
							{
								/* 
								 The identifier is inserted into the symbol table 
								 as undefined Variable with value 0.0
								*/
								lp::NumericVariable *n = new lp::NumericVariable(identifier,VARIABLE,UNDEFINED,0.0);

								/* A pointer to the new NumericVariable is inserted into the table of symbols */
								table.installSymbol(n);

								return VARIABLE;
							}

						/* MODIFIED in example 11 */
						/* 
							If the identifier is in the table of symbols then its token is returned 
								The identifier can be a variable or a numeric constant
						*/
						else 
							{
								lp::Symbol	*s = table.getSymbol(identifier);

/*
								std::cout << "lex: "<< s->getName() 
										  << "token " << s->getToken()
  										  << std::endl; 
*/

								/*  If the identifier is in the table then its token is returned  */
								return s->getToken();
							}
                     }

{CADENA}			{
            			std::string aux= strdup(yytext);
            			aux=aux.substr ( 1, aux.size()-2 );
            			char* aux2 = strcpy(new char[aux.length() + 1], aux.c_str());          //  yylval.cadena =  aux;
            			yylval.cadena = aux2;
						return CADENA;
					}

"-"		{ return MINUS;  } 			/* NEW in example 3 */
"+"		{ return PLUS;   } 			/* NEW in example 3 */

"*"	    { return MULTIPLICATION; } 	/* NEW in example 3 */
"/"     { return DIVISION; } 		/* NEW in example 3 */
"//"     { return INTEGER_DIV; } 		/* Añadido por nosotros */

"("     { return LPAREN; } 			/* NEW in example 3 */
")"	    { return RPAREN; } 			/* NEW in example 3 */

":" 	{return COLON; }

"%"     { return MODULO; }			/* NEW in example 5 */

"**"	    { return POWER; }			/* Cambiado por nosotros */

":=" 	{ return ASSIGNMENT; }		/* NEW in example 7 */


"="	{ return EQUAL; }			/* NEW in example 15 */

"<>"	{ return NOT_EQUAL; }		/* NEW in example 15 */

">="	{ return GREATER_OR_EQUAL; }/* NEW in example 15 */

"<="	{ return LESS_OR_EQUAL; }	/* NEW in example 15 */

">"		{ return GREATER_THAN; }	/* NEW in example 15 */

"<"		{ return LESS_THAN; }		/* NEW in example 15 */

"!"		{ return NOT; }				/* NEW in example 15 */

"&&"	{ return AND; }				/* NEW in example 15 */

"{"		{ return LETFCURLYBRACKET; } 	/* NEW in example 17 */

"}"		{ return RIGHTCURLYBRACKET; }	/* NEW in example 17 */

"||"	{return CONCAT;}


{BIG_COMMENT} {printf("Encontrado comentario de varias lineas\n") ;}	/*Añadido por nosotros*/

{ONE_LINE_COMMENT} {printf("Encontrado comentario de una linea\n") ;}

{ERRORIDa}			{printf("\nError at the identifier. Identifier can not end with a _.\n");}

{ERRORIDb}			{printf("\nError at the identifier. Identifier must begin with a letter.\n");}

{ERRORIDc}			{printf("\nError. Indetifier can not have two _ followed by.\n");}


{ERRORDIGa}	{printf("\nExpected a number before .\n");}

{ERRORDIGb}	{printf("\nExpected a number after .");}

{SYMBOL}{IDENTIFIER}	{printf("\nError at the identifier. Identifiers do not allow that symbol: %s\n", yytext);}

{IDENTIFIER}{SYMBOL}	{printf("\nError at the identifier. Identifiers do not allow that symbol: %s\n", yytext);}

{SYMBOL}				{printf("\nError. Symbol not allowed.\n");}

^# { /* The interpreter finishes when the symbol # is written at the beginning of the line */
	// std::cout << CLEAR_SCREEN; 
	//  PLACE(24,10);
  	  std::cout <<  BIYELLOW;
   	  std::cout <<  ">>>>>>> End of program <<<<<<<";
 	  std::cout << std::endl;
   	  std::cout << RESET;
	 // PLACE(25,1);

  	  return 0;
	}

<<EOF>> { /* The interpreter finishes when finds the end of file character */
		/*  PLACE(24,10);
	  	  std::cout <<  BICYAN;
	   	  std::cout <<  ">>>>>>> End of file <<<<<<<";
	 	  std::cout << std::endl;
	   	  std::cout << RESET;
		  PLACE(25,1);
		*/
	  	  return 0;
	}


.								{ 	
									/* Any other character */
									/* MODIFIIED in example 3 */
									/* Change to error state */
									BEGIN(ERROR); 

									/* 
										The current value of yytext 
										will be concatenated with the next character
									*/
									yymore();  
								}

<ERROR>[^0-9+\-*/()\^% \t\n\;a-zA-Z=<>!&]	{ /* MODIFIED in examples 5, 7, 15 */
								  /* NEW in example 3 */
								  /* 
									The current value of yytext 
									will be concatenated with the next character
								  */
									yymore(); 
								}

<ERROR>(.|\n)                { 
								/* NEW in example 3 */
								/* Rewind one position */
								yyless(yyleng-1); 

								/* Display the error message */
								warning("Lexical error", yytext);

								/* Restore the initial state */
   								BEGIN(INITIAL);
							}
%%

