(define (author)
	(println "AUTHOR: Weston Odom weston.odom@gmail.com")
	)

;1
(define (my-if a b c)
    (if (true? a)
        b
        c
        )
    )

;2
; helpers	
(define hemiobol (/ 1 (real 12)))
(define dactylos (/ 1 (real 9600)))

;main function
(define (zeno_cost d c f)
	(cond
		((<= (* c f) hemiobol) 0)
		((and (> (* c f) hemiobol) (<= d dactylos)) 5)
		(else (+ c (zeno_cost (/ d (real 2)) (* c f) f)))
		)
	)

;4
; helpers
(define e .0000001)
(define (power11 x)
	(* x x x x x x x x x x x)
	)
(define (power12 x)
	(* x x x x x x x x x x x x)
	)
(define (improve12 guess x)
	(/ (+ (* 11 guess) (/ x (power11 guess))) 12)
	)
(define (good-enough12? guess x)
	(< (abs (- (power12 guess) x)) e)
	)

; main function
(define (root12 guess x)
	(if (good-enough12? guess x)
		guess
		(root12 (improve12 guess x) x)
		)
	)





(define (run1)
)

(define (run2)
	(inspect (zeno_cost 20 33 2))
	(inspect (zeno_cost 40 3 0.3))
	)

(define (run3)

	(define Pi 3.14159265358979323846)
	(define (cyan value)

		)
	(define (yellow value)

		)
	(define (magenta value)

		)

	(define (cym value)
		
		)
	)

(define (run4)
	(inspect (root12 1.0 15))
	(inspect (root12 1.0 91234523))
	)

(define (run5)

	(define (pt n)

		)
	)

(define (run6)
	
	(define (f a b c)
		(+ a b c)
		)

	(define (curry f) ; NOT CORRECT
		(lambda (a)
			(lambda (b)
				(lambda (c)
					(+ a b c))))
		)

	(inspect (f 1 24 3))
	(inspect ((((curry f) 3) 24) 1))
	)
(define (run7)
	)
(define (run8)
	)
(define (run9)
	)
(define (run10)
	)

(newline)
(println "1.")
(run1)
(newline)
(println "2.")
(run2)
(newline)
(println "3.")
(run3)
(newline)
(println "4.")
(run4)
(newline)
(println "5.")
(run5)
(newline)
(println "6.")
(run6)
(newline)
(println "7.")
(run7)
(newline)
(println "8.")
(run8)
(newline)
(println "9.")
(run9)
(newline)
(println "10.")
(run10)

(println "assignment 1 loaded!")