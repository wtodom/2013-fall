(define (flatten l)
	(cond
		((null? l) ())
		((pair? l) (append (flatten (car l)) (flatten (cdr l))))
		(else (list l))
		)
	)

; (inspect (atom? (list 3))) ; #f
; (inspect (atom? 3)) ; #t
; (inspect (atom? ())) ; #t

; (inspect (pair? ())) ; #f
; (inspect (pair? (list 3))) ; #t
; (inspect (pair? (list 3 3))) ; #t
; (inspect (pair? (list 3 (list 4) 3))) ; #t

(inspect (flatten '(d (3 (f (h ((d) s) (h ((fk) we)))) (3892 fh)))))