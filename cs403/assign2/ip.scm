(include "ci.lib")

(define operators '(^ / * - +))

(define (finishStacks outputStack operatorStack)
	outputStack
	)

(define (infix->prefix inExpr)
	(define (iter outputStack operatorStack restOfInExpr)
		(cond
			; if we've gone through the entire string
			((null? restOfInExpr) (finishStacks outputStack operatorStack))
			; else if the next character is a number/variable
			((not (contains operators (car restOfInExpr))) (iter (cons (car restOfInExpr) outputStack) operatorStack (cdr restOfInExpr)))
			; else (it's an operator)
			(else
				(define (popLoop)
					(cond
						((and (contains operators (car operatorStack)) (<= (indexOf (car restOfInExpr) operators) (indexOf (car operatorStack)))) )
						)
					)
				; (iter outputStack operatorStack (cdr restOfInExpr))
				)
			)
		)
	(iter () () (reverse inExpr))
	)






(define e '(2 + 3 * x ^ 5 + a))

(inspect (infix->prefix e))