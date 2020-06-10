#define PYC 257
#define ID 258
#define NUM 259
#define ASIG 260
#define MAS 261
#define MUL 262
#define LPAR 263
#define RPAR 264
#ifdef YYSTYPE
#undef  YYSTYPE_IS_DECLARED
#define YYSTYPE_IS_DECLARED 1
#endif
#ifndef YYSTYPE_IS_DECLARED
#define YYSTYPE_IS_DECLARED 1
typedef union{
    char dir[32]; 
} YYSTYPE;
#endif /* !YYSTYPE_IS_DECLARED */
extern YYSTYPE yylval;
