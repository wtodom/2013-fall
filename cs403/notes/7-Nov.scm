(define (interleave s t)
	(cons-stream
		(stream-car s)
		(interleave t (stream-cdr s))
		)
	)

(define (ints-from x)
	(cons-stream
		x
		(ints-from (+ x 1))
		)
	)

(define (expand-front items value)
	(map
		(lambda (x) (list value x))
		items
		)
	)

(define (pairs i)
	(cons-stream
		(list i i)
		(interleave
			(expand (ints-from (+ i 1) i 'front)) ; can replace this with the expand-front above
			(pairs (+ i 1))
			)
		)
	)

;===========================;

parameter passing

call-by-X
pass-by-X

C is pass-by-value. Formal parameters can be thought of
as copies of the original items.
