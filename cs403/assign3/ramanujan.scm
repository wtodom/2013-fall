(include "assign3/stream.lib")

(define (pairs s t)
	(cons-stream
		(list (stream-car s) (stream-car t))
		(interleave
			(stream-map (lambda (x)
				(list (stream-car s) x))
				(stream-cdr t)
				)
			(pairs (stream-cdr s) (stream-cdr t))
			)
		)
	)

(define (merge-weighted s1 s2 p?)
	(cond
		((null? s1) s2)
		((null? s2) s1)
		((p? (stream-car s1) (stream-car s2))
			(stream-cons (stream-car s1) s2)
			)
		(else
			(stream-cons (stream-car s2) s1)
			)
		)
	)

(define (merge s1 s2)
	(cond
		((stream-null? s1) s2)
		((stream-null? s2) s1)
		(else
			(let
				((s1car (stream-car s1)) (s2car (stream-car s2)))
				(cond
					((< s1car s2car)
						(cons-stream
							s1car
							(merge
								(stream-cdr s1)
								s2
								)
							)
						)
					((> s1car s2car)
						(cons-stream
							s2car
							(merge
								s1
								(stream-cdr s2)
								)
							)
						)
					(else
						(cons-stream
							s1car
							(merge
								(stream-cdr s1)
								(stream-cdr s2)
								)
							)
						)
					)
				)
			)
		)
	)



(define (Ramanujan s)
	(define (stream-cadr s) (stream-car (stream-cdr s)))
	(define (stream-cddr s) (stream-cdr (stream-cdr s)))
	(let (
		(scar (stream-car s))
		(scadr (stream-cadr s))
		)

		(if (= (sum-triple scar) (sum-triple scadr))
			(cons-stream
				(list (sum-triple scar) scar scadr)
				(Ramanujan (stream-cddr s))
				)
			; else
			(Ramanujan (stream-cdr s))
			)
		)
	)

(define (triple x)
	(* x x x)
	)

(define (sum-triple x)
	(+ (triple (car x)) (triple (cadr x)))
	)

(define Ramanujan-numbers
	(Ramanujan (merge-weighted integers integers sum-triple))
	)

(stream-print Ramanujan-numbers 0 5)