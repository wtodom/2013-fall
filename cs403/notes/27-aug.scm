(define (square x)
	(cond
		((= (% x 2) 0) (* x x))
		(else 0)
		)
	)

(inspect (square 13))


; (define (main x) ; mimics recursively adding one and printing to console
; 	(println x)
; 	(main (+ x 1))
; 	)

; (main 0)

(define (f n) ; recursive version
	(if (= n 0)
		1
		(* n (f (- n 1)))
		)
	)

(define (f2 n) ; iterative version
	(define (iter store source)
		(if (= source 0) ; add stuff to store until it's gone, then return store
			store
			(iter (* store source) (- source 1))
			)
		)
	(iter 1 n) ; base case value from recursive version, along with original parameter value 
	)

; calling (f2 5): (constant space)
; (f2 5)
; (iter 5 4)
; (iter 20 3)
; (iter 60 2)
; (iter 120 0)
; 120

; calling (f 5) (space grows massive)
; (f 5)
; (* 5 (f 4))
; (* 5 (* 4 (f 3)))
; (* 5 (* 4 (* 3 (f 2))))
; (* 5 (* 4 (* 3 (* 2 (f 1)))))
; 120

(define (fib n) ; recursive version
	(cond
		((= n 0) 0)
		((= n 1) 1)
		(else (* (fib (- n 1) (fib (- n 2)))))
		)
	)

(define (fib2 n) ; iterative version
	(define (iter prev curr src)
		(if (= src 0)
			prev
			(iter curr (+ prev curr) (- src 1))
			)
		)
	(iter 0 1 n)
	)

; often good to write recursive version then go back and use it to write iterative,
;at least until you get better/more used to at iterative.