/*
*Compiladores
*Proyecto Final
*
*Guerrero Chávez Diana Lucía
*Sánchez del Moral Adriana 
*Gallardo Valdez José Jhovan 
*
*Creado el 14 de Junio 2019
*
*Analizador Léxico que reconoce la gramática dada en las especificaciónes del proyecto
*
*Las palabras reservadas (int, float, double etc) se tradujeron al español para evitar conflictos con el lenguaje que utilizaremos para implementar en analizador
*
*Recibe como entrada un archivo de texto y consume caracteres hasta que llegue al final del archivo
*Compilar con: flex analizadorLexico.lex 

 gcc lex.yy.c -o analizadorLexico -lfl

Ejecutar con: 
./analizadorLexico programita.txt 


*/

%{
#include <stdio.h>

%}

/*Definiciones:*/
digito	[0-9]
espacio	[ \t]+
entero	{digito}+
float	{digito}*\.{digito}+|{digito}+\.{digito}*
double	{decimal}|(({decimal}|{digito}+)[Ee](\+|-)?{digito}+)
char	"char"
void	"void"
struct	"struct"
if	"if"
else	"else"
while	"while"
do	"do"
return	"return"
switch	"swich"
break	"break"
print	"print"
case	"case"
default	"default"
true	"true"
false	"false"
cadena	[^\n]
caracter [a-zA-Z]
caracter_ {caracter}|_
or	[||]
and	[&&]
not	[!]
id	{caracter_}({caracter_}|{digito})*
aritmetico	\+|-|\*|\/|%
relacional	¿|¡|¡¿|=
asignacion	:=
especiales	\(|\)|\{|\}|;|,



%x cadena
%x comentario_s
%x comentario_m

/*Expresiones Regulares:*/
%%
{espacio}	{/*omite los espacios*/}
{entero}	{printf("<PALABRA RESERVADA 'ent'> %s\n",yytext); return ENT;} /*Devolvemos un valor que representa su abreviatura en español*/
float	{printf("<PALABRA RESERVADA 'flot'> %s\n",yytext); return FLOT;}
double	{printf("<PALABRA RESERVADA 'doble'> %s\n",yytext); return DOBLE;}
char	{printf("<PALABRA RESERVADA 'car'> %s\n",yytext); return CAR;}
func	{printf("<PALABRA RESERVADA 'func'> %s\n",yytext); return FUNC;}
void	{printf("<PALABRA RESERVADA 'vacio'> %s\n",yytext); return VACIO;}
struct	{printf("<PALABRA RESERVADA 'estruct'> %s\n",yytext); return ESTRUCT;}



"{"	{printf("<SP '{'> %s\n",yytext); return LLAVEI;} /*SP = simbolo de puntuación*/
"}"	{printf("<SP '}'> %s\n",yytext); return LLAVED;}
"["	{printf("<SP '['> %s\n",yytext); return LLAVECUADI;}
"]"	{printf("<SP ']'> %s\n",yytext); return LLAVECUADD;}
"("	{printf("<SP '('> %s\n",yytext); return PARENTI;}
")"	{printf("<SP ')'> %s\n",yytext); return PARENTD;}
","	{printf("<SP ','> %s\n",yytext); return COMA;}
";"	{printf("<SP ';'> %s\n",yytext); return PUNTOCOMA;}
"." 	{printf("<SP '.'> %s\n",yytext); return PUNTO;}





