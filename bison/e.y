%{
#include <string.h>
#include "str.h"
//#define YYSTYPE int
extern int yylineno;
 
struct argument arg_;
struct arguments args_;
struct function funcs[MAX_COUNT];
int funcs_count = 0;

%}

//grammar
//<res>:: = <A>
//<A> ::= FUNC(<ARGUMENTS>) | num
//<ARGUMENTS> ::= <A>,<A><ADD>
//<ADD> ::= ,<A><ADD> | e


%union {
	int val;
	enum func_type type;
	struct function func;
	struct arguments args;
	struct argument arg;
}

%token <val> NUM 
%token <type> FUNC 
%type <arg> a
%type <args> arguments

%%

res	:	a 
		{ 
			//printf("RESULT: \n");
			return;
		}
	|	error
	;

a	:	FUNC '(' arguments ')'
		{	
			//printf("Y:FUNC ");
			struct function f;
			f.type = $1;
			f.args = $3;
			funcs[funcs_count] = f;
			funcs_count +=1;
			arg_.is_num = 0;
			$$ = arg_;
			
		}
	|	NUM 
		{
			//printf("Y:NUM ");
			arg_.is_num = 1;
			arg_.value = $1;
			$$ = arg_;
			
		}
	;
	
arguments :	a ',' a add
		{
			//printf("Y: a , a add \n");
			args_.args[args_.args_count] = $1;
			args_.args[args_.args_count + 1] = $3;
			args_.args_count += 2;
			$$ = args_;
		}
	;
		
add	:	/* empty */ 
		{
			args_.args_count = 0;
		}
	|	',' a  add
		{  
			//printf("Y: , a add \n");
			args_.args[args_.args_count] = $2;
			args_.args_count += 1;
		} 
	;
	
%%

#include <stdio.h>

main () {
	yyparse();
	printf ("Parsing finished\n");
	printf ("Func num = %d\n", funcs_count);
	printf ("Result: %d \n", get_res());
	//system("pause");
	}
yyerror( mes ) char *mes; {  printf( "%s", mes ); }