%{
#include <stdio.h>
#include <string.h>
#include "y.tab.h"
%}

%option noyywrap

id [a-zA-Z_][a-zA-Z_0-9]*
esp [ \n\t\r]

%%
int     { return INT; }
float   { return FLOAT; }
{id}    { 
            strcpy(yylval.id, yytext);
            return ID; 
        }
","     { return COMA; }
";"     { return PYC; }
{esp}+  {}
.       { printf("Error Léxico: %s", yytext); }
%%
