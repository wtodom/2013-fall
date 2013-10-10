; maybe use . notation for parameters:
; (f x y . z) has two names paramenter, then z bundles any additional ones into a list.
; (f . n) has no named parameters, but any given are in the list, n.
; (see exercise 2.2)
; (include "ci.lib")

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

	)

(inspect (curry f))