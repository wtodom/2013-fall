(define (function+ f g)
	(lambda (x) (g (f x)))
	)

(define (double x)
	(* 2 x)
	)

(define (cube x)
	(* x x x)
	)

(inspect ((function+ cube double) 3))