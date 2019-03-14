package grammar;
import java_cup.runtime.*;
import exceptions.*;

%%


%public
%class Lexer
%yylexthrow LexicalException
%cup
%unicode
%ignorecase
%line 
%column


%{

private Symbol symbol(int type) 
{
	return new Symbol(type);
}
private Symbol symbol(int type, Object value)
{
	return new Symbol(type, value);
}
%}

MismatchedComment= "(*" ([^\*] | "*"+[^\)])+ | ([^\(]|"("+[^\*])+"*)"
Comment		= "(*"~"*)"
WhiteSpace 	= " "|\t|\b|\f|\r|\n|\r\n
IllegalInteger	= {Number}+{Identifier}+
Identifier		= [:jletter:]+[:jletterdigit:]*
Number		= {Decimal} | {Octal}
Decimal		= 0 | [1-9]+[0-9]*
Octal		= 0[0-7]+
IllegalOctal	= 0[0-7]*[9|8]+[0-9]*


%%


<YYINITIAL>
{
/*arithmetic operator*/
"+"		{return symbol(sym.PLUS,yytext());}
"-"		{return symbol(sym.MINUS,yytext());}
"*"		{return symbol(sym.TIMES,yytext());}
"DIV"		{return symbol(sym.DIVIDE,yytext());}
"MOD"		{return symbol(sym.MOD,yytext());}
":="		{return symbol(sym.ASSIGN,yytext());}

/*logicol operator*/
"="		{return symbol(sym.EQ,yytext());}
"#"		{return symbol(sym.NEQ,yytext());}
"<"		{return symbol(sym.LT,yytext());}
"<="		{return symbol(sym.LE,yytext());}
">"		{return symbol(sym.GT,yytext());}
">="		{return symbol(sym.GE,yytext());}
"OR"		{return symbol(sym.OR,yytext());}
"&"		{return symbol(sym.AND,yytext());}
"~"		{return symbol(sym.NOT,yytext());}

/*keyword and reserved word*/
"IF"		{return symbol(sym.IF,yytext());}
"THEN"		{return symbol(sym.THEN,yytext());}
"ELSIF"		{return symbol(sym.ELSIF,yytext());}
"ELSE"		{return symbol(sym.ELSE,yytext());}
"WHILE"		{return symbol(sym.WHILE,yytext());}    
"DO"		{return symbol(sym.DO,yytext());}
"BEGIN"		{return symbol(sym.BEGIN,yytext());}
"CONST"		{return symbol(sym.CONST,yytext());}
"END"		{return symbol(sym.END,yytext());}
"MODULE"	{return symbol(sym.MODULE,yytext());}
"OF"		{return symbol(sym.OF,yytext());}
"PROCEDURE"	{return symbol(sym.PROCEDURE,yytext());}
"RECORD"	{return symbol(sym.RECORD,yytext());}
"ARRAY"		{return symbol(sym.ARRAY,yytext());}
"VAR"		{return symbol(sym.VAR,yytext());}
"TYPE"		{return symbol(sym.TYPE,yytext());}
"READ"		{return symbol(sym.READ,yytext());}
"WRITE"		{return symbol(sym.WRITE,yytext());}
"WRITELN"	{return symbol(sym.WRITELN,yytext());}
"INTEGER"	{return symbol(sym.INTEGER,yytext());}
"BOOLEAN"	{return symbol(sym.BOOLEAN,yytext());}


/*other tokens*/
";"		{return symbol(sym.SEMI,yytext());}
":"		{return symbol(sym.COLON,yytext());}
","		{return symbol(sym.COMMA,yytext());}
"."		{return symbol(sym.PERIOD,yytext());}
"["		{return symbol(sym.LBRACKET,yytext());}
"]"		{return symbol(sym.RBRACKET,yytext());}
"("		{return symbol(sym.LPAREN,yytext());}
")"		{return symbol(sym.RPAREN,yytext());}

/*comment, identifier and number*/
{WhiteSpace}	{/*skip it*/}
{Comment}	{/*Do nothing*/}
{MismatchedComment}	
		{throw new MismatchedCommentException(yytext());}
{IllegalOctal}	{throw new IllegalOctalException(yytext());}
{IllegalInteger}	{throw new IllegalIntegerException(yytext());}
{Number}		{
			if (yylength() > 12)
				throw new IllegalIntegerRangeException(yytext());
			if (yytext().charAt(0) == '0' && yytext().length()>1)
				return symbol(sym.NUMBER, yytext());
			return symbol(sym.NUMBER, yytext());
		}
{Identifier}		{
			if (yylength() > 24)
				throw new IllegalIdentifierLengthException(yytext());
			return symbol(sym.IDENTIFIER, yytext());
		}
}
[^]		{throw new LexicalException(yytext());}

