(include "ci.lib")

(define (curry f)
	(define numParamsNeeded (length (get ' parameters f)))
	(define (curryIter params)
		(cond
			((= (length params) numParamsNeeded) params) ; this returns the full parameter list
			(else
				(curryIter (append params (get 'parameters curryIter)))
				)
			)
		)
	(curryIter ())
	)

(define (f a b c)
	(print "a: " a " b: " b " c: " c)
	)

; (f 1 2 3)
(inspect (curry f))