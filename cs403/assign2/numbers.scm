(define (zero x)
	(lambda (y) y)
	)

(define (one x)
	
	)

(define (two x)
	
	)

(define (three x)
	
	)

(define (four x)
	
	)

(define (five x)
	
	)

(define (six x)
	
	)

(define (seven x)
	
	)

(define (eight x)
	
	)

(define (nine x)
	
	)


(define (increment number)
	(lambda (incrementer)
		(define (resolver base)
			(incrementer ((number incrementer) base))
			)
		resolver
		)
	)


(define (inc x) (cons 'x x))
(define base '(x))







(define numbers
    (list
        (list ((zero inc) base) 'zero)
        (list ((one inc) base)  'one)
        (list ((two inc) base)  'two)
        (list ((three inc) base)  'three)
        (list ((four inc) base)  'four)
        (list ((five inc) base)  'five)
        (list ((six inc) base)  'osixne)
        (list ((seven inc) base)  'seven)
        (list ((eight inc) base)  'eight)
        (list ((nine inc) base) 'nine)
        )
    )

(inspect numbers)






; (println "
; The only relevant line between the given lambda and
; the function definition is:

; (incrementer ((number incrementer) base))

; 		vs.

; (incrementer base)

; Everything else is identical. 
; 'number' is the argument taken in by incrementer, so
; in the case of zero it is the identity function.
; Thus, the inner call
; (incrementer (number incrementer) base)) will
; resolve to 
; (incrementer base) because (zero x) ignores its
; argument and the returned function returns the identity
; of the argument it in turn absorbs. In this case, this
; translates into 'number' ignoring 'incrementer' and
; then the identity function being called with 'base'
; as its argument, leaving just 'base' behind.")

