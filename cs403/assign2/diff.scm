(include "random.lib")
(randomSeed (int (time)))
(define WORD_COUNT (- 210680 1))

(define (abs x) ;;; DONE ;;;
	(if (< x 0)
		(- x)
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
	(define p (open "words" 'read))   ; p points to a port
    (define oldInput (setPort p))

    (define (readIter word i)
    	(cond
    		((= i k) word)
    		(else
    			(readIter (readLine) (+ i 1))
    			)
    		)
    	)
    (define w (readIter (readLine) 0))

	(setPort oldInput)
	(close p)
	w
	)

; (inspect (kthWord (randomRange 0 WORD_COUNT)))

(define (randomWord)
	(kthWord (randomRange 0 WORD_COUNT))
	)

; (inspect (randomWord))

(inspect (diff (randomWord) (randomWord)))

;;; TODO ;;;
(define (getMatch value)
	(define p (open "words" 'read))   ; p points to a port
    (define oldInput (setPort p))
	
    ; find the word

	(setPort oldInput)
	(close p)

	; return the word
	)