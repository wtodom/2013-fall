(define (index element collection)
	(define (indexIter count tail)
		(cond
			((null? tail) -1)
			((= (string-compare (car tail) element) 0) count)
			(else
				(indexIter (+ count 1) (cdr tail))
				)
			)
		)
	(indexIter 0 collection)
	)

; (inspect (index 5 (list 1 2 3 4 5 6 7)))

(define (letterValue letter)
	(define letters "abcdefghijklmnopqrstuvwxyz")
	(+ (index letter letters) 1)
	)

; (inspect (letterValue "b"))

(define (word2int word)
	(define (converterator restOfWord sum)
		(cond
			((null? restOfWord) sum)
			(else
				(converterator (cdr restOfWord) (+ sum (letterValue (car restOfWord))))
				)
			)
		)
	(converterator word 0)
	)

; (inspect (word2int "ab"))
