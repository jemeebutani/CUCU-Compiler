%{
#include<stdio.h>

extern FILE *yyin,*yyout;
FILE *yypharse;
extern char *yytext;
int yylex();
void yyerror(char *s){fprintf(yyout,"ERROR \n");}
%}

%union{
int number;
char *str;
}

%token WHILE IF RETURN INT CHARP COMMA SEMICOL PLUS MINU MUL DIV EQ NQ ASS LPAR RPAR LBRA RBRA LSQU RSQU ID NUM STRING
%token<str> ID
%token<number> NUM
%token<str> STRING

%%

prog : 	stmts
	;
stmts :	stmt 
	| stmts stmt
	;
stmt :	exp SEMICOL		{fprintf(yypharse,"exp : \n");}
	| var_dec SEMICOL	{fprintf(yypharse,"variable declaration : \n");}
	| fun_dec SEMICOL	{fprintf(yypharse,"function declaration : \n");}
	| fun_def 		{fprintf(yypharse,"function defination : \n");}
	| fun_call SEMICOL	{fprintf(yypharse,"function call : \n");}
	| if_stmt		{fprintf(yypharse,"if statment  \n");}
	| while_stmt		{fprintf(yypharse,"while statment \n");}
	;

exp : 	equ EQ equ 		{fprintf(yypharse,"boolean expression \n");}
	| equ NQ equ 		{fprintf(yypharse,"boolean expression \n");}
	| assignment		{fprintf(yypharse,"assignment expression \n");}
	| equ			{fprintf(yypharse,"simple expression \n");}
	;

data :	NUM		{fprintf(yypharse,"const number : %d \n",$1);}
	| ID		{fprintf(yypharse,"variable : %s \n",$1);}
	| STRING	{fprintf(yypharse,"string : %s \n",$1);}
	| ID LSQU exp RSQU	{fprintf(yypharse,"variable : %s \n",$1);}
	;
		
assignment :	ID ASS equ	{fprintf(yypharse,"variable : %s = \n",$1);}
		;
equ :	equ PLUS term		{fprintf(yypharse,"operator : + \n");}
	| equ MINU term		{fprintf(yypharse,"operator :  - \n");}
	| term
	;
term : 	term MUL factor		{fprintf(yypharse,"operator :  * \n");}
	| term DIV factor	{fprintf(yypharse,"operator :  / \n");}
	| factor
	;
factor :	LPAR equ RPAR
		| data
		;

id_list :	ID 			{fprintf(yypharse,"variable : %s = \n",$1);}
		| ID COMMA id_list
		;
		
ass_list :	assignment 
		| assignment COMMA assignment
		;
data_type :	INT		{fprintf(yypharse,"variable type int \n");}
		| CHARP		{fprintf(yypharse,"variable type char pointer \n");}
		;
var_dec :	data_type id_list
		| data_type ass_list
		;
fun_dec :	data_type ID LPAR arg_list RPAR		{fprintf(yypharse,"function defination\n");} 
		| data_type ID LPAR RPAR 		{fprintf(yypharse,"function defination\n");} 
		;
exp_list : 	exp
		| exp COMMA exp_list
		;

fun_call : 	ID LPAR exp_list RPAR 	{fprintf(yypharse,"function call\n");} 
		| ID LPAR RPAR		{fprintf(yypharse,"function call\n");} 
		|
		;
arg_list :	data_type ID
		| data_type ID COMMA arg_list
		;
fun_def	: 	data_type ID LPAR arg_list RPAR LBRA stmts RETURN exp SEMICOL RBRA	{fprintf(yypharse,"function end\n");} 
		| data_type ID LPAR RPAR LBRA stmts RETURN exp SEMICOL RBRA		{fprintf(yypharse,"function end\n");} 
		;
if_stmt :	IF LPAR exp RPAR stmt			{fprintf(yypharse,"if statmant\n");} 
		| IF LPAR exp RPAR LBRA stmts RBRA	{fprintf(yypharse,"if statmant\n");} 
		;
while_stmt :	WHILE LPAR exp RPAR stmt		{fprintf(yypharse,"while statmant\n");} 
		| WHILE LPAR exp RPAR LBRA stmts RBRA	{fprintf(yypharse,"while statmant\n");} 
		;
		
%%

int main(int argc,char *argv[])
{
    yyin=fopen(argv[1],"r");
    yypharse=fopen("Parser.txt","w");
    yyout=fopen("Laxer.txt","w");
    //yylex();
    yyparse();

    return 0;
}