(include "random.lib")

(randomSeed (int (time))) ; TODO: CHANGE TO A UNIQUE SEED RATHER THAN (TIME)

(define oldMinus -)
(define oldAscii ascii)
(define ascii (lambda (x) (- (oldAscii x) 96)))

; Given a word, returns the sum of the one-based alphabetic indexes of its letters.
(define (word2int w)
	(define (converterator restOfWord sum)
		(cond
			((null? restOfWord) sum)
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
	(define p (open "words10000" 'read))
    (define oldInput (setPort p))

	(define (listIter wordList word)
		(cond
			((eof?) wordList)
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

(inspect words)

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
			((= (wordVal (car allWords)) value) (listIter (cons (wordStr (car allWords)) wordList) (cdr allWords)))
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
			(getElement wordList (randomRange 0 len))) ; MAYBE MAKE THIS (- len 1) !!!!!!!!!!!!!!!!!!!!!!!
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

; (inspect (word2int (diff "love" "hate")))

(define (kthWord items k) ;;; DONE ;;;
	(define (readIter collection i)
    	(cond
    		((= i (- k 1)) (car collection))
    		(else
    			(readIter (cdr collection) (+ i 1))
    			)
    		)
    	)
    (readIter items 0)
	)

; (inspect (kthWord words 5))

(define (randomWord)
	(kthWord (randomRange 0 (length words)))
	)






(define (exampleSearch n) ;;; DONE ;;;
	(define p (open "examples2" 'write)) ; p points to a port (in this case the file pointer)
    (define oldInput (setPort p))

    (define (iter i)
    	(cond
    		((= i n) nil)
    		(else
    			(define r1 (randomWord))
    			(define r2 (randomWord))
    			(println r1 " - " r2 " = " (diff r1 r2))
    			(iter (+ i 1))
    			)
    		)
    	)
    	(iter 0) ; save w to return after closing file

	(setPort oldInput)
	(close p)
	)

; (exampleSearch 20000)