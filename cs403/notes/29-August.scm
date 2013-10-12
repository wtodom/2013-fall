; Scam uses Applicative Order Evaluation!

; CAN USE SLIDING WINDOW FOR ZORP PROBLEM.

; rules for converting recursive function to iterative function

; stores = number base cases
; sources = number formal parameters that change
; iterator must be tail recursive
; if you have multiple stores, return the smallest base case.

; ASK ABOUT ITERATIVE OR RECURSIVE EXAMPLE FROM BOARD


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Implementing a Programming Language ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; first stage is to identify the "words" and their "part of speech"
; kinds of words: 
; 	- identifiers (variables)
;	- keywords (if, for, while, etc)
; 	- operators
; 	- integers (we only have to have ints, not reals)
; 	- strings
; 	- punctuation ((),;{}[]""'' etc)

; First module is lexer
; 	- has a main function and some helpers.
; 	- main function called "lex", which returns the next token in the code
; use a "lexeme" data structure to hold the tokens
; 	- two properties:
; 		- type (the part of speech)
; 		- value
; 			- can have a number of different values to hold various types of things
; 			- e.g. ival, sval, rval, etc
; every function I write will return a lexeme

; function lex()
; {
; 	skipWhitespace(); // also skip comments
; 	ch = readChar(); // first check "push back stack", if not empty read from there, else read next actual character
; 	if (ch == ';') 
; 	{
; 		return new Lexeme(SEMICOLON);
; 	}
; 	else if (check other punctuation, keywords, etc)
; 	else //(check helper function that could be for keyword, 
;		variable, number, or string)
	; {
	; 	if (isalpha(ch))
	; 		return lexVariable(ch);
	; }
; }

; function lexVariable(ch)
; {
; 	buffer = allocate(50);
; 	buffer[0] = ch;
; 	buffer[1] = "\0"; // C style
; 	index = 1;
; 	ch = readChar();
; 	while (isalpha(ch) || (isdigit(ch)))
; 	{
; 		if (index <= length(buffer) -1)
; 		{
; 			buffer[index] = ch; 
; 			buffer[index + 1] = "\0";
; 			index = index + 1;
; 		}
; 		else
; 		{
; 			// throw exception
; 		}
		; ch = readChar();
; 	}
	; pushBack(ch);
	; if (string = (buffer, "return"))
	; {
	; 	return new Lexeme(RETURN);
	; }
	; // do rest of keywords
	; else
	; {
	; 	return new Lexeme(IDENTIFIER, buffer);
	; }
; }