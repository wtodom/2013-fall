(define (choose n k)
	(define (chooseIter i store)
		(cond
			((= i (+ k 1)) (int store))
			(else
				(chooseIter (+ i 1) (* store (/ (- n (- k i)) (real i)))))
			)
		)
	(chooseIter 1 1)
	)

(define (printSpaces n)
	(cond
		((= n 0) nil)
		(else
			(print " ")
			(printSpaces (- n 1))
			)
		)
	)

(define (pascalPrint maxDepth currentDepth)
	(printSpaces (- maxDepth currentDepth))

	(define (rowIter index)
		(print (choose currentDepth index))
		(cond
			((= index currentDepth) (newline))
			(else
				(print " ")
				(rowIter (+ index 1))
				)
			)
		)
	(rowIter 0)
	)

(define (pascal2 depth)
	(define (pascalIter k)
		(pascalPrint depth k)
		(if (!= depth k) 
			(pascalIter (+ k 1))
			)
		)
	(pascalIter 0)
	)

(pascal2 25)
; (inspect (choose 3 2))