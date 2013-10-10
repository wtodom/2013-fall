(define (Stack)
	(define data ())
	(define (push x)
		(set! data (cons x data))
		)
	(define (pop x)
		(define popped (car data))
		(set! data (cdr data))
		popped
		)
	(define (size)
		(length data)
		)
	this
	)

(define s (Stack)) ; s is an environment
((s ' push) 3) ; push 3 onto Stack
((s ' pop)) ; returns 3