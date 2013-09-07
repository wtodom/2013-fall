(define (firstDigitAt depth)
	(+ 1 (* 4 (- depth 1)))
	)

(define (mystery depth)

	)


(define (iMystery depth)
	(define (innerMystery i total)
		(cond
			((= i 0) (+ total 1))
			(else
				(innerMystery (- i 1) (+ total (/ 1 (+ (firstDigitAt i) .5))))
				)
			)
		)
	(innerMystery depth 0)
	)

(inspect (iMystery 0))
(inspect (iMystery 1))
(inspect (iMystery 2))
(inspect (iMystery 3))
(inspect (iMystery 4))
(inspect (iMystery 5))