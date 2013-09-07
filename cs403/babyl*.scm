(define (square num)
	(define (squareIter i total)
		(cond
			((= i 0) total)
			(else
				(squareIter (- i 1) (- (+ total i i ) 1))
				)
			)
		)
	(squareIter num 0)
	)

(define (halve num)
	(define (halveIter i)
		(cond
			((= (+ i i) num) i)
			(else
				(halveIter (+ i 1))
				)
			)
		)
	(halveIter 0)
	)

(define (babyl* a b)
	(halve (- (square (+ a b)) (square a) (square b)))
	)

(inspect (babyl* 3 9))