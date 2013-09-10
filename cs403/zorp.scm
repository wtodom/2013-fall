(define (square x)
	(* x x)
	)

(define (izorp i f)
	(define (innerZorp threeBack twoBack oneBack curr)
		(cond
			((= curr i) threeBack)
			(else
				(innerZorp twoBack oneBack (+ oneBack (/ (square (- oneBack twoBack)) (+ (- threeBack (* 2 twoBack)) oneBack))) (+ curr 1))
				)
			)
		)
	(innerZorp (f 0) (f 1) (f 2) 0)
	)

(inspect (izorp 3 square))