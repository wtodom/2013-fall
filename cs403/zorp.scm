(define (plusOne a)
	(+ a 1)
	)

(define (zorp i f)
	(define (zorpIter total currentI)
		(cond
			((< i 2) (+ total (f i)))
			(else
				())
			)
		)
	(zorpIter 0 0)
	)

(inspect (zorp 7 plusOne))


(/ (- (zorp (- i 1) f) (square (zorp (- i 2) f))) (+ (- (zorp (- i 3) f) (* 2 (zorp (- i 2) f))) (zorp (- i 1) f)))