%{
#include <stdlib.h>
#include<stdio.h>
#include "cucu.tab.h"
extern FILE *yyout,*yyin;

%}


%%    

"while"		{fprintf(yyout,"Keyword : while \n"); return WHILE;}
"if"		{fprintf(yyout,"Keyword : if \n");return IF;}
"return"	{fprintf(yyout,"Keyword : return \n");return RETURN;}
"int"		{fprintf(yyout,"Data Type : int \n");return INT;}
"char *"	{fprintf(yyout,"Data type : char pointer \n");return CHARP;}
","		{fprintf(yyout,"Comma : ,\n");return COMMA;}
";"		{fprintf(yyout,"Semicolon : ;\n");return SEMICOL;}
"+"		{fprintf(yyout,"Arithmetic Operator(addition) : +\n");return PLUS;}
"-"		{fprintf(yyout,"Arithmetic Operator(subtraction) : -\n");return MINU;}
"*"		{fprintf(yyout,"Arithmetic Operator(multiplication) : *\n");return MUL;}
"/"		{fprintf(yyout,"Arithmetic Operator(division) : /\n");return DIV;}
"=="		{fprintf(yyout,"Relational Operator : ==\n");return EQ;}
"!="		{fprintf(yyout,"Relational Operator : !=\n");return NQ;}
"="		{fprintf(yyout,"Assignment : = \n");return ASS;}
"("		{fprintf(yyout,"Left parenthesis : ( \n");return LPAR;}
")"		{fprintf(yyout,"Right parenthesis : )\n");return RPAR;}
"{"		{fprintf(yyout,"Left Braces : {\n");return LBRA;}
"}"		{fprintf(yyout,"Right Braces: }\n");return RBRA;}
"["		{fprintf(yyout,"Left Square bracket : [ \n");return LSQU;}
"]"		{fprintf(yyout,"Right Square bracket : ] \n");return RSQU;}
[a-zA-Z][a-zA-Z0-9_]*		{yylval.str=strdup(yytext);fprintf(yyout,"Identifier : %s \n",yytext);return ID;}
[0-9]+		{yylval.number=atoi(yytext);fprintf(yyout,"Number : %d \n",atoi(yytext));return NUM;}
["][a-zA-Z0-9]*["]	{yylval.str=strdup(yytext);fprintf(yyout,"String : %s \n",yytext);return STRING;}
[ \t\n]+       ; 
.            {fprintf(yyout,"ERROR \n");}
%%
int yywrap(void) {
 return 1;
}
