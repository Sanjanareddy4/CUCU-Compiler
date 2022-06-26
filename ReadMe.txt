Tummala Sanjana Reddy - 2020csb1137
Lab 8 - Compiler Design for CUCU (Flex/Bison)

1 => * % bison -d cucu.y
	   % flex cucu.l
	   % gcc cucu.tab.c lex.yy.c -lfl -o cucu
	   % ./cucu Sample1.cu
    
	   above command lines are used to compile and run the program.

 => apart from what is mentioned in the assignment, below are few things to note.

2 => PARTS CONSIDERED IN LANGUAGE.
     
     * int y ; - is a valid statement.
	 * y= 56; - is a valid statement.
	 * y = a+b; - is a valid statement.
	 * y = 5 + 3; - is a valid statement.
	 * y = 4 + a ; - is a valid statement.
	 * char * s; - is a valid statement.
	 * char* s ; - is a valid statement.
	 * s[10] is considered as a identifier.
	 * s[i] is considered as a identifier.

	 **** if , else and while loops must have curly braces even if they have single Statements.
	 * There must be one boolean expression in the if and while  parenthesis.
	 * if(boolean expression){Statements} - is a valid statement.
	 * if(boolean expression){Statements} else {Statements} - valid is a valid statement.
	 * nested loops are allowed and they can be unbalanced, else if{Statements} is not allowed

	 
	 * while(boolean expression){Statements} - is a valid statement.
	 * Global variables can be declared.
	 * fuction prototype is allowed, fuction Definition are allowed
	 * function call is allowed only in side the main or in a function;
	 * main can be declared only in TWO ways only : 
	 	=> int main () {Statements}
		=> int main (int argc , char* argv[]) {Statements}
	 * return statement is also defined.

	 * >,<,<=,>=,==,!= are the symbols included in boolean expression.



3 => * Only integers and identifiers are allowed
	 * comments are just ignored, and as mentioned in the assignment sheet nested comments are not considered.
	 * s[expression] is not considered as a valid identifier, s[identifiers] and s[digits] are allowed.
	 * Bitwise operators(&,|,^) are not included.
	 * On the error lexer and parser will get terminated.
	 * int i,j; - statement is invalid one identifier is to be included in one line.
	
