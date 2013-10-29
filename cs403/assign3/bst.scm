(define (bst)
	(define count 0)
	(define base (cons nil (list nil nil)))
	(define (size+) (set! count (+ count 1)))
	(define (size-) (set! count (- count 1)))
	(define (leftChild node)
		(cadr node)
		)
	(define (rightChild node)
		(cadr (cdr node))
		)
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
		(println "Current tree: " base)
		(println "Attempting to insert " x "...")
		(define (insertWalker node)
			(println "Node: " node)
			(cond
				((< x (car node))
					(println x " was smaller than " (car node) ". Checking left child...")
					(cond
						((null? (leftChild node))
							(println "left child was null. inserting.")
							(set-car! (cdr node) (cons x (list nil nil)))
							(size+)
							)
						(else
							(println "left child was not null. recurring...")
							(insertWalker (leftChild node))
							)
						)
					)
				(else ; (> x (car node))
					(println x " was bigger than " (car node) ". Checking right child...")
					(cond
						((null? (rightChild node))
							(println "right child was null. inserting.")
							(set-car! (cdr (cdr node)) (cons x (list nil nil)))
							(size+)
							)
						(else
							(println "right child was not null. recurring...")
							(insertWalker (rightChild node))
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
				(insertWalker base)
				)
			)
		)
	(define (delete)  ; TODO

		)
	(define (traverse)  ; TODO
		(define (preorder node)
			(cond
				((null? node) nil)
				(else
					(print (car node))
					(if (null? (cadr node))
						nil
						(preorder (cadr node))
						)
					(if (null? (cadr (cadr node)))
						nil
						(preorder (cadr (cadr node)))
						)
					)
				)
			)
		(preorder base)
		)
	(define (printTree)
		(println base)
		)
	this
	)

(define tree (bst))
; ((tree 'size))
((tree 'insert) 5 0 10 3 7)
; ((tree 'traverse))
; ((tree 'insert) 0)
; ((tree 'traverse))
; ((tree 'insert) 10)
; ((tree 'traverse))
; ((tree 'insert) 3)
; ((tree 'traverse))
; ((tree 'insert) 7)
; ((tree 'traverse))
((tree 'printTree))

; (define l '(1 (2 nil) 4))
; (inspect (cadr (cadr l)))
; (set-car! (cdr (cadr l)) 5)
; (inspect (cadr (cadr l)))
; (inspect l)
; (set-car! (cdr (cadr l)) (cons 9 (cons 99 999)))
; (inspect l)

; (define l2 '(5 (nil nil)))
; (define l3 '(5 ((nil (nil nil)) nil nil nil nil nil (nil (nil nil)))))
; (inspect l3)