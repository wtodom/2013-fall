(define (itr l)
	(cond
		((null? l) 0)
		((pair? l) (+ 1 (itr (car l)) (itr (cdr l))))
		(else 0)
		)
	)

(inspect (itr (list 1 (list 2 3))))

; (define (list? l)
; 	(inspect l)
; 	(cond
; 		((not (pair? l)) #f)
; 		((null? (cdr l)) #t)
; 		(else
; 			(list? (cdr l))
; 			)
; 		)
; 	)

; (inspect (list? (list 1 2)))