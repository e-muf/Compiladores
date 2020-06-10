%{
#include <stdio.h>
#include <string.h>
void yyerror(char* s);
extern int yylex();
void nuevaTemp(char *dir);
int temp; // Contador global de temporales
%}

%union{
    char dir[32]; 
}

%token PYC
%token<dir> ID
%token<dir> NUM
%left ASIG
%left MAS 
%left MUL
%nonassoc LPAR RPAR

%type<dir> exp term factor

%start sent

%%
sent: ID ASIG exp PYC { 
        printf("%s = %s\n", $1, $3); 
    };

exp: exp MAS term { 
        nuevaTemp($$);
        printf("%s = %s + %s\n", $$, $1, $3); 
    } 
   | term { strcpy($$, $1); }
    ;

term: term MUL factor { 
        nuevaTemp($$);
        printf("%s = %s * %s\n", $$, $1, $3); 
    } 
    | factor { strcpy($$, $1);  }
    ;

factor: LPAR exp RPAR { strcpy($$, $2);  } 
    | NUM { strcpy($$, $1);  }
    | ID { strcpy($$, $1);  }
    ;
%%    

void yyerror(char* s) {
    printf("Error Sintáctico: %s\n", s);
}

void nuevaTemp(char *dir) {
    char t[32];
    sprintf(t, "t%d", temp++);
    strcpy(dir, t);
}