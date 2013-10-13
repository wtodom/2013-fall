(include "ci.lib")

(define (nestedMapping1 n)
	(accumulate append ()
		(map (lambda (x)
			(map (lambda (y) (list x y))
				(interval 0 n 1)))
			(interval 0 n 1))
		)
	)

(define (nestedMapping2 n)
	(accumulate append ()
		(map (lambda (x)
			(map (lambda (y) (list x y))
				(interval 0 x 1)))
			(interval 0 n 1))
		)
	)

(define (nestedMapping3 n)
	(accumulate append ()
		(map (lambda (x)
			(map (lambda (y) (list x y))
				(interval x n 1)))
			(interval 0 n 1))
		)
	)

(inspect (nestedMapping1 3))
(inspect (nestedMapping2 3))
(inspect (nestedMapping3 3))