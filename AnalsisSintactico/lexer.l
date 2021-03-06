%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "y.tab.h"
%}

ent [0-9]+
%option noyywrap

%%

"+"     {return MAS;}
"*"     {return MUL;}
"("     {return LPAR;}
")"     {return RPAR;}
{ent}   { 
            yylval.val = atoi(yytext); 
            return NUMERO; 
        }
"\n"    { return NL; }
[ \t]   {}
.       { printf("Error Léxico %s\n", yytext); }

%%