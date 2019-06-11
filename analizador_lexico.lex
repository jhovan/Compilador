
%{
#include <stdio.h>
#include <ctype.h>
#include <string.h>

int lineas = 1;
%}

digito [0-9]
letra [a-zA-Z]
letra_ {letra}|_
entero {digito}+
decimal {digito}*\.{digito}+|{digito}+\.{digito}*
real {decimal}|(({decimal}|{digito}+)[Ee](\+|-)?{digito}+)
id {letra_}({letra_}|{digito})*
reservadas if|then|else|while|do|case|is|void|true|false|begin|end|not
espacio [ \t]+
aritmetico \+|-|\*|\/|%
relacional ¿|¡|¡¿|=
asignacion :=
especiales \(|\)|\{|\}|;|,

%x cadena
%x comentario_s
%x comentario_m

%%

{reservadas} {fprintf(yyout,"<Palabra Reservada,\"%s\">\n",yytext);}
{entero} {fprintf(yyout,"<Numero Entero,\"%s\">\n",yytext);}
{real} {fprintf(yyout,"<Numero Real,\"%s\">\n",yytext);}
{id} {fprintf(yyout,"<Identificador,\"%s\">\n",yytext);}
{espacio} {fprintf(yyout,"<Espacio en Blanco,\"%s\">\n",yytext);}
{aritmetico} {fprintf(yyout,"<Operador Aritmetico,\"%s\">\n",yytext);}
{relacional} {fprintf(yyout,"<Operador Relacional,\"%s\">\n",yytext);}
{asignacion} {fprintf(yyout,"<Operador de Asignacion,\"%s\">\n",yytext);}
{especiales} {fprintf(yyout,"<Caracter Especial,\"%s\">\n",yytext);}
<INITIAL,cadena>\n {lineas++;}

("<")("*")+ {fprintf(yyout,"<Comentario multilinea, \"<*");BEGIN(comentario_m);}
<comentario_m>[^*\n]* {fprintf(yyout,yytext);}
<comentario_m>"*"+[^*>\n]* {fprintf(yyout,yytext);}
<comentario_m>\n {fprintf(yyout,"\\n");}
<comentario_m>"*"+">" {fprintf(yyout,"*>\" >\n");BEGIN(INITIAL);}

"--" {BEGIN(comentario_s);}
<comentario_s>[^\n]* {fprintf(yyout,"<Comentario, \"--%s\">\n",yytext);}
<comentario_s>\n {lineas++;BEGIN(INITIAL);}

\" {BEGIN(cadena);}
<cadena>[^\"]* {fprintf(yyout,"<Cadena,\"%s\">\n",yytext);}
<cadena>\" {BEGIN(INITIAL);}

. {fprintf(yyout,"Ha ocurrido un error lexico producido por \"%s\" en la linea %i\n", yytext,lineas);}


%%



int main(int argc , char **argv){ 
	FILE *f, *o;
	f = fopen(argv[1],"r");
	yyin = f;
	f = fopen("salida.txt","w");
	yyout = f;
	yylex ();
	return 0;
}