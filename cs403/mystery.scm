(define (firstDigitAt depth)
	(cond
		((= depth 0) 1)
		(else
			(+ 1 (* 4 depth))
			)
		)
	)

; (define (mystery depth)
; 	(cond
; 		((= depth 0) 1)
; 		(else
; 			(+ (/ 1 (+ (firstDigitAt depth) .5)) (mystery (- depth 1)))
; 			)
; 		)
; 	)

(define (iMystery depth)
	(define (innerMystery i total)
		(cond
			((= i 0) (+ total 1))
			(else
				(innerMystery (- i 1) (+ total (/ 1 (+ (firstDigitAt i) .5))))
				)
			)
		)
	(innerMystery depth 0)
	)

(define (square x)
	(* x x)
	)

(define (mystery depth)
	(define (innerMystery i)
		(cond
			((>= i depth) 1)
			(else ; not quite the right recursion, or maybe not right recombination
				(+ 1 (/ 1.0 (+ (firstDigitAt i) (/ 1.0 (+ 1 (/ 1.0 (innerMystery (+ i 1))))))))
				)
			)
		)
	(innerMystery 0)
	)

(inspect (mystery 0))
(inspect (mystery 1))
(inspect (mystery 2))
(inspect (mystery 175))