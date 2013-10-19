(include "pretty.lib")

(define (cxr symbol)
	(define sym (string symbol))
	(define (cxrIter function remainingSymbol)
		(cond
			((null? remainingSymbol) function)
			((equal? (car (string remainingSymbol)) "d") (cdr (cxrIter function (cdr remainingSymbol))))
			((equal? (car (string remainingSymbol)) "a") (car (cxrIter function (cdr remainingSymbol))))
			(else
				(print "Invalid series.")
				)
			)
		)
	(lambda (x) (cxrIter x sym))
	)

(inspect ((cxr 'adddd) '(1 2 3 4 5 6)))
(inspect ((cxr 'addddd) '("Hi" "!" "What" "is" "your" "name" "?")))
(inspect ((cxr 'aaddd) '(car cdr (cadr cddr) (caddr cdddr))))