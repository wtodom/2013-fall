; simple grammar for english

; sentence: np vp PERIOD ;; PERIOD is a lexeme from the lexer, more formally called a "terminal". 
; np: ART ADJ NOUN
; vp: VERB np


; ### LL(1) ###

; every rule becomes a function in the parser
; the first rule is called the "start rule". The parser generally calls the start rule first.

; ;;;;;;;;;;;;;;;;;;
; lexeme *current;

; function sentence() ;; recognizer: will tell yo uwhether you have a sentence or not - doesn't return the sentence.
; {
; 	np();
; 	vp();
; 	match(PERIOD);
; }

; function match(type)
; {
; 	if (check(type) == FALSE)
; 	{
; 		throw(parseException);
; 	}
; 	var old = current;
; 	current = lex();
; 	return old;
; }

; function check(type) ;; use match() when it must occur, use check() when it may occur (when there is a choice)
; {
; 	return current.type == type;
; }

; function np()
; {
; 	match(ART);
; 	match(ADJ);
; 	match(NOUN);
; }

; function vp()
; {
; 	match(VERB);
; 	np();
; }

; function parse()
; {
; 	current = lex(); ;; this is the one token of lookahead. if lookahead was two, have two calls to lex, etc/
; 	sentence();
; 	match(END_OF_FILE); ;; lexer should return an END_OF_FILE lexeme when it finishes the code
; }

; With above grammar, "The dog chased the fat cat." cannot be generated.
; Can change this by making the grammar:

; np: ART optAdj NOUN
; optAdj: ADJ | Epsilon ;; Epsilon is "nothing"

; function optAdj()
; {
; 	if (check(ADJ))
; 	{
; 		match(ADJ);
; 	}
; 	else
; 	{
; 		;; nothing
; 	}
; }