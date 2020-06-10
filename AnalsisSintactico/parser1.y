%{
#include <stdio.h>
#include <string.h>
void yyerror(char* s);
extern int yylex();
%}

%union{
    int val; 
}

%token NL
%token<val> NUMERO

%left MAS 
%left MUL
%nonassoc LPAR RPAR

%type<val> exp term factor line

%start line

%%
line: 
    exp NL { $$ = $1; printf("%d\n", $$); }
    ;

exp:
    exp MAS term { $$ = $1 + $3; } 
    | term { $$ = $1; }
    ;

term: 
    term MUL factor { $$ = $1 * $3; } 
    | factor { $$ = $1; }
    ;

factor: 
    LPAR exp RPAR { $$ = $2; } 
    | NUMERO { $$ = $1; }
    ;
%%    

void yyerror(char* s) {
    printf("Error Sintáctico: %s\n", s);
}