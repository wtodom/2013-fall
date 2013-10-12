; environment diagrams

; 1. start with an empty table to store variables currently in scope

(define a 3) ; puts an 'a' in the table, and associates it with a value of 3

(define (square x) ; puts square on the left side (under 'a', for example)
	(* x x)			; the right side is represented by two circles.
	)				; one points to the parameter list, the other points to the body.
					; like:
						; p: (x)
						; b: (* x x)
					; the other circle points to a table - the table (scope) in which the function is defined
					; see 10-Oct-table-diagram.png

(define c (square a)) ; this is a function call.
						; RULE ONE - make a new table.
						; RULE TWO - hook up the new table to the defining environment of the function you're calling.
							; In this case, square is called, so we look up square. we check which environment square
							; belongs to, and link the new table to that table.
						; RULE THREE - populate the new left hand side with the formal parameters of the original function
							; Can be found in the first circle of te function in it's table.
						; RULE FOUR - populate right side by evaluating the argument (a in this case). put in 3 (in this case)
						; RULE FIVE - evaluate the body. in this case 9 is returned and placed in our first table.

; took some pictures of examples, 10 october at ~11:50 and 11:54, etc.

; =================

; recognizer stuff

; funcDef: FUNCTION ID optParamList block

; implementation:

; function funcDef()
; {
; 	match(FUNCTION);
; 	match(ID);
; 	optParamList();
; 	block();
; }

; modify Lexeme to be a binary tree node

; class Lexeme:
; {
; 	var value; (int, string, real, whatever)
; 	Lexeme leftChild;
; 	Lexeme rightChild;
; }

; new funcDef:
; funcDef: FUNCTION ID OPAREN optParamList CPAREN OBRACE optStatementList CBRACE ; we'll keep good stuff, throw away junk

; function funcDef:
; {
; 	var f, n, p, b;
; 	match(FUNCTION);
; 	n = match(ID);
; 	match(OPAREN);
; 	p = optParamList();
; 	match(CPAREN);
; 	match(OBRACE);
; 	b = optStatementList();
; 	match(CBRACE);
; 	f = newLexeme(FUNCTIONDEF);
; 	temp = newLexeme(GLUE); type "glue" for glue lexeme - only two pointers but three pieces of info
; 	temp.leftChild = p;
; 	temp.rightChild = b; temp now represents the first circle from the environment stuff
; 	f.leftChild = n;
; 	f.rightChild = temp;
; 	return f;
; }

; if you make a cons type that glues two things together with a type, you can:

; return
; 	cons(FUNCTIONDEF, n
; 		cons(GLUE, p, b)
; 		)
