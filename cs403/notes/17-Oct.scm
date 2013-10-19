; notebook-91
(define x 3)(define y 4)
(define a ((lambda (x y) (* x y) (- x y) (+ y 1))))
(define (alpha x)(define (beta y) (cond ((= y -) x)(else (+ 1 (beta (- y 1)))))) beta)
(define b (alpha a))
(define c (b 1))


; implementing an environment

; represent tables as two parallel lists (one for each column)
; E0 from notebook-91 would be:
	; ((x y a alpha b c) . (3 4 10 {func} {func} 11)) ; two lists cons'd together
; same for multiple scopes: make a list of them (the tables):
	; (E3 E2 E0) (for E3's scope)

; what operations are performed on an environment?
	; - extend
	; - createTable XXX jk, it's just cons
	; - addVariable
	; - getVariable
	; - setVariable

; function getVariable(name, scope)
; {
; 	s = scope;
; 	while (s != null)
; 	{
; 		t = car(s); ; implemment a typed cons (from earlier lecture) and a car function
; 		vars = car(t);
; 		vals = cdr(t);
; 		while (vars != null)
; 		{
; 			if (sameVar(name, car(vars))
; 			{
; 				return car(vals);
; 			}
; 			vars = cdr(vars);
; 			vals = cdr(vals);
; 		}
; 		s = cdr(s);
; 	}
; 	// ERROR
; }

; function addVariable(name, value, scope)
; {
; 	t = car(scope);
; 	t.left = cons(GLUE, name, t.left)
; 	t.right = cons(GLUE, value, t.right)
; }

; function extend(vars, vals, scope) ; building a table and hooking it up to another one.
; {
; 	return cons(ENV, cons(GLUE, vars, vals), scope); ; might not be exactly right.
; }

; NOTE NOTE NOTE NOTE NOTE
; NOTE NOTE NOTE NOTE NOTE

; READ DIGITAL LOGIC SIMULATION

; NOTE NOTE NOTE NOTE NOTE
; NOTE NOTE NOTE NOTE NOTE

; revisit function def from 10-Oct.scm

function eval(pt, scope) ; pt = parseTree
{
	if (type(pt) == INTEGER)
	{
		return pt;
	}
	if (type(pt) == STRING)
	{
		return pt;
	}
	if (type(pt) == BOOLEAN) ; and anythign else whose value is itself
	{
		return pt;
	}
	if (type(pt) == ID)
	{
		return getVariable(pt, scope);
	}
	if (type(pt) == PLUS)
	{
		return evalPlus(pt, scope);
	}
	if (type(pt) == FUNCDEF)
	{
		return return evalFuncDef(pt, scope);
	}
}

function evalPlus(pt, scope)
{
	var lhs = eval(pt.left, scope); ; left hand side
	var rhs = eval(pt.right, scope);
	return newInteger(lhs.ival + rhs.ival); ; returns a new Lexeme with the INT type; ival is the integer value of the lexeme
}

function evalFuncDef(pt, scope)
{
	addVariable(pt.left, cons(CLOSURE, scope, pt));
}