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
		(Integer val)
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
		(Rational (oldplus (* numer (other'denom)) (* (other'numer) denom)) (* denom (other'denom)))
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
		(Real (oldplus (/ integerVersion (^ 10.0 decIndex)) (/ (other'integerVersion) (^ 10.0 (other'decIndex)))) 0)
		)
	(define (promote)
		(Complex (Real integerVersion decIndex) (Real 0 0))
		)
	(define (demote)
		(Rational integerVersion (int (^ 10.0 decIndex)))
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
		(Complex realPart imaginaryPart)
		)
	(define (demote)
		; (cond
		; 	((not (contains (string realPart) ".")) (Real realPart (strLength (string realPart))))
		; 	(else
		; 		(define decIndex (indexOf "." (string realPart)))
		; 		(Real
		; 			(int
		; 				(string+
		; 					(substring 0 decIndex)
		; 					(substring (+ decIndex 1) (strLength (string realPart)))
		; 					)
		; 				)
		; 			decIndex
		; 			)
		; 		)
		; 	)
		realPart
		)
	(define (rank)
		3
		)
	(define (toString)
		(if (> 0 ((imaginaryPart'value)))
			(string+ (string ((realPart'value))) (string ((imaginaryPart'value))) "i")
			(string+ (string ((realPart'value))) "+" (string ((imaginaryPart'value))) "i")
			)
		)
	(define (value)
		(list ((realPart'value)) ((imaginaryPart'value)))
		)
	this
	)

(define (+ @)
	; (inspect (car @))
	; (inspect (cadr @))
	(if (not (object? (car @)))
		(oldplus @) ; if they're just regular ints or reals or whatever
		(if (null? (cdr @)) 
			@ ; if only one number passed to +, just return it
			(if (null? (cddr @)) ; only two numbers to add
				(cond
					((> (((car @)'rank)) (((cadr @)'rank))) (apply + (list (car @) (((cadr @)'promote)))))
					((< (((car @)'rank)) (((cadr @)'rank))) (apply + (list (((car @)'promote)) (cadr @))))
					(else
						((((car @)'add) (cadr @)))
						)
					)
				(cond
					; ((< (((car @)'rank)) (((cadr @)'rank))) (apply + (list (car @) (((cadr @)'promote)) (cddr @))))
					; ((< (((cadr @)'rank)) (((car @)'rank))) (apply + (list (((car @)'promote)) (cadr @) (cddr @))))
					(else
						; (apply + (list ((((car @)'add) (cadr @))) (cddr @)))
						)
					)
				)
			)
		)
	)

;  .----------------.  .----------------.  .----------------.  .----------------.  .----------------. 
; | .--------------. || .--------------. || .--------------. || .--------------. || .--------------. |
; | |  _________   | || |  _________   | || |    _______   | || |  _________   | || |    _______   | |
; | | |  _   _  |  | || | |_   ___  |  | || |   /  ___  |  | || | |  _   _  |  | || |   /  ___  |  | |
; | | |_/ | | \_|  | || |   | |_  \_|  | || |  |  (__ \_|  | || | |_/ | | \_|  | || |  |  (__ \_|  | |
; | |     | |      | || |   |  _|  _   | || |   '.___`-.   | || |     | |      | || |   '.___`-.   | |
; | |    _| |_     | || |  _| |___/ |  | || |  |`\____) |  | || |    _| |_     | || |  |`\____) |  | |
; | |   |_____|    | || | |_________|  | || |  |_______.'  | || |   |_____|    | || |  |_______.'  | |
; | |              | || |              | || |              | || |              | || |              | |
; | '--------------' || '--------------' || '--------------' || '--------------' || '--------------' |
;  '----------------'  '----------------'  '----------------'  '----------------'  '----------------' 



;  /$$$$$$             /$$                                            
; |_  $$_/            | $$                                            
;   | $$   /$$$$$$$  /$$$$$$    /$$$$$$   /$$$$$$   /$$$$$$   /$$$$$$ 
;   | $$  | $$__  $$|_  $$_/   /$$__  $$ /$$__  $$ /$$__  $$ /$$__  $$
;   | $$  | $$  \ $$  | $$    | $$$$$$$$| $$  \ $$| $$$$$$$$| $$  \__/
;   | $$  | $$  | $$  | $$ /$$| $$_____/| $$  | $$| $$_____/| $$      
;  /$$$$$$| $$  | $$  |  $$$$/|  $$$$$$$|  $$$$$$$|  $$$$$$$| $$      
; |______/|__/  |__/   \___/   \_______/ \____  $$ \_______/|__/      
;                                        /$$  \ $$                    
;                                       |  $$$$$$/                    
;                                        \______/                     



(define five (Integer 5))
(define two (Integer 2))

; (inspect ((five'rank)))
; (inspect ((five'toString)))
; (inspect ((five'value)))
; (inspect ((five'demote)))
; (inspect ((((five'demote))'value)))
; (inspect ((five'promote)))
; (inspect ((((five'promote))'value)))
; (inspect (((((five'add) two))'value)))



;  /$$$$$$$              /$$     /$$                               /$$
; | $$__  $$            | $$    |__/                              | $$
; | $$  \ $$  /$$$$$$  /$$$$$$   /$$  /$$$$$$  /$$$$$$$   /$$$$$$ | $$
; | $$$$$$$/ |____  $$|_  $$_/  | $$ /$$__  $$| $$__  $$ |____  $$| $$
; | $$__  $$  /$$$$$$$  | $$    | $$| $$  \ $$| $$  \ $$  /$$$$$$$| $$
; | $$  \ $$ /$$__  $$  | $$ /$$| $$| $$  | $$| $$  | $$ /$$__  $$| $$
; | $$  | $$|  $$$$$$$  |  $$$$/| $$|  $$$$$$/| $$  | $$|  $$$$$$$| $$
; |__/  |__/ \_______/   \___/  |__/ \______/ |__/  |__/ \_______/|__/



(define twothirds (Rational 2 3))
(define thirteen221sts (Rational 13 221))

; (inspect ((twothirds'value)))
; (inspect ((twothirds'rank)))
; (inspect ((twothirds'toString)))
; (inspect ((twothirds'demote)))
; (inspect ((((twothirds'demote))'value)))
; (inspect ((twothirds'promote)))
; (inspect ((((twothirds'promote))'value)))

; (inspect (((((twothirds'add) thirteen221sts))'value)))


;  /$$$$$$$                      /$$
; | $$__  $$                    | $$
; | $$  \ $$  /$$$$$$   /$$$$$$ | $$
; | $$$$$$$/ /$$__  $$ |____  $$| $$
; | $$__  $$| $$$$$$$$  /$$$$$$$| $$
; | $$  \ $$| $$_____/ /$$__  $$| $$
; | $$  | $$|  $$$$$$$|  $$$$$$$| $$
; |__/  |__/ \_______/ \_______/|__/



(define point333 (Real 333 3))
(define twopoint333 (Real 2333 3))

; (inspect (twopoint333'integerVersion))

; (inspect ((point333'value)))
; (inspect ((point333'rank)))
; (inspect ((point333'toString)))
; (inspect ((point333'demote)))
; (inspect ((((point333'demote))'value)))
; (inspect ((point333'promote)))
; (inspect ((((point333'promote))'value))) ; DOESN'T WORK
; (inspect (((((point333'add) twopoint333))'value)))


;   /$$$$$$                                    /$$                    
;  /$$__  $$                                  | $$                    
; | $$  \__/  /$$$$$$  /$$$$$$/$$$$   /$$$$$$ | $$  /$$$$$$  /$$   /$$
; | $$       /$$__  $$| $$_  $$_  $$ /$$__  $$| $$ /$$__  $$|  $$ /$$/
; | $$      | $$  \ $$| $$ \ $$ \ $$| $$  \ $$| $$| $$$$$$$$ \  $$$$/ 
; | $$    $$| $$  | $$| $$ | $$ | $$| $$  | $$| $$| $$_____/  >$$  $$ 
; |  $$$$$$/|  $$$$$$/| $$ | $$ | $$| $$$$$$$/| $$|  $$$$$$$ /$$/\  $$
;  \______/  \______/ |__/ |__/ |__/| $$____/ |__/ \_______/|__/  \__/
;                                   | $$                              
;                                   | $$                              
;                                   |__/                              



(define one+2i (Complex (Real 1 0) (Real 2 0)))
(define point3+-.2i (Complex (Real 3 1) (Real -2 1)))

; (inspect ((point3+-.2i'value)))
; (inspect ((point3+-.2i'toString)))
; (inspect ((point3+-.2i'demote)))
; (inspect ((((point3+-.2i'demote))'value)))
; (inspect ((point3+-.2i'promote)))
; (inspect ((((point3+-.2i'promote))'value)))

; (inspect (((((one+2i'add) point3+-.2i))'toString)))



;                   /$$$$$$                                /$$                           /$$
;     /$$          /$$__  $$                              | $$                          | $$
;    | $$         | $$  \ $$ /$$    /$$ /$$$$$$   /$$$$$$ | $$  /$$$$$$   /$$$$$$   /$$$$$$$
;  /$$$$$$$$      | $$  | $$|  $$  /$$//$$__  $$ /$$__  $$| $$ /$$__  $$ |____  $$ /$$__  $$
; |__  $$__/      | $$  | $$ \  $$/$$/| $$$$$$$$| $$  \__/| $$| $$  \ $$  /$$$$$$$| $$  | $$
;    | $$         | $$  | $$  \  $$$/ | $$_____/| $$      | $$| $$  | $$ /$$__  $$| $$  | $$
;    |__/         |  $$$$$$/   \  $/  |  $$$$$$$| $$      | $$|  $$$$$$/|  $$$$$$$|  $$$$$$$
;                  \______/     \_/    \_______/|__/      |__/ \______/  \_______/ \_______/


(inspect (+ five point3+-.2i))
(inspect (((+ five point3+-.2i)'toString)))
(inspect (((+ five point3+-.2i)'value)))