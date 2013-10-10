(define (inc x) (cons 'x x))
(define base '(x))

(define (increment number)
	(lambda (incrementer)
		(define (resolver base)
			(incrementer ((number incrementer) base))
			)
		resolver
		)
	)

(define (zero x)
	(lambda (y) y)
	)

(define (one x)
	((increment zero) x)
	)

(define (two x)
	((increment one) x)
	)

(define (three x)
	((increment two) x)
	)

(define (four x)
	((increment three) x)
	)

(define (five x)
	((increment four) x)
	)

(define (six x)
	((increment five) x)
	)

(define (seven x)
	((increment six) x)
	)

(define (eight x)
	((increment seven) x)
	)

(define (nine x)
	((increment eight) x)
	)

(define numbers
	(list
		(list ((zero inc) base) 'zero)
		(list ((one inc) base) 'one)
		(list ((two inc) base) 'two)
		(list ((three inc) base) 'three)
		(list ((four inc) base) 'four)
		(list ((five inc) base) 'five)
		(list ((six inc) base) 'six)
		(list ((seven inc) base) 'seven)
		(list ((eight inc) base) 'eight)
		(list ((nine inc) base) 'nine)
		)
	)

(define (add m n)
	(lambda (f)
		(lambda (x)
			((((m increment) n) f) x)
			)
		)
	)

(define (translate number)
	(cadr (assoc ((number inc) base) numbers))
	)


(inspect (translate zero))
(inspect (translate (increment one)))
(inspect (translate (add three five)))



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
