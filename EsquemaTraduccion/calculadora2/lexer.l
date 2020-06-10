%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "y.tab.h"
%}

ent [0-9]{1,31}
id  [a-zA-Z_][a-zA-Z_0-9]{0,30}

%%
";"     {return PYC;}
"+"     {return MAS;}
"="     {return ASIG;}
"*"     {return MUL;}
"("     {return LPAR;}
")"     {return RPAR;}
{ent}   { 
            strcpy(yylval.dir, yytext); 
            return NUM; 
        }
{id}    { 
            strcpy(yylval.dir, yytext); 
            return ID; 
        }
[ \t\n\r]   {}
.       { printf("Error Léxico %s\n", yytext); }

%%

int yywrap() {
    return 1;
}