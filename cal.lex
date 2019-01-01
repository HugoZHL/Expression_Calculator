/*
	Programmer: Hugo Zhang
	Student ID: 1600012945
	Date: 2018/10/9
*/

%{
    #define YYSTYPE double
    #include "1600012945.tab.h"
    #include <stdio.h>
    #include <stdlib.h>
    extern int yyerror(char* msg);
%}

number [0-9]*\.?[0-9]+
operator "+"|"-"|"*"|"/"|"("|")"|"="
separator ";"|\n
whitespace " "


%%


{number} { yylval = atof(yytext); return NUMBER; };
{operator} { return *yytext; };
{separator} { yylval = *yytext; return SEPARATOR; };
{whitespace} {};


%%


int yywrap(void)
{
    return 1;
}
