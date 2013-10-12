(define (halver x)
	(lambda (y) (/ (x y) 2)
	)

(define (square z)
	(* z z)
	)

(inspect ((halver square) 4))