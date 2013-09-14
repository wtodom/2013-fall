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
		((<= c hemiobol) 0)
		((and (> c hemiobol) (<= d dactylos)) 5)
		(else (+ c (zeno_cost (/ d 2.0) (* c f) f)))
		)
	)

;3
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
		(int (string (* (sin (+ (* (/ value 100.0) (/ pi 2)) (/ pi 2))) 255)))
		)
	(define (yellow) ;; done
		(int (string (* (+ (* -1 (sin (* (/ value 100.0) pi))) 1) 255)))
		)
	(define (magenta)
		(int (string (/ (* (+ (sin (+ (* (/ (* 3 pi) 2) (/ value 100.0)) (/ pi 2))) 1) 255) 2)))
		)

	(buildHexString (cyan) (yellow) (magenta))
	)


;4
; helpers
(define e .0000001)

(define (improve12 guess x)
	(/ (+ (* 11 guess) (/ x (expt guess 11))) 12)
	)

(define (good-enough12? guess x)
	(< (abs (- (expt guess 12) x)) e)
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
(define (zorp i f)
	(define (innerZorp threeBack twoBack oneBack curr)
		(cond
			((= curr i) threeBack)
			(else
				(innerZorp twoBack oneBack (+ oneBack (/ (square (- oneBack twoBack)) (+ (- threeBack (* 2 twoBack)) oneBack))) (+ curr 1))
				)
			)
		)
	(innerZorp (f 0) (f 1) (f 2) 0)
	)

;8
(define (square num)
	(define (squareIter i total)
		(cond
			((= i 0) total)
			(else
				(squareIter (- i 1) (- (+ total i i ) 1))
				)
			)
		)
	(squareIter num 0)
	)

(define (halve num)
	(define (halveIter i)
		(cond
			((= (+ i i) num) i)
			(else
				(halveIter (+ i 1))
				)
			)
		)
	(halveIter 0)
	)

(define (babyl* a b)
	(halve (- (square (+ a b)) (square a) (square b)))
	)

;9
(define (firstDigitAt depth)
	(cond
		((= depth 0) 1)
		(else
			(+ 1 (* 4 depth))
			)
		)
	)

(define (iFirstDigitAt depth)
	(cond
		((= depth 0) 1)
		(else
			(+ 1 (* 4 (- depth 1)))
			)
		)
	)

(define (mystery depth)
	(define (innerMystery curr)
		(cond
			((>= curr depth) 1)
			(else
				(+ 1 (/ 1.0 (+ (firstDigitAt curr) (/ 1.0 (+ 1 (/ 1.0 (innerMystery (+ curr 1))))))))
				)
			)
		)
	(innerMystery 0)
	)

(define (imystery depth)
	(define (innerMystery curr total)
		(cond
			((= curr 0) total)
			(else
				(innerMystery (- curr 1) (+ 1 (/ 1.0 (+ (iFirstDigitAt curr) (/ 1.0 (+ 1 (/ 1.0 total)))))))
				)
			)
		)
	(innerMystery depth 1)
	)

;10
(define (ramanujan depth)
	(define (innerRamanujan curr)
		(cond
			((= depth curr) 1)
			(else
				(sqrt (+ 1 (* (+ curr 2) (innerRamanujan (+ curr 1)))))
				)
			)
		)
	(innerRamanujan 0)
	)

(define (iramanujan depth)
	(define (iramanujanIter total curr)
		(cond
			((= curr 0) total)
			(else
				(iramanujanIter (sqrt (+ 1 (* (+ 1 curr) total))) (- curr 1))
				)
			)
		)
	(iramanujanIter 1 depth)
	)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;; Test Calls ;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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
	(println "[It should be 8650724...I think.]")
	(newline)

	(inspect (zeno_cost 40 3 0.3))
	(println "[It should be 4.17]")
	)

(define (run3) ;;; DONE ;;;
	(inspect (cym 0))
	(println "[It should be #FFFFFF]")
	(newline)

	(inspect (cym 50))
	(println "[It should be #B40025]")
	(newline)

	(inspect (cym 100))
	(println "[It should be #00FF7F]")
	(newline)
	)

(define (run4) ;;; DONE ;;;
	(inspect (root12 15))
	(println "[It should be 1.253163]")
	
	(newline)

	(inspect (root12 91234523))
	(println "[It should be 4.606240]")
	)

(define (run5) ;;; DONE ;;;
	(println "(pt 0)")
	(pt 0)
	(newline)
	(println "(pt 5)")
	(pt 5)
	(newline)
	(println "(pt 10)")
	(pt 10)
	(newline)
	(println "(pt 15)")
	(pt 15)
	)

(define (run6) ;;; DONE ;;;
	(inspect (curryAdd 1 24 3))
	(inspect ((((curry curryAdd) 3) 24) 1))
	)

(define (run7) ;;; DONE ;;;
	(inspect square)

	(inspect (zorp 0 square))
	(println "[It should be 0]")
	(newline)

	(inspect (zorp 2 square))
	(println "[It should be 4]")
	(newline)

	(inspect (zorp 3 square))
	(println "[It should be 5]")
	(newline)

	(inspect (zorp 4 square))
	(println "[It should be 24]")
	(newline)

	(inspect (zorp 5 square))
	(println "[It should be 45]")
	(newline)
	)

(define (run8) ;;; DONE ;;;
	(inspect (babyl* 1 0))
	(println "[It should be 0]")
	(newline)

	(inspect (babyl* 3 4))
	(println "[It should be 12]")
	(newline)

	(inspect (babyl* 5 12))
	(println "[It should be 60]")
	(newline)

	(inspect (babyl* 10 62))
	(println "[It should be 620]")
	(newline)


	(newline)

	(inspect (halve 0))
	(println "[It should be 0]")
	(newline)

	(inspect (halve 4))
	(println "[It should be 2]")
	(newline)

	(inspect (halve 12))
	(println "[It should be 6]")
	(newline)

	(inspect (halve 62))
	(println "[It should be 31]")
	(newline)


	(newline)
	
	(inspect (square 0))
	(println "[It should be 0]")
	(newline)

	(inspect (square 4))
	(println "[It should be 16]")
	(newline)

	(inspect (square 12))
	(println "[It should be 144]")
	(newline)

	(inspect (square 62))
	(println "[It should be 3844]")
	(newline)

	)

(define (run9) ;;; DONE ;;;
	(inspect (imystery 100))
	(inspect (mystery 100))
	(println "[They should be 1.648721]")
	(newline)
	(println "100 iterations easily reaches scam's floating point precision limit.")
	(println "The equation converges to the square root of the mathematical constant e.")
	)

(define (run10) ;;; DONE ;;;
	(inspect (iramanujan 100))
	(inspect (ramanujan 100))
	(println "[They should be 3]")
	(newline)
	(println "Again, 100 iterations easily reaches scam's floating point precision limit.")
	(println "The answer to Ramanujan's questions is that the value converges to 3.")
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
(newline)

(println "assignment 1 loaded!")
