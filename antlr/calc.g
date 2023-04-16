header {
#include "str.h"
extern struct argument arg_;
extern struct arguments args_;
extern struct function funcs[MAX_COUNT];
extern int funcs_count;
}
options {
	language="Cpp";
}

class CalcParser extends Parser;
options {
	genHashLines = true;		// include line number information
	buildAST = true;			// uses CommonAST by default
}

//grammar
//<A> ::= FUNC(<ARGUMENTS>) | num
//<ARGUMENTS> ::= <A>,<A><ADD>
//<ADD> ::= ,<A><ADD> | e


a returns [struct argument arg]
{
	function f;
}
	:
		((func:FUNC LPAREN! arguments_ RPAREN!
			{
				f.type = str_to_enum(strdup(func->getText().c_str()));
				f.args = args_;
				funcs[funcs_count] = f;
				funcs_count +=1;
				arg.is_num = 0;
			})
		| (i:NUM
			{
				arg.is_num = 1;
				arg.value = atoi(i->getText().c_str());
				arg_ = arg;
			}))
		;
		
arguments_
{
	 argument arg1;
	 argument arg2;
}
	: 
		(arg1 = a COMMA! arg2 = a add
			{ 
				args_.args[args_.args_count] = arg1;
				args_.args[args_.args_count + 1] = arg2;
				args_.args_count += 2;
			})
		;
add 
{
	argument arg;
}
	:
		(
			{
				args_.args_count = 0;
			})
		| (COMMA! arg = a add
			{
				args_.args[args_.args_count] =arg;
				args_.args_count += 1;
			})
		;

class CalcLexer extends Lexer;

WS_	:	(' '
	|	'\t'
	|	'\n'
	|	'\r')
		{ _ttype = ANTLR_USE_NAMESPACE(antlr)Token::SKIP; }
	;

LPAREN:	'('
	;

RPAREN:	')'
	;

COMMA:	','
	;

protected
DIGIT
	:	'0'..'9'
	;

NUM	:	(DIGIT)+
	;
	
FUNC: "sum" | "mul"
	;

class CalcTreeWalker extends TreeParser;

expr returns [int r]
{
	int a,b;
	r=0;
}
	:	i:NUM			{r = atoi(i->getText().c_str());}
	;

