(define (author)
	(println "AUTHOR: Weston Odom weston.odom@gmail.com")
	)

;1
;; Everything is inside of the run function.

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

;3
(define Pi 3.14159265358979323846)
(define (cyan value)

	)
(define (yellow value)

	)
(define (magenta value)

	)

(define (cym value)
	7
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
(define (root12 x)
	(define (rootIter guess)
		(if (good-enough12? guess x)
			guess
			(rootIter (improve12 guess x))
			)
		)
	(rootIter 1.0)
	)

;5
(define (choose n k)
	(define (chooseIter i store)
		(cond
			((= i (+ k 1)) (int (string store)))
			(else
				(chooseIter (+ i 1) (* store (/ (- n (- k i)) (real i)))))
			)
		)
	(chooseIter 1 1)
	)

(define (printSpaces n)
	(cond
		((= n 0) nil)
		(else
			(print " ")
			(printSpaces (- n 1))
			)
		)
	)

(define (pascalPrint maxDepth currentDepth)
	(printSpaces (- maxDepth currentDepth))

	(define (rowIter index)
		(print (choose currentDepth index))
		(cond
			((= index currentDepth) (newline))
			(else
				(print " ")
				(rowIter (+ index 1))
				)
			)
		)
	(rowIter 0)
	)

(define (pt depth)
	(define (pascalIter k)
		(pascalPrint depth k)
		(if (!= depth k) 
			(pascalIter (+ k 1))
			)
		)
	(pascalIter 0)
	)
;6
	
(define (curryAdd a b c)
	(+ a b c)
	)

(define (curry f)
	(lambda (a)
		(lambda (b)
			(lambda (c)
				(f a b c))))
	)
;7

;8

;9

;10






(define (run1) ;;; DONE ;;;
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

(define (run2) ;;; DONE ;;;
	(inspect (zeno_cost 20 33 2))
	(inspect (zeno_cost 40 3 0.3))
	)

(define (run3)

	)

(define (run4) ;;; DONE ;;;
	(inspect (root12 15))
	(inspect (root12 91234523))
	)

(define (run5) ;;; DONE ;;;
	(println "(pt 0)")
	(pt 0)
	(println "(pt 5)")
	(pt 5)
	(println "(pt 10)")
	(pt 10)
	(println "(pt 15)")
	(pt 15)
	)

(define (run6) ;;; DONE ;;;
	(inspect (curryAdd 1 24 3))
	(inspect ((((curry curryAdd) 3) 24) 1))
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