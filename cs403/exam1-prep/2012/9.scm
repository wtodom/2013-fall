(define (sum lower upper)
	(define (sumIter sum i)
		(cond
			((= upper i) sum)
			(else
				(sumIter (+ sum i) (+ i 1))
				)
			)
		)
	(sumIter 0 lower)
	)

(inspect (sum 5 9))