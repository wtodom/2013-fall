(include "random.lib")
(randomSeed (int (time))) ; TODO: CHANGE TO A UNIQUE SEED RATHER THAN (TIME)
(define WORD_COUNT 210680) ; offset by 1 to allow it's use as an index

(define oldMinus -)

(define (abs x) ;;; DONE ;;;
	(if (< x 0)
		(- 0 x)
	;else
		x
		)
	)

(define (index element collection) ;;; DONE ;;;
	(define (indexIter count tail)
		(cond
			((null? tail) -1)
			((= (string-compare (car tail) element) 0) count)
			(else
				(indexIter (+ count 1) (cdr tail))
				)
			)
		)
	(indexIter 0 collection)
	)

; (inspect (index 5 (list 1 2 3 4 5 6 7)))

(define (ascii letter) ;;; DONE ;;;
	(define letters "abcdefghijklmnopqrstuvwxyz")
	(+ (index letter letters) 1)
	)

; (inspect (ascii "b"))

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

; (inspect (word2int "ab"))

(define (diff word1 word2) ;;; DONE ;;;
	(define value (abs (- (word2int word1) (word2int word2))))
	(cond
		((= value 0) "there is no difference")
		(getMatch value)
		)
	)

; (inspect (diff "love" "hate"))

(define (kthWord k) ;;; DONE ;;;
	(define p (open "words" 'read)) ; p points to a port (in this case the file pointer)
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

; (inspect (kthWord (randomRange 0 WORD_COUNT)))

(define (randomWord)
	(kthWord (randomRange 0 WORD_COUNT))
	)

; (inspect (randomWord))

; (inspect (diff (randomWord) (randomWord)))

(define (firstMatch value) ;;; DONE ;;;
	(define p (open "words" 'read)) ; p points to a port (in this case the file pointer)
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

; (inspect (firstMatch 160))

(define (wordsWithValue value) ;;; WORKS, BUT TAKES FOREVER
	(define p (open "words" 'read))
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

; (inspect (wordsWithValue 3))


(define (getMatch value)
	(define wordList (wordsWithValue value))
	(define len (length wordList))
	(getElement wordList (randomRange 0 len))
	)

; (inspect (getMatch 22))

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

; (inspect (- 3 1))
; (inspect (- "aaa" "a"))
; (inspect (- 3 "a"))
; (inspect (- "aaa" 1))
; (inspect (- "aaa" 1.3))
; (inspect (- 3.5 "aa"))