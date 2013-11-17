; difference between pass-by-value and pass-by-reference results can be seen using an alias

; main difference between the two is that with PBV you can't change anything
; but the localvalues of the formal parameters, but with PBR you can.

; PBR swap in scam:

(define (swap # $a $b)
	(define temp (# $b))  ; could also do: (get $b #)
	(set $b (# $a) #)  ; set a value to something in a particular environment
	(set $a temp #)
	)

; pass-by-value-result version of above:

(define (swap # $a $b)
	(define a (# $a))  ; these two defines are the "value part"
	(define b (# $b))

	(define temp a)
	(set! a b)
	(set! b temp)

	(set $a a #)  ; these two sets are the result part
	(set $b b #)
	)

; alias examples in pics @ ~11:40


; call-by-name (algol)

; call-by-need

; call-by-name-using-thunks


NOTES ON THE WEBSITE