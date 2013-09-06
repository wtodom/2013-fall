(define (ramanujan depth)
	(define (innerRamanujan curr)
		(cond
			((= depth curr) 1)
			(else
				(sqrt (+ 1 (* (+ curr 2) (innerRamanujan (+ curr 1)))))
				)
			)
		)
	(innerRamanujan 0)
	)

(define (iRamanujan depth)
	(define (iRamanujanIter total curr)
		(cond
			((= curr 0) total)
			(else
				(iRamanujanIter (sqrt (+ 1 (* (+ 1 curr) total))) (- curr 1))
				)
			)
		)
	(iRamanujanIter 1 depth)
	)

(inspect (ramanujan 0))
(inspect (ramanujan 1))
(inspect (ramanujan 2))
(inspect (ramanujan 3))
(inspect (ramanujan 4))
(inspect (ramanujan 5))
(inspect (ramanujan 10))
(inspect (ramanujan 100))

(newline)

(inspect (iRamanujan 0))
(inspect (iRamanujan 1))
(inspect (iRamanujan 2))
(inspect (iRamanujan 3))
(inspect (iRamanujan 4))
(inspect (iRamanujan 5))
(inspect (iRamanujan 10))
(inspect (iRamanujan 100))