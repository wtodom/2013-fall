; shuffle two lists together without appending
(define (inteleave s1 s2)
	(cond
		((null? s1) s2)
		(else
			(cons (car s1) (interleave s2 (cdr s1)))
			)
		)
	)

;;; shorter way ;;;
; function to map to the list (0 1 2 3 4 5 etc) to do the tuples problem
(define (f q)
	(map
		(lambda (x) (list x q))
		(interval 0 (+ q 1))
		)
	)

; combine all the generated lists
(accumulate append ()
	(map
		(lambda (q) (map lambda (x) (list x q)) (interval 0 (+ q 1)))
		(interval 0 (+ n 1))
		)
	)

;;; faking objects in scheme
(define (rational n d)
	(define (add r)
		(rational (+ (* n (r ' denom)) (* (r ' numer) d)) (*d (r ' denom))
			)
		)
	(define (dispatch msg)
		(cond
			((eq? 'add msg) add)
			((eq? 'numer msg) n)
			((eq? 'denom msg) d)
			)
		)
	dispatch
	)

; scam equivalent:
(define (rational n d)
	(define (add r)
		(rational (+ (* n (r ' denom)) (* (r ' numer) d)) (*d (r ' denom))
			)
		)
	this
	)

(define a (rational 2 3))
(define b (rational 4 5))
(define c ((a ' add) b))
(println (c ' numer)) ; print c's numerator


;;; data directed programming
; '(rational 2 3) could represent a rational number (2/3)
; '(complex 4 8)
; '(integer 4)

(define oldplus +)
(define (+ a b)
	(cond
		((and (eq? (car a) 'integer) (eq? (car b) 'integer) (integer+ a b))) ; the parens are off maybe.
		((and (eq? (car a) 'real) (eq? (car b) 'integer)) (real-int+ a b))
		((and (eq? (car a) 'integer) (eq? (car b) 'real)) (real-int+ b a))
		)
	)

(define (integer+ x y)
	(list
		'integer
		(oldplus (cadr x) (cadr y))
		)
	)

(define (real-int+ x y)
	(list
		'real
		; exercise left to the reader...
		)
	)

;{ data-directed programming

make a table as follows: (lists of three items)

+ integer 	integer integer+
+ real 		integer real-int+
+ integer	real 	(lambda (x y) (real-int+ y x))


postualte the existence of functions get and put,
which insert or retrieve items from the table

(putItem
	'(+ integer integer)
	integer+
	)

(putItem
	'(+ real integer)
	real-int+
	)
and so on...
;}

;;; The above lets us simplify the plus function
(define (+ a b)
	((getItem
		(list '+ (car a) (car b))
		)
		a
		b
		)
	)