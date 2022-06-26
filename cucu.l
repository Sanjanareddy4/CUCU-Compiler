%{
/* Definition section */
#include<stdio.h>
#include "cucu.tab.h"

%}

/* Rule Section */
%%
" " ;
"+" {fprintf(yyout,"PLUS : +\n");return PLUS;};
"*" {fprintf(yyout,"MUL : *\n");return MUL;};
"-" {fprintf(yyout,"MINUS : -\n");return MINUS;};
"/*"([^*]|\*+[^*/])*\*+"/" ;
\/\/.* ;
\\ {fprintf(yyout,"DIV : \\ \n");return DIV;};
"==" {fprintf(yyout,"EQUALS : ==\n");return EQUALS;};
"!=" {fprintf(yyout,"NTEQUALS : !=\n");return NTEQUALS;};
">=" {fprintf(yyout,"GTEQUALS : >=\n");return GTEQUALS;};
"<=" {fprintf(yyout,"LTEQUALS : <=\n");return LTEQUALS;};
">" {fprintf(yyout,"GTHN : >\n");return GTHN;};
"<" {fprintf(yyout,"LTHN : <\n");return LTHN;};
"=" {fprintf(yyout,"EQUAL : =\n");return EQUAL;};
";" {fprintf(yyout,"SEMI : ;\n");return SEMI;};
"(" {fprintf(yyout,"OPEN_PAREN1 : (\n");return OPEN_PAREN1;};
")" {fprintf(yyout,"CLOSE_PAREN1 : )\n");return CLOSE_PAREN1;};
"{" {fprintf(yyout,"OPEN_PAREN2 : {\n");return OPEN_PAREN2;};
"}" {fprintf(yyout,"CLOSE_PAREN2 : }\n");return CLOSE_PAREN2;};
"," {fprintf(yyout,"COMMA : ,\n");return COMMA;};
(^r|r)eturn {fprintf(yyout,"RETURN : return\n");return RETURN;};
main {fprintf(yyout,"MAIN : main\n");return MAIN;};
(^i|i)f {fprintf(yyout,"KEYWORD1 : if\n");return KEYWORD1;};
(^e|e)lse {fprintf(yyout,"KEYWORD2 : else\n");return KEYWORD2;};
(^w|w)hile {fprintf(yyout,"KEYWORD3 : while\n");return KEYWORD3;}
[0-9]+ {yylval.number = atoi(yytext);fprintf(yyout,"NUMBER : %d\n",yylval);return NUMBER;};
((^i)|(i))nt {fprintf(yyout,"TYPE1 : int\n");return TYPE1;};
(^c|c)har((" ")*)\* {fprintf(yyout,"TYPE2 : char *\n");return TYPE2;};
^([a-zA-Z][a-zA-Z0-9_]*\[[A-Za-z0-9]*\]) {yylval.string = strdup(yytext);fprintf(yyout,"ID : %s\n",yytext);return ID;};
([a-zA-Z][a-zA-Z0-9_]*)\[[A-Za-z0-9]*\] {yylval.string = strdup(yytext);fprintf(yyout,"ID : %s\n",yytext);return ID;};
^([a-zA-Z][a-zA-Z0-9_]*) {yylval.string = strdup(yytext);fprintf(yyout,"ID : %s\n",yytext);return ID;};
[a-zA-Z][a-zA-Z0-9_]* {yylval.string = strdup(yytext);fprintf(yyout,"ID : %s\n",yytext);return ID;};
[\t] ;

[\n] ;

%%

int yywrap()
{
return 1;
}
