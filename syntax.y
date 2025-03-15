%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *msg);
extern int yylineno;
int yylex();
%}

%token KW TYPE IDF NUM_INT NUM_FLOAT OP_ARITH OP_ASSIGN OP_COMP PVG VIR PO PF ACOL FCOL

%%

// Structure générale du programme MiniSoft
programme: KW IDF PVG declarations bloc PVG
         { printf("Programme valide !\n"); }
         ;

declarations: KW ACOL liste_declarations FCOL
            | /* vide */
            ;

liste_declarations: declaration PVG liste_declarations
                 | declaration PVG
                 ;

declaration: TYPE liste_idf
           | TYPE IDF OP_ASSIGN expression
           ;

liste_idf: IDF VIR liste_idf
         | IDF
         ;

expression: expression OP_ARITH expression
          | expression OP_COMP expression
          | IDF
          | NUM_INT
          | NUM_FLOAT
          | PO expression PF
          ;

bloc: KW ACOL instructions FCOL
    ;

instructions: instruction PVG instructions
            | instruction PVG
            ;

instruction: affectation
           | condition
           | boucle
           | input_output
           ;

affectation: IDF OP_ASSIGN expression
           ;

condition: KW PO expression PF KW ACOL instructions FCOL
         | KW PO expression PF KW ACOL instructions FCOL KW ACOL instructions FCOL
         ;

boucle: KW ACOL instructions FCOL KW PO expression PF
      | KW IDF KW NUM_INT KW NUM_INT KW NUM_INT ACOL instructions FCOL
      ;

input_output: KW PO IDF PF
            | KW PO "message" VIR IDF PF
            ;

%%

int main() {
    printf("Entrez votre programme MiniSoft :\n");
    yyparse();
    return 0;
}

void yyerror(const char *msg) {
    printf("Erreur syntaxique à la ligne %d: %s\n", yylineno, msg);
}
