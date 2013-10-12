(include "pretty.lib")

(define (cxr symbol)
	(define sym (string symbol))
	(define (cxrIter # $function remainingSymbol)
		; (pretty $function)
		; (inspect remainingSymbol)
		(cond
			((null? remainingSymbol)
				(eval $function #))
			((equal? (car (string remainingSymbol)) "d")
				(cxrIter (lambda () $(cdr $function)) (cdr remainingSymbol)))
			((equal? (car (string remainingSymbol)) "a")
				(cxrIter (lambda () $(car $function)) (cdr remainingSymbol)))
			(else
				(print "Invalid series."))
			)
		)
	(cxrIter (lambda (x) (x)) sym)
	)

(inspect ((cxr 'add) '(1 2 3 4 5 6)))
(println "    [it should be 3]")

(pp (cxr 'ddda))
(pp (get '__context (cxr 'ddda)))
; (pp (get '__constructor (get '__context (cxr 'ddda))))
; (pp (get '__context (get '__constructor (get '__context (cxr 'ddda)))))

;{
	use this format for the function parameter:
	
	(define (cons-stream # a $b)
    	(cons a (lambda () (eval $b #)))
    	)
;}