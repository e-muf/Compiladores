%{
#include <stdio.h>
int tipo;
extern int yylex();
void yyerror(char *s);
%}

%union {
    int tipo;
    char id[32];
}

%token<id> ID
%token COMA PYC
%token INT FLOAT

%type<tipo> type

%start decl

%%
decl: decl type { tipo = $2; } list PYC
    | ;

type: INT { $$ = 0; }
    | FLOAT { $$ = 1; };

list: list COMA ID { printf("El tipo de %s es %d\n", $3, tipo); }
    | ID { printf("El tipo de %s es %d\n", $1, tipo); };
%%

void yyerror(char *s) {
    printf("%s\n", s);
}