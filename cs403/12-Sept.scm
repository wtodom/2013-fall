; ifStatement: IF OPAREN expr CPAREN block optElse

; optElse:  ELSE block
; 		| Epsilon
; 		| ELSE ifStatement

; block: OPAREN optStatements CPAREN

; optStatements: statements
; 				| Epsilon

; statements: statement
; 			| statement statements

; // or
; //
; //statements: statement optStatements
; //

; primary:  INTEGER
; 		| STRING
; 		| TRUE
; 		| FALSE
; 		| NULL
; 		| varExpr
; 		| OPAREN expr CPAREN
; 		| PLUSPLUS VARIABLE

; statement: expr SEMI
; 			| ifStatement
; 			| whileStatement
; 			| STUB

; function statementPending()
; {
; 	return (ifStatementPending() || whileStatementPending() || exprPending() || check(STUB)); // checks for the "first set" - the set of the first things per section of the rule
; }

; expr: primary // CHECK THE NOTES (ON THE WEBSITE) FOR THIS PART
; 		| primary op expr

; function expr() // AND THIS ONE
; // this isn't correct according to the version of expr above
; {
; 	if (primaryPending())
; 	{
; 		primary();
; 	}
; 	else
; 	{
; 		expr();
; 	}
; }

; function optElse()
; {
; 	if (check(ELSE))
; 	{
; 		match(ELSE);
; 		if (blockPending()) // use check() for terminals, xxxPending() for non-terminals
; 		{
; 			block();
; 		}
; 		else
; 		{
; 			ifStatement();
; 		}
; 	}
; }

; function block()
; {
	
; }