(include "random.lib")
(randomSeed (int (time)))
(define WORD_COUNT (- 210680 1)) ; offset by 1 to allow it's use as an index

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
	(define p (open "words" 'read))   ; p points to a port
    (define oldInput (setPort p))
	
	(define value (abs (- (word2int word1) (word2int word2))))

	(setPort oldInput)
	(close p)

	value
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

;;; TODO ;;;
(define (getMatch value)
	(define p (open "words" 'read))   ; p points to a port
    (define oldInput (setPort p))
	
    ; find the word here

	(setPort oldInput)
	(close p)

	; return the word here
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


(inspect (- 3 1))
(inspect (- "aaa" "a"))
(inspect (- 3 "a"))
(inspect (- "aaa" 1))
(inspect (- "aaa" 1.3))
(inspect (- 3.5 "aa"))