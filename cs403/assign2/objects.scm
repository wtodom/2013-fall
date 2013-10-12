(define oldplus +)

(define (Integer i)
	(define (add intA intB) ; TODO
		(oldplus intA intB)
		)
	(define (promote) ; DONE
		(Rational i 1)
		)
	(define (demote) ; DONE
		this
		)
	(define (rank) ; DONE
		0
		)
	(define (toString) ; DONE
		(string i)
		)
	(define (value) ; DONE
		i
		)
	this
	)

(inspect (((Integer 0)'toString)))
(println "    [it should be 0]\n")
(inspect (((Integer 0)'rank)))
(println "    [it should be a number]\n")
(inspect (((+ (Integer 0) (Integer 0) (Integer 0))'value)))
(println "    [it should be 0]\n")
(inspect (+ 3 5 1))
(println "    [it should be 9]\n")

(define (Rational numerator denominator)
	(define (add ratA ratB) ; TODO

		)
	(define (promote) ; TODO

		)
	(define (demote) 
		(Integer (int (/ numerator denominator)))
		)
	(define (rank) ; DONE
		1
		)
	(define (toString) ; DONE
		(string+ (string numerator) "/" (string denominator))
		)
	(define (value) ; TODO

		)
	this
	)

(define (Real integerPart decimalPart)
	(define (add realA realB) ; TODO

		)
	(define (promote) ; TODO

		)
	(define (demote) ; TODO

		)
	(define (rank) ; DONE
		2
		)
	(define (toString) ; DONE
		(string+ (string integerPart) "." (string decimalPart))
		)
	(define (value) ; TODO

		)
	this
	)

(define (Complex realPart imaginaryPart)
	(define (add complexA complexB) ; TODO

		)
	(define (promote) ; DONE
		this
		)
	(define (demote) ; TODO

		)
	(define (rank) ; DONE
		3
		)
	(define (toString) ; TODO

		)
	(define (value) ; TODO

		)
	this
	)