if	{printf("<PALABRA RESERVADA 'si'> %s\n",yytext); return SI;} 
else	{printf("<PALABRA RESERVADA 'sino'> %s\n",yytext); return SINO;} 
while	{printf("<PALABRA RESERVADA 'mientras'> %s\n",yytext); return MIENTRAS;}
do	{printf("<PALABRA RESERVADA 'hacer'> %s\n",yytext); return HACER;}
return	{printf("<PALABRA RESERVADA 'retornar'> %s\n",yytext); return RETORNAR;} 
switch	{printf("<PALABRA RESERVADA 'cambiar'> %s\n",yytext); return CAMBIAR;} 
break	{printf("<PALABRA RESERVADA 'romper'> %s\n",yytext); return ROMPER;} 
print	{printf("<PALABRA RESERVADA 'imprimir'> %s\n",yytext); return IMPRIMIR;}
case	{printf("<PALABRA RESERVADA 'caso'> %s\n",yytext); return CASO;} 
default	{printf("<PALABRA RESERVADA 'defecto'> %s\n",yytext); return DEFECTO;} 
true	{printf("<PALABRA RESERVADA 'verdadero'> %s\n",yytext); return VERDADERO;}
false	{printf("<PALABRA RESERVADA 'falso'> %s\n",yytext); return FALSO;} 


"&&"	{printf("<OP RELACIONAL '&&'> %s\n",yytext); return AND;}
"||"	{printf("<OP RELACIONAL '||'> %s\n",yytext); return OR;}
">="	{printf("<OP RELACIONAL '>='> %s\n",yytext); return GEQ;}
"<="	{printf("<OP RELACIONAL '<='> %s\n",yytext); return LEQ;}
"<"	{printf("<OP RELACIONAL '<'> %s\n",yytext); return LT;}
">"	{printf("<OP RELACIONAL '>'> %s\n",yytext); return GT;}
"!="	{printf("<OP RELACIONAL '!='> %s\n",yytext); return NEQ;}
"=="	{printf("<OP RELACIONAL '=='> %s\n",yytext); return EQ;}
"!"	{printf("<OP RELACIONAL '!'> %s\n",yytext); return NOT;}
"+"	{printf("<OP ARITMETICO '+'> %s\n",yytext); return PLUS;}
"-"	{printf("<OP RELACIONAL '-'> %s\n",yytext); return MINUS;}
"*"	{printf("<OP RELACIONAL '*'> %s\n",yytext); return PROD;}
"/"	{printf("<OP RELACIONAL '/'> %s\n",yytext); return DIV;}
"%"	{printf("<OP RELACIONAL '%'> %s\n",yytext); return MOD;}
"="	{printf("<OP ASIGNACION '='> %s\n",yytext); return ASSIG;}


{aritmetico} {fprintf(yyout,"<Operador Aritmetico,\"%s\">\n",yytext);}
{relacional} {fprintf(yyout,"<Operador Relacional,\"%s\">\n",yytext);}
{asignacion} {fprintf(yyout,"<Operador de Asignacion,\"%s\">\n",yytext);}
{especiales} {fprintf(yyout,"<Caracter Especial,\"%s\">\n",yytext);}


{digito}+ 		{printf("<ent> %s\n",yytext); return *yytext;} /*Entero*/
{digito}+"."{digito}*	{printf("<flot> %s\n",yytext); return *yytext;}/*flotante*/
{cadena}	{printf("<CADENA> %s\n",yytext); return *yytext;}
{id}	{printf("<IDENTIFICADOR> %s\n",yytext); return ID;}/*Identificador, devolvemos el puntero del token*/
{caracter}	{printf("<CARACTER> %s\n",yytext); return *yytext;}
{or}		{printf("<OR> %s\n",yytext); return 18;}/*Devolvemos un valor que representa OR*/
{and}		{printf("<AND> %s\n",yytext); return 19;}/*Devolvemos un valor que representa AND*/
{not}		{printf("<NOT> %s\n",yytext); return 20;}/*Devolvemos un valor que representa NOT*/




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



int main(int argc, char **argv)
{



		if(argc > 1){
			FILE *file; //Variable para el Archivo para lectura

			file = fopen(argv[1], "r"); //argv[1] es el nombre del fichero
				
			if(!file){
				fprintf(stderr,"No se pudo abrir el archivo %s\n", argv[1]);
				exit(1);
			}
			yyin = file; //La variable yyin apunta al archivo 
		}
	
		
		yylex();	

		fclose(yyin);

		return 0;	

}
