%{
//#define YYSTYPE int
#include "str.h"
#include "e.tab.h"

#include <stdlib.h>
%}

%option noyywrap yylineno 


NUMBER   -?[0-9]+
FUNC_NAME [_a-zA-Z][_a-zA-Z0-9]*

%%

{NUMBER} 	{//printf ("L: num \n");
 yylval.val = atoi(yytext); return NUM;}
{FUNC_NAME} {//printf("L: func_name \n"); 
yylval.type = str_to_enum(yytext); return FUNC;}
[\(\)\,] 	{return yytext[0];}



[ \t\n]+              /* игнор пробелов */

%%