(include "ci.lib")

(define (curry x)
	(define params (get ' parameters x))
	(define me this)

	(define (cIter paramList lambdas)
		(cond
			((null? paramList) (eval lambdas me))
			(else
				(cIter (cdr paramList) (list lambda (list (car paramList)) lambdas))
				)
			)
		)

	(cIter (reverse params) (cons x params))
	)

(inspect (define (f a b c) (- a b c)))
(inspect ((((curry f) 1) 2) 3))
(println "    [it should be -4]")

(define (g w x y z)
		(* x (/ y (+ w z)))
		) 

(inspect (((((curry g) 5.0) 2.0) 3.0) 4.0))
(println "    [it should be 0.666667]")