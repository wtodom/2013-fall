(define debug #f)
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
	(define (insert @)  ; DONE
		(map insert-helper @)
		)
	(define (insert-helper x)
		(if debug (newline))
		(if debug (println "Current tree: " base))
		(if debug (println "Attempting to insert " x "..."))
		(define (insertWalker node)
			(if debug (println "Node: " node))
			(cond
				((< x (car node))
					(if debug (println x " was smaller than " (car node) ". Checking left child..."))
					(cond
						((null? (leftChild node))
							(if debug (println "left child was null. inserting."))
							(set-car! (cdr node) (cons x (list nil nil)))
							(size+)
							)
						(else
							(if debug (println "left child was not null. recurring..."))
							(insertWalker (leftChild node))
							)
						)
					)
				(else ; (> x (car node))
					(if debug (println x " was bigger than " (car node) ". Checking right child..."))
					(cond
						((null? (rightChild node))
							(if debug (println "right child was null. inserting."))
							(set-car! (cdr (cdr node)) (cons x (list nil nil)))
							(size+)
							)
						(else
							(if debug (println "right child was not null. recurring..."))
							(insertWalker (rightChild node))
							)
						)
					)
				)
			)
		(cond
			((null? (root))
				(if debug (println "root was null. inserting."))
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
					(print (car node) " ")
					(preorder (leftChild node))
					(preorder (rightChild node))
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

; (define tree (bst))
; ; ((tree 'size))
; ((tree 'insert) 5 0 10 3 7)
; ; ((tree 'traverse))
; ; ((tree 'insert) 0)
; ; ((tree 'traverse))
; ; ((tree 'insert) 10)
; ; ((tree 'traverse))
; ; ((tree 'insert) 3)
; ; ((tree 'traverse))
; ; ((tree 'insert) 7)
; ((tree 'traverse))
; (newline)
; ((tree 'printTree))


(define t (bst))
((t 'insert) 3 4 5 1 0)
; ((t 'find) 5)   ; should return #t
; ((t 'find) 7)   ; should return #f
((t 'root))     ; should return 3
((t 'size))     ; should return 5
((t 'traverse)) ; should print 3 1 0 4 5

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