(include "ci.lib")

(define operators '(^ / * - +))

;;; Maybe impossible - not functional style ;;;
; (define (infix->prefix expr)
; 	(define (ipIter nodeStack operatorStack expression)
; 		(define token (car expression))
; 		(cond
; 			((contains? operators token)
; 				(cond
; 					((needToPop? (car operatorStack) token) )
; 					(else (ipIter nodeStack (cons token operatorStack) (cdr expression)))
; 					)
; 				)
; 			)
; 		)
; 	(ipIter () () expr)
; 	)

(define (op expression)
	(cadr expression)
	)

(define (nextOp expression)
	(cadddr expression)
	)

(define (restOf expression)
	(cdddr expression)
	)

(define (infix->prefix expr)
	(define (sweepIter changed expression)
		(cond
			((not changed) expression)
			()d
			)
		)
	)

; (inspect (infix->prefix '(1 + 2 * 3 + 4 - 5 / 6)))

(define (needToPop oldOp newOp)
	(cond
		((= (string-compare oldOp newOp) 0) #f)
		)
	)

(define e '(2 + 3 * x ^ 5 + a))

(inspect (reverse e))

; (inspect (cadr e))
; (inspect (cadddr e))
; (inspect (cdddr e))