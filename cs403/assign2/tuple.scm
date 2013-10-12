(include "ci.lib")

(define (t n m)
	(define (tIter i tuples)
		(cond
			((= n 0) nil)
			((= i n) tuples)
			(else
				(tIter (+ i 1) 
					(accumulate append () 
						(map ; for each 
							(lambda (sublist)
								(map ; for each
									(lambda (x) ; number in the interval
										(cons x sublist)
										)
									(interval 0 (+ (car sublist) 1) 1) ; from 0 to the car of the sublist
									)
								)
							tuples
							)
						)
					)
				)
			)
		)
	(tIter 1 (map (lambda (x) (list x)) (interval 0 (+ m 1) 1)))
	)

(inspect (t 3 3))

;{
for each sublist in tuples:
	cons each number from 0 to the car of the sublist to the front of the sublist and append them all together.
	recur on this list.
;}