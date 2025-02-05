%{
    #include <stdio.h>
    #include "y.tab.h"
%}
%option noyywrap

alpha [a-zA-Z]
digit [0-9]
incr "++"
decr "--"

%%

"start_global"              { return STARTGLOBAL; }
"end_global"                { return ENDGLOBAL; }
"start_functions"           { return STARTFUNCTIONS; }
"end_functions"             { return ENDFUNCTIONS; }
"start_program"             { return STARTPROGRAM; }
"end_program"               { return ENDPROGRAM; }

"Print"                     { return PRINT; }
"function"                  { return FUNCTION; }
"const"                     { return CONST; }
"int"|"float"|"bool"        { yylval.str = strdup(yytext); return DATATYPE; }
"char"                      { yylval.str = strdup(yytext); return CHAR; }  
"string"                    { yylval.str = strdup(yytext); return STRING; }
"return"                    { return RETURN; }
"for"	                    { return FOR; }
"if"	                    { return IF; }
"while"                     { return WHILE; }
"else"	                    { return ELSE; }
"->"                        { return ASSIGN; }

"TRUE"                      { yylval.boolnum = 1; return BOOL_VALUE; }             
"FALSE"                     { yylval.boolnum = 0; return BOOL_VALUE; }

"<="                        { return LE; }
">="                        { return GE; }
"=="                        { return EQ; }
"!="                        { return NE; }
">"	                        { return GT; }
"<"	                        { return LT; }
"&&"	                    { return AND; }
"||"	                    { return OR; }
"+"                         { yylval.str = strdup(yytext); return PLUS; }
"-"                         { yylval.str = strdup(yytext); return MINUS; }
"/"                         { yylval.str = strdup(yytext); return DIV; }
"*"                         { yylval.str = strdup(yytext); return PROD; }
"::"                        { return DOUBLE; }
"newtype"                   { return TYPE; }

[-]?{digit}+                                { yylval.intnum = atoi(yytext); return NUMBER; }
[-]?{digit}+\.{digit}{1,6}                  { yylval.flnum = atof(yytext); return FLOAT_NUM; }
["].*["]                                    { yylval.str = strdup(yytext); return STR; }
['].[']                                     { yylval.str = strdup(yytext); return CHARACTER; }
{alpha}({alpha}|{digit})*                   { yylval.str = strdup(yytext); return ID; }
"++"|"--"                                   { yylval.str = strdup(yytext); return UNARY; }

\/\/.*                      { ; }
\/\*(.*\n)*.*\*\/           { ; } 
[ \t]                        ;
\n                          {yylineno++;}
.                           {return yytext[0];}
%%
