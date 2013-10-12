(define (f x y)
	(cond
		((= x 0) y)
		((= x 1) (+ y y))
		(else
			(+ (f (- x 1) y) (f (- x 2) y))
			)
		)
	)