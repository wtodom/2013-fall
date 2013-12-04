(include "pretty.lib")

(define (body func)
	(get 'code func)
	)

(define (denv func)
	(get '__context func)
	)

(define (square x) (multiply x x))
(define (multiply a b) (* a b))

(define (test)
	(define z 3)
	(inspect (defined? 'z this))
	(inspect (defined? 'das this))
	(inspect (body multiply))
	)



(define (compile func)

	)



; (inspect (compile square))
(pretty square)
(pretty multiply)

; (println "[should be: (define (square x) (<function multiply(a,b)> x x)) ]")
; (println "[should be: (define (multiply a b) (<built-in *(@)> a b)) ]")