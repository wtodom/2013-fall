(define (f x)
	(define a (+ x 1))
	(define b (- x 1))
	(+ (* a a) (* a b) (* b b))
	)

(define (f2 x)
	(
		(lambda (a b) (+ (* a a) (* a b) (* b b)))
		(+ x 1)
		(- x 1)
		)
	)

(inspect (f 3))
(inspect (f2 3))