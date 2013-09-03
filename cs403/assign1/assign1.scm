; TODO: wrap each problem's functions inside another function for scoping

(define (author)
	(println "AUTHOR: Weston Odom weston.odom@gmail.com")
	)

;1 ;;: DONE :::
;; Everything is inside of the run function.

;2 ;;; DONE ;;;
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

;3


;4 ;;; DONE ;;;
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

;5 ;;; KINDA (see pascal2.scm) ;;;

;6

;7

;8

;9

;10






(define (run1)
	(define (my-if a b c)
    (if (true? a)
        b
        c
        )
    )

(println "'my-if' and 'if' perform differently due to the 
consequent and alternative being evaluated/replaced in a 
different way. In the original if, only the statement 
that is appropriate based on the predicate's value is
evaluated. However, in 'my-if', both parts are evaluated 
before the predicate. For many statements (such as the one 
given as an example) this doesn't have much effect, but when
the consequent and/or alternative can have side effects or 
produce output, unintended consequences will occur.

For example, consider the following two statements:

(if #t 
	(println 'Regular if prints this if true.') 
	(println 'Regular if prints this if false.')
	)

(my-if #t 
	(println 'My-if prints this if true.) 
	(println 'My-if prints this if false.')
	)

In these cases, both the consequent and alternative produce 
output, so evaluating them prior to the predicate will result
in malfunctioning code.

Below is the output of the two statements. Notice that for 
the original 'if' only one statement prints, whereas for 
'my-if' both statements print.")

(newline)

(if #t 
	(println "Regular if prints this if true.") 
	(println "Regular if prints this if false.")
	)

(my-if #t 
	(println "My-if prints this if true.") 
	(println "My-if prints this if false.")
	)

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