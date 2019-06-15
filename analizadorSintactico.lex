/*
*Compiladores
*Proyecto Final
*
*Guerrero Chávez Diana Lucía
*Sánchez del Moral Adriana 
*Gallardo Valdez José Jhovan 
*
*Creado el 14 de Junio de 2019
*/

%{
	#include <stdio.h>
    #include <stdlib.h>
	VACIO yyerror(char *);
    extern int yylex();
	extern FILE * yyin;
    extern int yylineno;
%}

%token ENT
%token FLOT
%token DOBLE
%token FUNC
%token VACIO
%token ESTRUCT
%token LLAVEI
%token LLAVED
%token LLAVECUADI
%token LLAVECUADD
%token PARENTI
%token PARENTD
%token COMA
%token PUNTOCOMA
%token PUNTO
%token SINO
%token MIENTRAS
%token HACER
%token RETORNAR
%token CAMBIAR
%token ROMPER
%token IMPRIMIR
%token CASO
%token DEFECTO
%token VERDADERO
%token FALSO


%right ASSIG
%left OR
%left AND
%left EQ NEQ
%left GT GEQ
%left LT LEQ
%left PLUS MINUS
%left PROD DIV MOD
%right NOT
%left LLAVECUADI LLAVECUADD
%left PARENTI PARENTD  
%left IFX
%left SINO

%start prog

%%

prog:
	decls funcs 
;

decls:
	 tipo lista PUNTOCOMA decls 
	 | %empty 
;

tipo: 
	ENT 
    | FLOT 
	| DOBLE 
	| CAR 
	| VACIO 
	| ESTRUCT LLAVEI decls LLAVED 
;

lista:
	 lista COMA ID arreglo  
	 | ID arreglo 
;

numero:
	  signo INT 
	  | signo DOUBLE 
	  | signo FLOAT 
;

signo: PLUS
	   | MINUS
	   | %empty
;

arreglo:
	   LLAVECUADI numero LLAVECUADD arreglo  
	   | %empty 
;

funcs:
	 FUNC tipo ID PARENTI args PARENTD LLAVEI decls sents LLAVED funcs  
	 | %empty 
;

args:
	lista_args  
	| %empty 
;

lista_args:
		  lista_args COMA tipo ID parte_arr  
		  | tipo ID parte_arr 
;

parte_arr:
		 LLAVECUADI LLAVECUADD parte_arr 
		 | %empty 
;

sents:
	 sents sent 
     | sent 
;

sent:
	IF PARENTI cond PARENTD sent sentp
    | MIENTRAS PARENTI cond PARENTD sent 
    | DO sent MIENTRAS PARENTI cond PARENTD PUNTOCOMA 
    | FOR PARENTI sent PUNTOCOMA cond PUNTOCOMA sent PARENTD sent  
	| parte_izq ASSIG exp PUNTOCOMA 
	| RETURN exp PUNTOCOMA 
	| RETURN PUNTOCOMA 
	| LLAVEI sents LLAVED  
	| CAMBIAR PARENTI exp PARENTD LLAVEI casos LLAVED 
	| ROMPER PUNTOCOMA  
	| IMPRIMIR exp PUNTOCOMA 
;

sentp:
	 %empty %prec IFX
	 | SINO sent
;

casos:
	 CASE numero sent casos 
	 | DEFECTO sent 
	 | %empty 
;

parte_izq:
		 ID 
	     | var_arr  
		 | ID DOT ID 
;

var_arr:
	   ID LLAVECUADI exp LLAVECUADD  
       | var_arr LLAVECUADI exp LLAVECUADD 
;

exp:
   exp PLUS exp  
   | exp MINUS exp 
   | exp PROD exp 
   | exp DIV exp 
   | exp MOD exp 
   | var_arr 
   | CADENA 
   | numero 
   | CARACTER 
   | ID PARENTI params PARENTD 
;

params:
	  lista_param 
	  | %empty 
;

lista_param:
		   lista_param COMA exp  
   		   | exp 
;

cond:
	cond OR cond 
    | cond AND cond 
    | NOT cond 
    | PARENTI cond PARENTD 
    | exp rel exp 
    | VERDADERO 
    | FALSO 
;

rel:
   LT 
   | GT 
   | LEQ  
   | GEQ 
   | NEQ 
   | EQ 
;

%%
VACIO yyerror (char *s) {
   fprintf (stderr, "%s\n", s);
}
