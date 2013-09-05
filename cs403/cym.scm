(define hexValues (list "0" "1" "2" "3" "4" "5" "6" "7"
						"8" "9" "A" "B" "C" "D" "E" "F"))

(define pi 3.14159265358979323846)

(define (int2hex value)
	(define lsd (getElement hexValues (% value 16)))
	(define msd (getElement hexValues (/ value 16)))
	(string+ (string msd) (string lsd))
	)

(define (buildHexString cyan yellow magenta)
	(define hex "#")
	(string+ 
		hex (string (int2hex cyan))
			(string (int2hex yellow))
			(string (int2hex magenta))
		)
	)

(define (cym value)

	(define (cyan) ;; done
		(int (* (sin (+ (* (/ value 100.0) (/ pi 2)) (/ pi 2))) 255))
		)
	(define (yellow) ;; done
		(int (* (+ (* -1 (sin (* (/ value 100.0) pi))) 1) 255))
		)
	(define (magenta)
		(int (/ (* (+ (sin (+ (* (/ (* 3 pi) 2) (/ value 100.0)) (/ pi 2))) 1) 255) 2))
		)

	(buildHexString (cyan) (yellow) (magenta))
	)


(inspect (cym 0))
(inspect (cym 50))
(inspect (cym 100))