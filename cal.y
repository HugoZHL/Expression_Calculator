/*
	Programmer: Hugo Zhang
	Student ID: 1600012945
	Date: 2018/10/9
*/

%{
    #include <stdio.h>
    #include <stdlib.h>
    #define YYSTYPE double
    int yylex(void);
    int yyerror(char *msg);
%}
%token NUMBER SEPARATOR


%%


multirow:
	  multirow SEPARATOR row { printf("\n"); }
	| row { printf("\n"); }
	;
row:
	  expr '=' { printf("%g", $1); }
	;
expr:
	  expr '+' term { $$ = $1 + $3; }
	| expr '-' term { $$ = $1 - $3; }
	| term { $$ = $1; }
	;
term:
	  term '*' fac { $$ = $1 * $3; }
	| term '/' fac { if($3 == 0) { char msg[20] = "Divided by zero!"; yyerror(msg); exit(0); } else $$ = $1 / $3; }
	| fac { $$ = $1; }
	;
fac:
	  '(' expr ')' { $$ = $2; }
	| NUMBER { $$ = $1; }
	;


%%


int main(void)
{
    printf("\nThis is a row-expression calculator, \n"
           "in which you can use +, -, *, / and brackets to form an expression.\n"
           "The numbers involved are regarded as double type.\n"
           "At the end of every expression you must add an eq operator (=).\n"
           "You can use semicolon or Enter to implement multiple expressions.\n"
           "If you want to exit, please press Ctrl+Z.\n\n");
    yyparse();
    return 0;
}

int yyerror(char *msg)
{
    printf("Error encountered: %s \n", msg);
}
