(define (g x)
	(* x x)
	)

(define (f x)
	(cond
		((= x 1) x)
		((= (% x 2) 0) (g x))
		(else
			(* (f (- x 1)) (f (- x 2)))
			)
		)
	)

(inspect (f 3))