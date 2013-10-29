(define (bst)
	(define count 0)
	(define base (cons nil (cons nil nil)))
	(define (size+) (set! count (+ count 1)))
	(define (size-) (set! count (- count 1)))
	(define (size)  ; DONE
		count
		)
	(define (root)  ; DONE
		(car base)
		)
	(define (find val)  ; TODO

		)
	(define (insert @)  ; TODO
		(map insert-helper @)
		)
	(define (insert-helper x)
		(newline)
		(println "Attempting to insert " x "...")
		(define (insertIter node)
			(println "Tree: " base)
			(inspect node)
			(cond
				((< x (car node))
					(println x " was smaller than " (car node) ". Checking cadr")
					(cond
						((null? (cadr node))
							(println "cadr was null. inserting.")
							(set-car! (cdr node) (cons x (cons nil nil)))
							(size+)
							)
						(else
							(insertIter (cadr node))
							)
						)
					)
				(else ; (> x (car node))
					(println x " was bigger than " (car node) ". Checking cadr of cadr")
					(cond
						((null? (cadr (cadr node)))
							(println "cadr of cadr was null. inserting.")
							(set-car! (cdr (cadr node)) (cons x (cons nil nil)))
							(size+)
							)
						(else
							(insertIter (cadr (cadr node)))
							)
						)
					)
				)
			)
		(cond
			((null? (root))
				(println "root was null. inserting.")
				(set-car! base x)
				(size+)
				)
			(else
				(insertIter base)
				)
			)
		)
	(define (delete)  ; TODO

		)
	(define (traverse)  ; TODO

		)
	(define (printTree)
		(println base)
		)
	this
	)

(define tree (bst))
(inspect ((tree 'insert) 5 3 7 4 6))
; (inspect ((tree 'size)))
; (inspect ((tree 'insert) 0))
; (inspect ((tree 'size)))
; (inspect ((tree 'insert) 10))
; (inspect ((tree 'size)))
; (inspect ((tree 'insert) 3))
; (inspect ((tree 'size)))
; (inspect ((tree 'insert) 7))
; (inspect ((tree 'size)))

; (define l '(1 (2 nil) 4))
; (inspect (cadr (cadr l)))
; (set-car! (cdr (cadr l)) 5)
; (inspect (cadr (cadr l)))
; (inspect l)