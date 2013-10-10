(include "ci.lib")

(define (node value @)
		(cond
			((null? @)
				(list value))
			(else
				(cons value (cons (car @) (cadr @))))
			)
		)

(define (nodeCount tree)
	(length
		(keep 
			(lambda (x) (not (eq? x 'None))) 
			(flatten tree))
		)
	)


(define tree3 (node 5 (node 6 'None 'None) (node 8)))

(inspect (nodeCount tree3))