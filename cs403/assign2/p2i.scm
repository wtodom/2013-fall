(include "ci.lib")

(define operators '(^ / * - +))

(define (doOne expr opIndex)
	(define (iter i current)
		(cond
			((= i (- opIndex 1)) (append current (cons (list (getElement expr (+ i 1)) (getElement expr i) (getElement expr (+ i 2))) (listFromIndex (+ i 3) expr))))
			(else
				(iter (+ i 1) (append current (list (getElement expr i)))))
			)
		)
	(iter 0 ())
	)

(define (infix->prefix expr)
	(define (iter ops E)
		(cond
			((null? ops) (car E))
			((and (contains E (car ops)) (eq? (car ops) '^)) (iter ops (doOne E (indexOf (car ops) E))))
			((contains E (car ops)) (iter ops (doOne E (lastIndexOf (car ops) E))))
			(else
				(iter (cdr ops) E)
				)
			)
		)
	(iter operators expr)
	)

; (inspect (infix->prefix '(2 + 3 ^ 4 * 4 - 7)))
(inspect (infix->prefix '(1 + 2 + 3 ^ 4 ^ 5)))
; (inspect (doOne '(2 + 3 * 4 - 7) 5))

; (inspect (indexOf '2 '(1 2 3 2 3 4 2)))
; (inspect (lastIndexOf '2 '(1 2 3 2 3 4 2)))