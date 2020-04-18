%{
    #include <stdio.h>
    #include <string.h>
    #include <stdlib.h>

    void error(char *);
%}

%option yylineno
%option noyywrap
%s COMENTARIO
%x COMENTARIO2

letra   [a-zA-Z]
letra_  {letra}|_
digito  [0-9]
id      {letra_}({letra_}|{digito})*
id_h    "#"{id}
pr      "@"(if|else|while)
op_asig "="
op_arit ("+"|"-"|"*"|"/"|"%")
op_rel  (">"|"<"|">="|"<="|"=="|"!=")
op_log  ("&&"|"||"|"!")
spt     ("{"|"}"|"("|")"|";"|",")
entero  ({digito})+
exp     [Ee][+-]?{entero}+
real    ({digito})*"."({digito})+|({digito})+"."({digito})*
flotante ({real}{exp}?|{entero}{exp})[Ff]
%%
<INITIAL>{id_h}    { printf("ID H: %s, LINE: %d\n", yytext, yylineno); }
<INITIAL>{pr}    { printf("Palabra Reservada: %s, LINE: %d\n", yytext, yylineno); }
<INITIAL>{op_asig}    { printf("Asignación: %s, LINE: %d\n", yytext, yylineno); }
<INITIAL>{op_arit}    { printf("Operación aritmética: %s, LINE: %d\n", yytext, yylineno); }
<INITIAL>{op_rel}    { printf("Operación Relacional: %s, LINE: %d\n", yytext, yylineno); }
<INITIAL>{op_log}    { printf("Operación Lógica: %s, LINE: %d\n", yytext, yylineno); }
<INITIAL>{spt}    { printf("Símbolo de puntación: %s, LINE: %d\n", yytext, yylineno); }
<INITIAL>{flotante}    { printf("FLotante: %s, LINE: %d\n", yytext, yylineno); }
<INITIAL>{entero}    { printf("Entero: %s, LINE: %d\n", yytext, yylineno); }
<INITIAL>{id}   { printf("ID: %s, LINE: %d\n", yytext, yylineno); }
<INITIAL>[ \t\n\r]+ {/*Ignora espacios en blaco*/}
<INITIAL>"/*"    {BEGIN(COMENTARIO);}
<INITIAL>.  {error(yytext);}
<COMENTARIO>[^*/]* {}
<COMENTARIO>[*/] {printf("casi");}
<COMENTARIO>"*/"    {BEGIN(INITIAL);}
%%

void error(char *s){
    printf("Error lexico: %s en la linea %d\n", s, yylineno);
}

int main(int argc, char **argv){
    FILE *f;
    if(argc < 2){
        printf("Falta archivo\n");
        exit(-1);
    }
    f = fopen(argv[1], "r");
    if(!f){
        printf("No se puede abrir el archivo\n");
        exit(-1);
    }
    yyin = f;  /* Todo lo que empiece con yy es hecho por lex*/
    int tok = yylex();
    while(tok != 0){ /*fin de archivo retorna cero */
        tok = yylex();
    }
    return 0;
}