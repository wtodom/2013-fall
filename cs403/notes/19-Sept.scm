; how to make an object:
(define (node value next)
	(define (odd?)
		(and (integer? value) (= (% value 2) 1))
		)
	(define (congruentTo w x)
		(= (% value x) (% w x))
		)
	this ; "this" references the current scope, not the object
		 ; "context" refers to the object's scope
	)

(define a (node 4 nil))

(inspect (get 'value a)) ; the quote suppresses evaluation
(inspect (dot a value))
(inspect (a' value))


(define a (node 1 (node 2 (node 3 nil))))

; to get the value of the second node:
(get 'value (get 'next a))
(dot (dot a next) value)
(a ' next ' value)

; to call the node's odd? method:
((a ' next 'odd?)) ; double parens - one set to get method, another to call it

; congruentTo 13 5
((a' next' congruentTo) 13 5)

; '1 -> 1
; 'a -> symbol (enumerated type)
; note: (eq? v 'b) to compare symbol held in v to the symbol b

; '(a b c) gives a list of three symbols

; `(a ,b c) backtick is the same as ' except it evaluates things preceded by a comma (b in this case)

;;; FOR ASSIGNMENT ;;;
; (eval expr env) eval forces the evaluation of expr in the environment env

(define f (eval '(lambda (x) (* x x)) this)) ; in the assignment we have to build up a list like this then evaluate it
;;; END ;;;

(define old-if if)
(define (if # test $trueExpr $falseExpr) ; $ prevents evaluation of the expressions, # is automatically bound to the scope of the evaluated functions, no matter where it is in the argument list
	(println "if called!")
	(old-if test
		(eval $trueExpr #)
		(eval $falseExpr #)
		)
	)

; continued from last time - MapReduce stuff
(define (accumulate op base items)
	(cond
		((null? items) base)
		(else
			(op (car items) (accumulate op base (cdr items))
				)
			)
		)
	)

(accumulate + 0 '(1 2 3 4)) ; -> 10

; accummulate with append as op can flatten lists

; how to translate this to scam?
; for i = 0 to n
; 	for j = i to n
; 		print(i, j)

; continued 24 sept
(define (pairs start end)
	(cond
		((= start end) nil)
		(else
			(cons
				(list start start)
				(interleave
					(pairs (+ 1 start) end)
					()))))
	)