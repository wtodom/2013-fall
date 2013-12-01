(include "pretty.lib")

(define (body func)
	(get 'code func)
	)

(define (def_env func)
	(get '__context func)
	)

(define (compile func)

	)

(define (square x) (multiply x x))
(define (multiply a b) (* a b))

(define (test)
	(define z 3)
	(inspect (defined? 'z this))
	(inspect (defined? 'das this))
	(inspect (body multiply))
	)

(test)





; (inspect (compile square))
; (inspect (pretty square))
; (inspect (pretty multiply))

; (println "[should be: (define (square x) (<function multiply(a,b)> x x)) ]")
; (println "[should be: (define (multiply a b) (<built-in *(@)> a b)) ]")