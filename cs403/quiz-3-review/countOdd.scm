(include "ci.lib")

(define (odd? n)
	(= (% n 2) 1)
	)

(define (countOdd l)
	(accumulate + 0 (map (lambda (x) (/ x x)) (keep odd? (flatten l))))
	)

(inspect (countOdd (list 1 (list 2 3) 4 5 6 7)))