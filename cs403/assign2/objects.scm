(include "ci.lib")


(define oldplus +)

(define (Integer val)
	(define (add other)
		(Integer (oldplus (value) ((other'value))))
		)
	(define (promote)
		(Rational val 1)
		)
	(define (demote)
		this
		)
	(define (rank)
		0
		)
	(define (toString)
		(string val)
		)
	(define (value)
		val
		)
	this
	)

(define (Rational numer denom)
	(define (simplest n-or-d) ; pass 'n or 'd to get that term in lowest form
		(cond
			((eq? n-or-d 'n) (/ (real numer) (gcd numer denom)))
			(else
				(/ (real denom) (gcd numer denom))
				)
			)
		)
	(define (add other)
		(Rational (+ (* numer (other'denom)) (* (other'numer) denom)) (* denom (other'denom)))
		)
	(define (promote)
		(Real (* (/ (real (simplest 'n)) (simplest 'd)) 1000000) 6)
		)
	(define (demote)
		(Integer (int (/ (simplest 'n) (simplest 'd))))
		)
	(define (rank)
		1 
		)
	(define (toString)
		(string+ (string (int (simplest 'n))) "/" (string (int (simplest 'd))))
		)
	(define (value)
		(/ (simplest 'n) (simplest 'd))
		)
	this
	)

(define (Real integerVersion decIndex)
	(define (add other)
		(Real (+ (/ integerVersion (^ 10.0 decIndex)) (/ (other'integerVersion) (^ 10.0 (other'decIndex)))) 0)
		)
	(define (promote)
		(Complex (value) 0)
		)
	(define (demote)
		(Rational integerVersion (^ 10.0 decIndex))
		)
	(define (rank)
		2
		)
	(define (toString)
		(string+ (string integerVersion) "e-" (string decIndex))
		)
	(define (value)
		(/ (real integerVersion) (^ 10.0 decIndex))
		)
	this
	)

(define (Complex realPart imaginaryPart)
	(define (add other)
		(Complex (((realPart'add) (other'realPart))) (((imaginaryPart'add) (other'imaginaryPart))))
		)
	(define (promote)
		this
		)
	(define (demote)
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
	(define (rank)
		3
		)
	(define (toString)
		(string+ (string ((realPart'value))) "+" (string ((imaginaryPart'value))) "i")
		)
	(define (value)
		(list ((realPart'value)) ((imaginaryPart'value)))
		)
	this
	)

(define (+ @)
	(inspect @)
	(inspect (car @))
	(inspect (cdr @))
	(cond ;;; REFACTOR HERE some of these binary conds to ifs
		((not (object? (car @))) (oldplus @))
		(else ; if they are objects
			(cond
				((null? (cdr @)) @) ; only one number passed to +
				(else
					(cond
						((null? (cddr @)) ; only two numbers to add
							(cond
								((> (((car @)'rank)) (((cadr @)'rank))) (apply + (list (car @) (((cadr @)'promote)))))
								((< (((cadr @)'rank)) (((car @)'rank))) (apply + (list (((car @)'promote)) (cadr @))))
								(else
									((((car @)'add) (cadr @)))
									)
								)
							)
						(else
							(cond
								((< (((car @)'rank)) (((cadr @)'rank))) (apply + (list (car @) (((cadr @)'promote)) (cddr @))))
								((< (((cadr @)'rank)) (((car @)'rank))) (apply + (list (((car @)'promote)) (cadr @) (cddr @))))
								(else
									(apply + (list ((((car @)'add) (cadr @))) (cddr @)))
									)
								)
							)
						)
					)
				)
			)
		)
	)

(inspect (((+ (Integer 5) (Real 3 1))'value)))

;$

;{;;;;;;;;;;;;;;;;;;;;;;

Integer tests

;};;;;;;;;;;;;;;;;;;;;;;

(define five (Integer 5))
(define two (Integer 2))
(inspect (((((five'add) two))'value)))



;{;;;;;;;;;;;;;;;;;;;;;;

Rational tests

;};;;;;;;;;;;;;;;;;;;;;;


(define twothirds (Rational 2 3))
(define thirteen221sts (Rational 13 221))

(inspect ((twothirds'value)))
(inspect ((twothirds'rank)))
(inspect ((twothirds'toString)))

(inspect (((((twothirds'add) thirteen221sts))'value)))


;{;;;;;;;;;;;;;;;;;;;;;;

Real tests

;};;;;;;;;;;;;;;;;;;;;;;


(define point333 (Real 333 3))
(define twopoint333 (Real 2333 3))

(inspect (twopoint333'integerVersion))

(inspect ((point333'value)))
(inspect ((point333'rank)))
(inspect ((point333'toString)))

(inspect ((twopoint333'value)))
(inspect ((twopoint333'rank)))
(inspect ((twopoint333'toString)))
(inspect (((((point333'add) twopoint333))'value)))


;{;;;;;;;;;;;;;;;;;;;;;;

Complex tests

;};;;;;;;;;;;;;;;;;;;;;;

(define one+2i (Complex (Real 1 0) (Real 2 0)))
(define point3+-.2i (Complex (Real 3 1) (Real -2 1)))

(inspect ((one+2i'value)))
(inspect ((one+2i'toString)))

(inspect ((point3+-.2i'value)))
(inspect ((point3+-.2i'toString)))

(inspect (((((one+2i'add) point3+-.2i))'toString)))