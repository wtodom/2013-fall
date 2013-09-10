(define (firstDigitAt depth)
	(cond
		((= depth 0) 1)
		(else
			(+ 1 (* 4 depth))
			)
		)
	)

(define (iFirstDigitAt depth)
	(cond
		((= depth 0) 1)
		(else
			(+ 1 (* 4 (- depth 1)))
			)
		)
	)

(define (mystery depth)
	(define (innerMystery curr)
		(cond
			((>= curr depth) 1)
			(else
				(+ 1 (/ 1.0 (+ (firstDigitAt curr) (/ 1.0 (+ 1 (/ 1.0 (innerMystery (+ curr 1))))))))
				)
			)
		)
	(innerMystery 0)
	)

(define (imystery depth)
	(define (innerMystery curr total)
		(cond
			((= curr 0) total)
			(else
				(innerMystery (- curr 1) (+ 1 (/ 1.0 (+ (iFirstDigitAt curr) (/ 1.0 (+ 1 (/ 1.0 total)))))))
				)
			)
		)
	(innerMystery depth 1)
	)

(inspect (imystery 0))
(inspect (mystery 0))
(inspect (imystery 1))
(inspect (mystery 1))
(inspect (imystery 2))
(inspect (mystery 2))
(inspect (imystery 1000))
(inspect (mystery 500))