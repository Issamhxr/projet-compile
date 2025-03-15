%{
#include "syntax.tab.h" // Inclusion du fichier BISON
#include <stdio.h>
#include <stdlib.h>

extern int yylineno; // Numéro de ligne
%}

%option noyywrap

// Définition des types de tokens
KW  (MainPrgm|Var|BeginPg|EndPg|let|if|else|do|while|for|step|from|input|output)
TYPE (Int|Float)
IDF [a-zA-Z][a-zA-Z0-9_]{0,13}
NUM_INT -?[0-9]+
NUM_FLOAT -?[0-9]+\.[0-9]+
OP_ARITH [\+\-\*/]
OP_ASSIGN :=
OP_COMP (==|!=|<=|>=|<|>)
COMMENT_LINE "< !-"[^-]*"- !>"
COMMENT_BLOCK "{--"(.|\n)*"--}"

%%

// Mots-clés
{KW}         { return KW; }
{TYPE}       { return TYPE; }

// Identificateurs
{IDF}        { return IDF; }

// Constantes numériques
{NUM_INT}    { return NUM_INT; }
{NUM_FLOAT}  { return NUM_FLOAT; }

// Opérateurs
{OP_ARITH}   { return OP_ARITH; }
{OP_ASSIGN}  { return OP_ASSIGN; }
{OP_COMP}    { return OP_COMP; }

// Délimiteurs
";"          { return PVG; }
","          { return VIR; }
"("          { return PO; }
")"          { return PF; }
"{"          { return ACOL; }
"}"          { return FCOL; }

// Commentaires (ignorés)
{COMMENT_LINE}    { /* Ignorer */ }
{COMMENT_BLOCK}   { /* Ignorer */ }

// Espaces et retours à la ligne
[ \t\r]+     { /* Ignorer les espaces */ }
\n           { yylineno++; } // Incrémenter le numéro de ligne

.            { printf("Erreur lexicale à la ligne %d: caractère inconnu '%s'\n", yylineno, yytext); }

%%

int yywrap() {
    return 1;
}
