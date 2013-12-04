(include "assign3/stream.lib")

(define (integral-from-book integrand initial-value dt)
	(define int
		(cons-stream
			initial-value
			(add-streams
				(scale-stream integrand dt)
				int
				)
			)
		)
	int
	)

(define (signal f x dx)
	(cons-stream (f x) (signal f (+ x dx) dx))
	)

(define poly
	(signal (lambda (x) (+ (^ x 2) (* 3 x) (- 0 4))) 0 1)
	)

(define (integral s dx)

	)

(define (differential s dx)

	)

(define substreams stream-sub)  ; I already defined this in my library