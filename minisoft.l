%{
#include <stdio.h>
#include "minisoft.tab.h"
%}

%%


"let"       { return LET; }
"if"        { return IF; }
"else"      { return ELSE; }
"for"       { return FOR; }
"do"        { return DO; }
"while"     { return WHILE; }
"input"     { return INPUT; }
"output"    { return OUTPUT; }
"@define"   { return DEFINE; }
"AND"       { return AND; }
"OR"        { return OR; }


[a-zA-Z][a-zA-Z0-9_]{0,13}   { return IDF; }


[0-9]+             { return INT; } 
[0-9]+\.[0-9]+     { return FLOAT; } 
\(\+?[0-9]+\)      { return INT; }
\(\+?[0-9]+\.[0-9]+\) { return FLOAT; }


"+"    { return PLUS; }
"-"    { return MINUS; }
"*"    { return MULT; }
"/"    { return DIV; }
"=="   { return EQ; }
"!="   { return NEQ; }
">"    { return GT; }
"<"    { return LT; }
">="   { return GTE; }
"<="   { return LTE; }
"!"    { return NOT; }


";"   { return SEMICOLON; }
":="  { return ASSIGN; }
"["   { return LBRACKET; }
"]"   { return RBRACKET; }
"{"   { return LBRACE; }
"}"   { return RBRACE; }


"< !-"[^-]*"-!>"    { }  
"{--"(.|\n)*"--}"   { }  

[ \t\r\n]+  { }  


.  { printf("Unexpected character: %s\n", yytext); }

%%



int yywrap() { return 1; }
