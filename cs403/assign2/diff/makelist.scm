(include "ci.lib")

(define oldMinus -)
(define oldAscii ascii)
(define ascii (lambda (x) (- (oldAscii x) 96)))

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
(define write_port (open "words_and_values" 'write))
(define read_port (open "bigwords" 'read))

(define (writeword w)
	(setPort write_port)
	(println w " " (word2int w))
	(setPort read_port)
	)

; generates a list of word pairs of the form (wordString . wordValue)
; from the words in the specified file
(define words ((lambda () 
	; (define p (open "words10000" 'read))
	(setPort read_port)
	(define (listIter word)
		(cond
			((eof?) nil)
			(else
				(writeword word)
				(listIter (readLine))
				)
			)
		)
	(define l (listIter (readLine)))
	(close read_port)
	(close write_port)
	l
	)))