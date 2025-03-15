%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *msg);
int yylex();
%}

%token LET IF ELSE FOR DO WHILE INPUT OUTPUT DEFINE
%token IDF INT FLOAT
%token PLUS MINUS MULT DIV EQ NEQ GT LT GTE LTE NOT AND OR
%token SEMICOLON ASSIGN LBRACKET RBRACKET LBRACE RBRACE
%token STEP TO

%left OR
%left AND
%left EQ NEQ GT LT GTE LTE
%left PLUS MINUS
%left MULT DIV
%right NOT

%%

program: statement_list { printf("Syntax is correct!\n"); };

statement_list: statement SEMICOLON statement_list
              | statement SEMICOLON
              ;

statement: variable_declaration
         | assignment
         | condition
         | loop
         | input_output
         ;

variable_declaration: LET IDF ASSIGN expression
                    | LET IDF
                    ;

assignment: IDF ASSIGN expression
          ;

condition: IF expression LBRACE statement_list RBRACE %prec IF
         | IF expression LBRACE statement_list RBRACE ELSE LBRACE statement_list RBRACE
         ;

loop: WHILE expression LBRACE statement_list RBRACE
    | FOR IDF ASSIGN expression TO expression STEP expression LBRACE statement_list RBRACE
    ;

input_output: INPUT LBRACKET IDF RBRACKET
            | OUTPUT LBRACKET IDF RBRACKET
            ;

expression: expression PLUS expression
          | expression MINUS expression
          | expression MULT expression
          | expression DIV expression
          | IDF
          | INT
          | FLOAT
          ;

%%

int main() {
    printf("Enter your MiniSoft code:\n");
    yyparse();
    return 0;
}

void yyerror(const char *msg) {
    printf("Syntax Error: %s\n", msg);
}
