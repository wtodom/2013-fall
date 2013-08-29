; Scam uses Applicative Order Evaluation!

; CAN USE SLIDING WINDOW FOR ZORP PROBLEM.

; rules for converting recursive function to iterative function

; stores = number base cases
; sources = number formal parameters that change
; iterator must be tail recursive
; if you have multiple stores, return the smallest base case.

; ASK ABOUT ITERATIVE OR RECURSIVE EXAMPLE FROM BOARD


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Implementing a Programming Lnaguage ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; first stage is to identify the "words" and their "part of speech"
; kinds of words: 
; 	- identifiers (variables)
;	- keywords (if, for, while, etc)
; 	- operators
; 	- integers (we only have to have ints, not reals)
; 	- strings
; 	- punctuation ((),;{}[]""'' etc)
; 	- 

; First module is lexer
; 	- has a main function and some helpers.
; 	- main function called "lex", which returns the next token in the code
; use a "lexeme" data structure to hold the tokens
; 	- two properties:
; 		- type (the part of speech)
; 		- value
; 			- can have an umber of different values to hold various types of things
; 			- e.g. ival, sval, rval, etc
; every function I write will return a lexeme

; function lex()
; {
; 	skipWhitespace(); // also skip comments
; 	ch = readChar(); // first check "push back stack", if not empty read from tehre, else read next actual character
; 	if (ch == ';') 
; 	{
; 		return new Lexeme(SEMICOLON);
; 	}
; 	else if (check other punctuation, keywords, etc)
; 	else (check helper function that could be for keyword or variable)
; }