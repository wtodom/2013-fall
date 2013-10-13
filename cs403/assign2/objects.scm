(define oldplus +)

(define (Integer val)
	(define (add other) ; TODO
		(Integer (oldplus ((value)) ((other'value))))
		)
	(define (promote) ; DONE
		(Rational val 1)
		)
	(define (demote) ; DONE
		this
		)
	(define (rank) ; DONE
		0
		)
	(define (toString) ; DONE
		(string val)
		)
	(define (value) ; DONE
		val
		)
	this
	)

(define (gcd a b) ; taken from rosettacode.org
	(if (= b 0)
		a
		(gcd b (% a b))
		)
	)

(define (Rational numerator denominator)
	(define (simplest n-or-d) ; pass 'n or 'd to get that term in lowest form
		(cond
			((eq? n-or-d 'n) (/ numerator (gcd numerator denominator)))
			(else
				(/ denominator (gcd numerator denominator))
				)
			)
		)
	(define (add other) ; TODO

		)
	(define (promote) ; DONE
		(Real (* (/ (simplest 'n) (simplest 'd)) 1000000) 6)
		)
	(define (demote) ; DONE
		(Integer (int (/ (simplest 'n) (simplest 'd))))
		)
	(define (rank) ; DONE
		1 
		)
	(define (toString) ; DONE
		(string+ (string (simplest 'n)) "/" (string (simplest 'd)))
		)
	(define (value) ; DONE
		(/ (simplest 'n) (simplest 'd))
		)
	this
	)

; (inspect (((Rational 3 5)'toString)))

(define (Real integerVersion decIndex)
	(define (add other) ; TODO

		)
	(define (promote) ; DONE
		(Complex (value) 0)
		)
	(define (demote) ; TODO
		(Rational )
		)
	(define (rank) ; DONE
		2
		)
	(define (toString) ; DONE
		(string+ (string integerVersion) "e-" (string decIndex))
		)
	(define (value) ; DONE
		(/ (real integerVersion) (^ 10 decIndex))
		)
	this
	)

(inspect (((Real 3 5)'toString)))
(inspect (((Real 3 5)'value)))

(define (Complex realPart imaginaryPart)
	(define (add other) ; TODO

		)
	(define (promote) ; DONE
		this
		)
	(define (demote) ; DONE
		(cond
			((not (contains (string realPart) ".")) (Real realPart (length (string realPart))))
			(else
				(define decIndex (indexOf "." (string realPart)))
				(Real 
					(int 
						(string+ 
							(substring 0 decIndex)
							(substring (+ decIndex 1) (length (string realPart)))
							)
						)
					decIndex
					)
				)
			)
		)
	(define (rank) ; DONE
		3
		)
	(define (toString) ; DONE
		(string+ realPart "+" imaginaryPart "i")
		)
	(define (value) ; DONE
		(list realPart imaginaryPart)
		)
	this
	)