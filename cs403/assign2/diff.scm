(include "random.lib")
(randomSeed (int (time))) ; TODO: CHANGE TO A UNIQUE SEED RATHER THAN (TIME)
; (define wordDic (words))
; (define WORD_COUNT (length wordDic)) ; offset by 1 to allow it's use as an index
(define WORD_COUNT 8672) ; offset by 1 to allow it's use as an index
(define oldMinus -)

(define (abs x) ;;; DONE ;;;
	(if (< x 0)
		(- 0 x)
	;else
		x
		)
	)

; Given a word, returns the sum of the one-based alphabetic indexes of its letters.
(define (word2int word) ;;; DONE ;;;
	(define (converterator restOfWord sum)
		(cond
			((null? restOfWord) sum)
			(else
				(converterator (cdr restOfWord) (+ sum (ascii (car restOfWord))))
				)
			)
		)
	(converterator word 0)
	)

(define (kthWord k) ;;; DONE ;;;
	(define p (open "words10000" 'read)) ; p points to a port (in this case the file pointer)
    (define oldInput (setPort p))

    (define (readIter word i)
    	(cond
    		((= i k) word)
    		(else
    			(readIter (readLine) (+ i 1))
    			)
    		)
    	)
    (define w (readIter (readLine) 0)) ; save w to return after closing file

	(setPort oldInput)
	(close p)

	w
	)

(define (randomWord)
	(kthWord (randomRange 0 WORD_COUNT))
	)

(define (firstMatch value) ;;; DONE ;;;
	(define p (open "words10000" 'read)) ; p points to a port (in this case the file pointer)
    (define oldInput (setPort p))

    (define (readIter word)
    	(cond
    		((= value (word2int word)) word)
    		(else
    			(readIter (readLine))
    			)
    		)
    	)
    (define w (readIter (readLine))) ; save w to return after closing file

	(setPort oldInput)
	(close p)

	w
	)

(define (wordsWithValue value) ;;; WORKS, BUT TAKES FOREVER
	(define p (open "words10000" 'read))
    (define oldInput (setPort p))

	(define (listIter wordList word)
		(cond
			((eq? word 'EOF) wordList)
			((= (word2int word) value) (listIter (cons word wordList) (readLine)))
			(else
				(listIter wordList (readLine))
				)
			)
		)
	(define l (listIter () (readLine)))

	(setPort oldInput)
	(close p)
	l
	)

(define (getMatch value)
	(define wordList (wordsWithValue value))
	(define len (length wordList))
	(cond
		((= len 0) "the difference is unknown to us")
		(else
			(getElement wordList (randomRange 0 len)))
		)
	)

(define (- a b)
	(cond
		((and (eq? (type a) 'STRING) (eq? (type b) 'STRING)) (diff a b))
		((eq? (type a) 'STRING) (oldMinus (word2int a) b))
		((eq? (type b) 'STRING) (oldMinus a (word2int b)))
		(else
			(oldMinus a b)
			)
		)
	)

; Given two strings, returns the difference in their word values (the 
; sum of their letters' one-based alphabetic indexes.
(define (diff word1 word2) ;;; DONE ;;;
	(define value (abs (- (word2int word1) (word2int word2))))
	(cond
		((= value 0) "there is no difference")
		(else
			(getMatch value))
		)
	)

(inspect (diff "love" "hate"))

; (inspect (diff (randomWord) (randomWord)))

; (inspect (- 3 1))
; (inspect (- "aaa" "a"))
; (inspect (- 3 "a")))
; (inspect (- "aaa" 1))
; (inspect (- "aaa" 1.3))
; (inspect (- 3.5 "aa"))


;{ THINGS TO CHANGE/ADD
	Read entire file into a list at the beginning.
	When it's read, store the words as pairs like: (cons word (word2int word))
	Make a function that takes a function and a collection and filters
		items that don't match.
	Filter the list, shuffle it, take car.
;}


(define words ((lambda () 
	(define p (open "words10000" 'read))
    (define oldInput (setPort p))

	(define (listIter wordList word)
		(cond
			((eq? word 'EOF) wordList)
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

; (inspect words)



; (define l (list (cons "q" 1) (cons "w" 2) (cons "e" 3) (cons "r" 4)))
; (inspect l)
; (inspect (cdr (car (cdr (cdr l)))))

;{
	use this format for the function parameter:
	
	(define (cons-stream # a $b)
    	(cons a (lambda () (eval $b #)))
    	)
;}
