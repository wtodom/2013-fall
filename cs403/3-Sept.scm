; LOOKUP 
; lex for regex lexer
; yak or bison for grammar


;;; CHAPTER 2 ;;;
; scam has a data structure called a pair.
; A pair is a bundle of values.
; There is a function for creating a pair -> cons.
; There is also one for extracting the left value -> car. (orginally, "contents of the address register")
; There is also one for extracting the right value -> cdr. (orginally, "contents of the decrement register")

;; you don't need data structures if functions are first class objects
(define (cons a b)
	(lambda (x)
		(if (= x 0)
			a
			b
			)
		)
	)

(define (car pair)
	(pair 0)
	)

(define (cdr pair)
	(pair 1)
	)

;; In Lisp/Scheme/Scam there is a level of abstraction above the pair -> list.
;; list: trace down the backbone of pairs and eventually get to a nil. that's the criteria for being a list.
;; ((3) 8 4) // a list
;; ((3) 4 . 4) // not a list

(define (length items)
	(cond
		((null? items) 0)
		(else
			(+ 1 (length (cdr items))) ;; this recursive call is referred to "cdr-ing down the list"
			)
		)
	)

(define (node v l r) ;; make a node for a tree, where v is value, l is left side, r is right
	(cons
		(cons l r)
		)
	)

(define (pairs items)
	(cond
		((not (pair? items)) 0)
		(else
			(+ 1 (pairs (car items) (pairs (cdr items))))
			)
		)
	)