%{
/* Definition section */
#include<stdio.h>
#include<stdlib.h>
FILE *yyin,*yyout,*yyout1;
int flag=0;
%}

%token NUMBER TYPE1 TYPE2 MAIN PLUS MINUS MUL DIV EQUAL SEMI OPEN_PAREN1 CLOSE_PAREN1 OPEN_PAREN2 CLOSE_PAREN2 COMMA KEYWORD1 KEYWORD2 KEYWORD3 EQUALS NTEQUALS GTEQUALS LTEQUALS GTHN LTHN RETURN USELESS
%union 
{
        int number;
        char *string;
}

%token<string> ID

/* Rule Section */
%%

Program : | TYPE1 MAIN {fprintf(yyout1,"Function identifier : main\n");} OPEN_PAREN1 listofpara CLOSE_PAREN1 OPEN_PAREN2 Statements CLOSE_PAREN2 Program 
          |  Function Program ;

Function : TYPE ID  conf3;
conf3 : OPEN_PAREN1 {fprintf(yyout1,"Function identifier - %s\n",yylval);} listofpara CLOSE_PAREN1 conf | EQUAL {fprintf(yyout1,"global variable - %s  = ",yylval);} expre SEMI {fprintf(yyout1,"\n",yylval);} ;

conf : SEMI | OPEN_PAREN2 Statements CLOSE_PAREN2 ;     

TYPE : TYPE1|TYPE2;
listofpara : | listofparas ;
listofparas : TYPE ID {fprintf(yyout1, "Funtion Parameter - %s\n",yylval);} | TYPE ID {fprintf(yyout1, "Funtion Parameter- %s , ",yylval);} COMMA listofpara  ;

Statements : /*EMPTY*/ | Statements statement ;

statement : if_statement | declrstmt | arithexp SEMI | whilloop  | returnstmt | funccall  ;

if_statement : KEYWORD1 {fprintf(yyout1,"key word - if\n");} OPEN_PAREN1 boolexp CLOSE_PAREN1  OPEN_PAREN2 Statements CLOSE_PAREN2 conf1 {fprintf(yyout1,"end-if\n");};
               
conf1 : | KEYWORD2 {fprintf(yyout1,"key word - else\n");} OPEN_PAREN2 Statements CLOSE_PAREN2 ;


declrstmt : TYPE1 {fprintf(yyout1,"Type - int ");} ID {fprintf(yyout1," (identifier - %s)  ",yylval);} conf2 {fprintf(yyout1,": declaration statement\n");} |
            TYPE2  {fprintf(yyout1,"Type - char * ");} ID {fprintf(yyout1," (identifier - %s)  ",yylval);} SEMI {fprintf(yyout1,": declaration statement\n");};
conf2 : SEMI | EQUAL expre SEMI;

Expr : NUMBER {fprintf(yyout1,"(Constant = %d)",yylval);} | ID {fprintf(yyout1," (identifier - %s )",yylval);} ;
boolexp : Expr EQUALS {fprintf(yyout1," == ");} Expr {fprintf(yyout1," : boolean expression\n");}|
          Expr NTEQUALS {fprintf(yyout1," != ");} Expr {fprintf(yyout1," : boolean expression\n");} |
          Expr LTEQUALS {fprintf(yyout1," <= ");} Expr {fprintf(yyout1," : boolean expression\n");} |
          Expr GTEQUALS {fprintf(yyout1," >= ");} Expr {fprintf(yyout1," : : boolean expression\n");} |
          Expr LTHN {fprintf(yyout1," > ");} Expr {fprintf(yyout1," : boolean expression\n");} |
          Expr GTHN {fprintf(yyout1," < ");} Expr {fprintf(yyout1," : boolean expression\n");} |
          expre {fprintf(yyout1," : boolean expression\n");}
          ;
          

arithexp : ID {fprintf(yyout1," (identifier - %s)  ",yylval);} EQUAL {fprintf(yyout1," = ");} expre {fprintf(yyout1, ": arithmatic expression\n");} ;

expre : expre PLUS {fprintf(yyout1," + ");} term |
        expre MINUS {fprintf(yyout1," - ");} term |
        term ;
term : term MUL {fprintf(yyout1," * ");} factor |
       term DIV {fprintf(yyout1," / ");} factor |
       factor ;
factor : OPEN_PAREN1 expre CLOSE_PAREN1 | ID {fprintf(yyout1," (identifier - %s) ",yylval);} | NUMBER {fprintf(yyout1,"(Constant = %d)",yylval);};

whilloop : KEYWORD3 {fprintf(yyout1,"key word - while\n");} OPEN_PAREN1 boolexp CLOSE_PAREN1 OPEN_PAREN2 Statements CLOSE_PAREN2  {fprintf(yyout1,"loop-end\n");}; ;

returnstmt : RETURN {fprintf(yyout1,"key word - return ");} expre SEMI {fprintf(yyout1,": return statement\n");};

funccall : ID {fprintf(yyout1,"Function call : %s\n",yylval);} OPEN_PAREN1 listofexpr CLOSE_PAREN1 SEMI;
listofexpr :  | listofexprs {fprintf(yyout1," ->Input Parameters\n");};
listofexprs : expre | expre COMMA listofexprs ;

%%

//driver code
void main(int argc , char ** argv)
{
yyin = fopen(argv[1],"r");
yyout = fopen("lexer.txt","w");
yyout1 = fopen("Parser.txt","w");

yyparse();
yylex();
if(flag==0){
fprintf(yyout,"Code is Valid\n");
fprintf(yyout1,"Code is Valid\n");
}
}

void yyerror()
{
fprintf(yyout,"Entered code is Invalid\n");
fprintf(yyout1,"Entered code is Invalid\n");
exit(0);
flag=1;
}

