(define (fact n) ; code for fact taken from class notes
	(define (iter store source)
		(if (= source 0)
			store
			(iter (* store source) (- source 1))
			)
		)
	(iter 1 n)
	)

(define (choose n k)
	(/ (fact n) (* (fact k) (fact (- n k))))
	)

