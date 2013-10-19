(include "wes.lib")
(include "random.lib")

(define (author)
    (println "AUTHOR: Weston Odom wtodom@crimson.ua.edu")
    )

;    /$$  
;  /$$$$  
; |_  $$  
;   | $$  
;   | $$  
;   | $$  
;  /$$$$$$
; |______/

(define (check-and-go $expr1 $expr2)
	(cond
		((not (error? (catch (eval $expr1 this)))) 
			(eval $expr1 this)
			)
		(else
			((eval $expr2 this) (catch (eval $expr1 this)))
			)
		)
	)

;   /$$$$$$ 
;  /$$__  $$
; |__/  \ $$
;   /$$$$$$/
;  /$$____/ 
; | $$      
; | $$$$$$$$
; |________/

(define (curry x)
	(define params (get ' parameters x))
	(define me this)

	(define (cIter paramList lambdas)
		(cond
			((null? paramList)
				(eval lambdas me)
				)
			(else
				(cIter (cdr paramList) (list lambda (list (car paramList)) lambdas))
				)
			)
		)

	(cIter (reverse params) (cons x params))
	)

;   /$$$$$$ 
;  /$$__  $$
; |__/  \ $$
;    /$$$$$/
;   |___  $$
;  /$$  \ $$
; |  $$$$$$/
;  \______/ 

(define (inc x) (cons 'x x))
(define base '(x))

(define (increment number)
	(lambda (incrementer)
		(define (resolver base)
			(incrementer ((number incrementer) base))
			)
		resolver
		)
	)

(define (zero x)
	(lambda (y) y)
	)

(define (one x)
	((increment zero) x)
	)

(define (two x)
	((increment one) x)
	)

(define (three x)
	((increment two) x)
	)

(define (four x)
	((increment three) x)
	)

(define (five x)
	((increment four) x)
	)

(define (six x)
	((increment five) x)
	)

(define (seven x)
	((increment six) x)
	)

(define (eight x)
	((increment seven) x)
	)

(define (nine x)
	((increment eight) x)
	)

(define numbers
	(list
		(list ((zero inc) base) 'zero)
		(list ((one inc) base) 'one)
		(list ((two inc) base) 'two)
		(list ((three inc) base) 'three)
		(list ((four inc) base) 'four)
		(list ((five inc) base) 'five)
		(list ((six inc) base) 'six)
		(list ((seven inc) base) 'seven)
		(list ((eight inc) base) 'eight)
		(list ((nine inc) base) 'nine)
		)
	)

(define (add m n)
	(lambda (incrementer)
		(lambda (x)
			((m incrementer) ((n incrementer) x))
			)
		)
	)

(define (multiply m n)
	(lambda (f) (m (n f)))
	)

(define (translate number)
	(cadr (assoc ((number inc) base) numbers))
	)

;  /$$   /$$
; | $$  | $$
; | $$  | $$
; | $$$$$$$$
; |_____  $$
;       | $$
;       | $$
;       |__/

(define (node value @)
	(cond
		((null? @)
			(list value))
		(else
			(cons value (cons (car @) (cadr @))))
		)
	)

(define (nodeCount tree)
	(length
		(keep 
			(lambda (x) (not (eq? x 'None))) 
			(flatten tree))
		)
	)

;  /$$$$$$$ 
; | $$____/ 
; | $$      
; | $$$$$$$ 
; |_____  $$
;  /$$  \ $$
; |  $$$$$$/
;  \______/

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; These functions use regular style. ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; the "rm-" prefix stands for "row major"

(define (dot-product v w)
	(accumulate + 0 (map * v w))
	)

(define (rm-matrix-*-vector m v)
	(map (lambda (row-in-m) (dot-product row-in-m v)) m)
	)

(define (transpose m)
	(cond
		((eq? (type (car m)) 'CONS)
			(accumulate-n cons () m)
			)
		(else
			(map (lambda (x) (list x)) m)
			)
		)
	)

(define (otranspose m)
	(accumulate-n cons () m)
	)

(define (rm-matrix-*-matrix m n)
	(let ((n-cols (transpose n)))
    	(map
    		(lambda (m-row) (rm-matrix-*-vector n-cols m-row))
        	m
        	)
    	)
	)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; These functions use col maj style. ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (matrix-*-vector m v)
	(rm-matrix-*-vector (transpose m) v)
	)

(define (matrix-*-matrix m n)
	(transpose (rm-matrix-*-matrix (transpose m) (transpose n)))
	)

;   /$$$$$$ 
;  /$$__  $$
; | $$  \__/
; | $$$$$$$ 
; | $$__  $$
; | $$  \ $$
; |  $$$$$$/
;  \______/ 

(define (tuple n m)
	(define (tIter i tuples)
		(cond
			((= n 0) nil)
			((= i n) tuples)
			(else
				(tIter (+ i 1) 
					(accumulate append () 
						(map ; for each 
							(lambda (sublist)
								(map ; for each
									(lambda (x) ; number in the interval
										(cons x sublist)
										)
									(interval 0 (+ (car sublist) 1) 1) ; from 0 to the car of the sublist
									)
								)
							tuples
							)
						)
					)
				)
			)
		)
	(tIter 1 (map (lambda (x) (list x)) (interval 0 (+ m 1) 1)))
	)

;  /$$$$$$$$
; |_____ $$/
;      /$$/ 
;     /$$/  
;    /$$/   
;   /$$/    
;  /$$/     
; |__/      

(define operators '(^ / * - +))

(define (doOne expr opIndex)
	(define (iter i current)
		(cond
			((= i (- opIndex 1))
				(append
					current
					(cons
						(list 
							(getElement expr (+ i 1))
							(getElement expr i)
							(getElement expr (+ i 2))
							)
						(listFromIndex (+ i 3) expr)
						)
					)
				)
			(else
				(iter (+ i 1) (append current (list (getElement expr i)))))
			)
		)
	(iter 0 ())
	)

(define (infix->prefix expr)
	(define (iter ops E)
		(cond
			((null? ops)
				(car E)
				)
			((and (contains E (car ops)) (eq? (car ops) '^))
				(iter ops (doOne E (indexOf (car ops) E)))
				)
			((contains E (car ops))
				(iter ops (doOne E (lastIndexOf (car ops) E)))
				)
			(else
				(iter (cdr ops) E)
				)
			)
		)
	(iter operators expr)
	)

;   /$$$$$$ 
;  /$$__  $$
; | $$  \ $$
; |  $$$$$$/
;  >$$__  $$
; | $$  \ $$
; |  $$$$$$/
;  \______/ 

(define (cxr symbol)
	(define sym (string symbol))
	(define (cxrIter function remainingSymbol)
		(cond
			((null? remainingSymbol)
				function
				)
			((equal? (car (string remainingSymbol)) "d") 
				(cdr (cxrIter function (cdr remainingSymbol)))
				)
			((equal? (car (string remainingSymbol)) "a")
				(car (cxrIter function (cdr remainingSymbol)))
				)
			(else
				(print "Invalid series.")
				)
			)
		)
	(lambda (x) (cxrIter x sym))
	)

;   /$$$$$$ 
;  /$$__  $$
; | $$  \ $$
; |  $$$$$$$
;  \____  $$
;  /$$  \ $$
; |  $$$$$$/
;  \______/ 

(define oldMinus -)
(define oldAscii ascii)
(define ascii (lambda (x) (- (oldAscii x) 96)))

; Given a word, returns the sum of the one-based alphabetic indexes of its letters.
(define (word2int w)
	(define (converterator restOfWord sum)
		(cond
			((null? restOfWord)
				sum
				)
			(else
				(converterator (cdr restOfWord) (+ sum (ascii (car restOfWord))))
				)
			)
		)
	(converterator w 0)
	)

; generates a list of word pairs of the form (wordString . wordValue)
; from the words in the specified file
(define words ((lambda () 
	; (define p (open "words10000" 'read))
	(define p (open "words10000" 'read))
    (define oldInput (setPort p))

	(define (listIter wordList word)
		(cond
			((eof?)
				(cons (cons word (word2int word)) wordList)
				)
			(else
				(listIter (cons (cons word (word2int word)) wordList) (readLine))
				)
			)
		)
	(define l (listIter () (readLine)))

	(setPort oldInput)
	(close p)
	l
	)))

(define (- a b)
	(cond
		((and (eq? (type a) 'STRING) (eq? (type b) 'STRING))
			(diff a b)
			)
		((eq? (type a) 'STRING) 
			(oldMinus (word2int a) b)
			)
		((eq? (type b) 'STRING)
			(oldMinus a (word2int b))
			)
		(else
			(oldMinus a b)
			)
		)
	)

; given a (word . value) pair, returns word
(define (wordStr pair)
	(car pair)
	)

; given a (word . value) pair, returns value
(define (wordVal pair)
	(cdr pair)
	)

; generates the list of words with the given value
(define (wordsWithValue value)
	(define (listIter wordList allWords)
		(cond
			((null? allWords) wordList)
			((= (wordVal (car allWords)) value)
				(listIter (cons (wordStr (car allWords)) wordList) (cdr allWords))
				)
			(else
				(listIter wordList (cdr allWords))
				)
			)
		)
	(listIter () words)
	)

; returns a random word from the set of words with the specified value
(define (getMatch value)
	(define wordList (wordsWithValue value))
	(define len (length wordList))
	(cond
		((= len 0) "the difference is unknown to us")
		(else
			(getElement wordList (randomRange 0 len))
			)
		)
	)

; Given two strings, returns the difference in their word values (the 
; sum of their letters' one-based alphabetic indexes.
(define (diff word1 word2)
	(define value (abs (- (word2int word1) (word2int word2))))
	(cond
		((= value 0) "there is no difference")
		(else
			(getMatch value)
			)
		)
	)

;    /$$    /$$$$$$ 
;  /$$$$   /$$$_  $$
; |_  $$  | $$$$\ $$
;   | $$  | $$ $$ $$
;   | $$  | $$\ $$$$
;   | $$  | $$ \ $$$
;  /$$$$$$|  $$$$$$/
; |______/ \______/ 

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
	(define n (/ numer (gcd numer denom))
		)
	(define d (/ denom (gcd numer denom))
		)
	(define (add other)
		(Rational (oldplus (* n (other'd)) (* (other'n) d)) (* d (other'd)))
		)
	(define (promote)
		(Real (* (/ (real n) d) 1000000) 6)
		)
	(define (demote)
		(Integer (int (/ (real n) d)))
		)
	(define (rank)
		1 
		)
	(define (toString)
		(string+ (string (int n)) "/" (string (int d)))
		)
	(define (value)
		(/ (real n) d)
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
		(Rational (int integerVersion) (int (^ 10.0 decIndex)))
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
		(define rVal (sqrt (oldplus (^ ((realPart'value)) 2) (^ ((imaginaryPart'value)) 2))))
		(Real (int (* rVal 1000000)) 6)
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
	(if (not (object? (car @)))
		(apply oldplus @) ; if they're just regular ints or reals or whatever
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
					((> (((car @)'rank)) (((cadr @)'rank))) (apply + (cons (car @) (cons (((cadr @)'promote)) (cddr @)))))
					((< (((car @)'rank)) (((cadr @)'rank))) (apply + (cons (((car @)'promote)) (cons (cadr @) (cddr @)))))
					(else
						(apply + (cons ((((car @)'add) (cadr @))) (cddr @)))
						)
					)
				)
			)
		)
	)

;  .----------------.  .----------------.  .-----------------.
; | .--------------. || .--------------. || .--------------. |
; | |  _______     | || | _____  _____ | || | ____  _____  | |
; | | |_   __ \    | || ||_   _||_   _|| || ||_   \|_   _| | |
; | |   | |__) |   | || |  | |    | |  | || |  |   \ | |   | |
; | |   |  __ /    | || |  | '    ' |  | || |  | |\ \| |   | |
; | |  _| |  \ \_  | || |   \ `--' /   | || | _| |_\   |_  | |
; | | |____| |___| | || |    `.__.'    | || ||_____|\____| | |
; | |              | || |              | || |              | |
; | '--------------' || '--------------' || '--------------' |
;  '----------------'  '----------------'  '----------------' 

(define (run1)
	(println "(check-and-go (/ x 0) (lambda (error) (ppTable error))) should be: undefinedVariable")

	(println "\nThe actual call:")
	(inspect (check-and-go (/ x 0) (lambda (error) (get 'code error))))
	)

(define (run2)
	(inspect (define (f a b c) (oldMinus a b c)))
	(inspect ((((curry f) 1) 2) 3))
	(println "    [it should be -4]")

	(inspect (define (g w x y z) (* x (/ y (+ w z)))))
	(inspect (((((curry g) 5.0) 2.0) 3.0) 4.0))
	(println "    [it should be 0.666667]")
	)

(define (run3)

	(inspect (translate zero))
	(inspect (translate (increment one)))
	(inspect (translate (add three five)))

	(println "
	This problem deals with Church numerals.
	Any Church numeral 'n' is represented by
	n calls to some function. The example 
	given shows one repetition of the function
	on zero, which is equivalent to one.")
	)

(define (run4)
	(inspect (nodeCount (node 5 (node 6 'None 'None) (node 8))))
	(println "		It should be 3.")

	(inspect (nodeCount (node 1 (node 6 (node 6 'None (node 3 10 1)) 'None) (node 3 'None (node 4)))))
	(println "		It should be 8.")
	)

(define (run5)
	(inspect (matrix-*-matrix '((1 2 6 4) (3 4 -3 0)) '((1 0) (0 1) (5 5))))
	(println "		It should be ((1 2 6 4) (3 4 -3 0) (20 30 15 20)).")

	(inspect (matrix-*-vector '((1 2 3) (4 5 6) (7 8 9)) '(1 2 3)))
	(println "		It should be (30 36 42).")
	)

(define (run6)
	(inspect (tuple 3 3))
	(println "It should be: ((0 0 0) (0 0 1) (0 1 1) (1 1 1) (0 0 2) (0 1 2) (1 1 2) (0 2 2) (1 2 2) (2 2 2) (0 0 3) (0 1 3) (1 1 3) (0 2 3) (1 2 3) (2 2 3) (0 3 3) (1 3 3) (2 3 3) (3 3 3))")
	(inspect (tuple 2 4))
	(println "It should be: ((0 0) (0 1) (1 1) (0 2) (1 2) (2 2) (0 3) (1 3) (2 3) (3 3) (0 4) (1 4) (2 4) (3 4) (4 4))")
	)

(define (run7)
	(inspect (infix->prefix '(2 + 3 ^ 4 * 4 - 7)))
	(println "Is should be: (+ 2 (- (* (^ 3 4) 4) 7))")
	(inspect (infix->prefix '(1 + 2 + 3 ^ 4 ^ 5)))
	(println "Is should be: (+ 1 (+ 2 (^ (^ 3 4) 5)))")
	(inspect (infix->prefix '(5)))
	(println "Is should be: 5")
	)

(define (run8)
	(inspect ((cxr 'addddd) '("Hi" "!" "What" "is" "your" "name" "?")))
	(println "		It should be name.")
	(inspect ((cxr 'aaddd) '(car cdr (cadr cddr) (caddr cdddr))))
	(println "		It should be caddr.")
	)

(define (run9)
	(println "volkswagen - mitsubishi = there is no difference")
	(println "EXPLAIN HERE")
	(println "lock - writes = cdrom")
	(println "EXPLAIN HERE")
	(println "activist - impose = tea")
	(println "EXPLAIN HERE")


	)

(define (run10)
	(inspect (define five (Integer 5)))
	(inspect (define two (Integer 2)))
	(inspect (define point333 (Real 333 3)))
	(inspect (define twopoint333 (Real 2333 3)))
	(inspect (define twothirds (Rational 2 3)))
	(inspect (define thirteen221sts (Rational 13 221)))
	(inspect (define one+2i (Complex (Real 1 0) (Real 2 0))))
	(inspect (define point3+-.2i (Complex (Real 3 1) (Real -2 1))))
	(inspect (define a (Complex (Real -78 2) (Real 1909 3))))
	(inspect (define b (Integer 3)))

	(inspect ((((five'promote))'value)))
	(inspect (((((five'add) two))'value)))

	(inspect ((twothirds'toString)))
	(inspect ((((twothirds'demote))'value)))

	(inspect (((((twothirds'add) thirteen221sts))'value)))

	(inspect ((point333'toString)))
	(inspect ((point333'rank)))
	(inspect ((point333'promote)))
	(inspect ((((point333'promote))'value)))
	(inspect (((((point333'add) twopoint333))'value)))

	(inspect ((point3+-.2i'value)))
	(inspect ((point3+-.2i'toString)))
	(inspect ((((point3+-.2i'demote))'value)))
	(inspect ((((point3+-.2i'promote))'value)))

	(inspect (((((one+2i'add) point3+-.2i))'toString)))

	(inspect (+ five point3+-.2i))

	(inspect ((a'toString)))

	(inspect ((((a'demote))'value)))
	(inspect ((((((a'demote))'demote))'toString)))
	(inspect ((((((((a'demote))'demote))'demote))'value)))
	(inspect ((((((((((((((b'promote))'promote))'promote))'demote))'demote))'demote))'value)))

	(inspect (((+ point3+-.2i five)'demote)))
	(inspect (((((+ point3+-.2i five)'demote))'demote)))
	(inspect (((((((+ point3+-.2i five)'demote))'demote))'demote)))
	(inspect (((+ five point3+-.2i)'toString)))
	(inspect (((+ five point3+-.2i)'value)))

	(inspect (((+ a b twothirds twopoint333)'value)))
	)