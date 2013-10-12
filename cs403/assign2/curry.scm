(include "ci.lib")

(define (curry x)
	(define params (get ' parameters x))
	(define me this)

	(define (cIter paramList lambdas)
		(cond
			((null? paramList) (eval lambdas me))
			(else
				(cIter (cdr paramList) (list lambda (list car paramList)) lambdas))
				)
			)
		)

	(cIter (reverse params) (cons x params))
	)

(define (f a b c)
	(+ a b c)
	)

(inspect ((((curry f) 1) 2) 3))