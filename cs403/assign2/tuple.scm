;{
Define a procedure named tuple that computes all tuples of a given size such that no entry in the tuples is less than zero or greater than a given limit. Moreover, a value in the tuple cannot exceed the following value in the tuple. For example:
    (tuple 4 2)
should generate the list:

    ((0 0 0 0) (0 0 0 1) (0 0 0 2) (0 0 1 1) (0 0 1 2) ... (2 2 2 2))
The order of the tuples is not specified.
;}

(define (interval lo hi step)
	(if (>= lo hi)
		nil
		(cons lo (interval (+ step lo) hi step))
		)
	)

(define (accumulate op base items)
	(cond
		((null? items) base)
		(else
			(op (car items) (accumulate op base (cdr items))
				)
			)
		)
	)

(define (otuple q)
	(accumulate append ()
		(map
			(lambda (q) ; change to y to do all permutations
				(map
					(lambda (x)
						(list x q) ; change q to y with above change
						)
					(interval 0 (+ q 1) 1)
					)
				)
			(interval 0 (+ q 1) 1)
			)
		)
	)

(inspect (otuple 3))
