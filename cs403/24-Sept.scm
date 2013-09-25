; sum primes between o and n:
(accumulate * 1
	(keep prime?
		(enumerate 2 n)
		)
	)

; how to make the following in scam?
; (0 0) (0 1) (0 2) (0 3)
; 	  (1 1) (1 2) (1 3)
; 	  		(2 2) (2 3)
; 	  			  (3 3)

(define (pairs n)
	(define (helper count)
		(if
			(> count n) nil)
			(cons
				(list count count)
				(combine
					(helper (+ count 1))
					(map (lambda (x) (list count x)) (enumerate (+ count 1) n)
					)
				)
			)
		)
	(helper 0)
	)

; generate (1 2 3 4 5 6 ...)
; map the following function on it:
;	 (lambda (x) (list 0 x)) ; can use count instead of 0 to make the whole thing work

; ALTERNATIVELY:

