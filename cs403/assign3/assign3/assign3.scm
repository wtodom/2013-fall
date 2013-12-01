(include "stream.lib")
(include "random.lib")

(define (author)
    (println "AUTHOR: Weston Odom wtodom@crimson.ua.edu")
    )

;    /$$
;  /$$$$
; |_  $$
;   | $$
;   | $$
;   | $$
;  /$$$$$$
; |______/

(define (scoping symbol object)
	(cond
		((local? symbol object) 'bound)
		(else
			(define (scope_iter sym env)
				(cond
					((null? env) 'undefined)
					((local? sym env) 'free)
					(else
						(scope_iter sym (env'__context))
						)
					)
				)
			(scope_iter symbol (object'__context))
			)
		)
	)

;   /$$$$$$
;  /$$__  $$
; |__/  \ $$
;   /$$$$$$/
;  /$$____/
; | $$
; | $$$$$$$$
; |________/



;   /$$$$$$
;  /$$__  $$
; |__/  \ $$
;    /$$$$$/
;   |___  $$
;  /$$  \ $$
; |  $$$$$$/
;  \______/

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
	(define (size)
		count
		)
	(define (root)
		(car base)
		)
	(define (find val)
		(define (find-helper node)
			(cond
				((null? node) #f)
				((= val (car node))
					#t
					)
				((< val (car node))
					(find-helper (leftChild node))
					)
				((> val (car node))
					(find-helper (rightChild node))
					)
				)
			)
		(find-helper base)
		)
	(define (insert @)
		(for-each insert-helper @)
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
							(set-car! (cddr node) (cons x (list nil nil)))
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
	(define (predecessor node)
		(define (p-helper node)
			(cond
				((null? (rightChild node))
					node
					)
				(else
					(p-helper (rightChild node))
					)
				)
			)
		(p-helper (leftChild node))
		)
	(define (successor node)
		(define (p-helper node)
			(cond
				((null? (leftChild node))
					node
					)
				(else
					(p-helper (leftChild node))
					)
				)
			)
		(p-helper (rightChild node))
		)
	(define (delete val)
		(define (parent node)
			(define (tracer curr)
				(cond
					((or (eq? (leftChild curr) node) (eq? (rightChild curr) node))
						curr
						)
					(else
						(if (> (car curr) (car node))
							(tracer (leftChild curr))
						; else
							(tracer (rightChild curr))
							)
						)
					)
				)
			(tracer base)
			)
		(define (delete-helper node)
			(if debug (inspect (car node)))
			(if debug (inspect val))
			(cond
				((null? node) nil)
				((< val (car node))
					(if debug (println val " is less than " (car node) ". recurring left."))
					(delete-helper (leftChild node))
					)
				((> val (car node))
					(if debug (println val " is more than " (car node) ". recurring right."))
					(delete-helper (rightChild node))
					)
				(else
					(if debug (println val " is " (car node) ". beginning delete."))
					(cond
						((and (null? (rightChild node)) (null? (leftChild node)))
						(if debug (println "Both children are null. Deleting..."))
							(if (eq? (rightChild (parent node)) node)
								(set-car! (cddr (parent node)) nil)
								(set-car! (cdr (parent node)) nil)
								)
							(size-)
							)
						((null? (rightChild node))
							(if debug (println "Right child is null.  Replacing node with " (leftChild node)))
							(set-car! node (car (leftChild node)))
							(set-cdr! node (list nil nil))
							(size-)
							)
						((null? (leftChild node))
							(if debug (println "Left child is null.  Replacing node with "  (rightChild node)))
							(set-car! node (car (rightChild node)))
							(set-cdr! node (list nil nil))
							(size-)
							)
						(else
							; Call the node to be deleted N.
							; Do not delete N.
							; Instead, choose either its in-order successor node or its in-order predecessor node, R.
							; Replace the value of N with the value of R, then delete R.
							(if debug (println "Complicated one. This probably fails..."))
							(define tmp (car (predecessor node)))
							(delete (car (predecessor node)))
							(set-car! node tmp)
							)
						)
					)
				)
			)
		(delete-helper base)
		)
	(define (traverse)
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
		(newline)
		)
	(define (printTree)
		(println base)
		)
	this
	)

;  /$$   /$$
; | $$  | $$
; | $$  | $$
; | $$$$$$$$
; |_____  $$
;       | $$
;       | $$
;       |__/



;  /$$$$$$$
; | $$____/
; | $$
; | $$$$$$$
; |_____  $$
;  /$$  \ $$
; |  $$$$$$/
;  \______/



;   /$$$$$$
;  /$$__  $$
; | $$  \__/
; | $$$$$$$
; | $$__  $$
; | $$  \ $$
; |  $$$$$$/
;  \______/

(define pf-3-11-17-full
    (cons-stream
        1
        (merge
            (scale-stream
                pf-3-11-17-full
                3
                )
            (merge
                (scale-stream
                    pf-3-11-17-full
                    11
                    )
                (scale-stream
                    pf-3-11-17-full
                    17
                    )
                )
            )
        )
    )

(define pf-3-11-17 (stream-cdr pf-3-11-17-full))

;  /$$$$$$$$
; |_____ $$/
;      /$$/
;     /$$/
;    /$$/
;   /$$/
;  /$$/
; |__/



;   /$$$$$$
;  /$$__  $$
; | $$  \ $$
; |  $$$$$$/
;  >$$__  $$
; | $$  \ $$
; |  $$$$$$/
;  \______/

(define ones (cons-stream 1 ones))

(define fours (cons-stream 4 fours))

(define powers-of-four
	(cons-stream 1 (stream-mult fours powers-of-four)))

(define numers ones)

(define denoms (stream-cdr powers-of-four))

(define ari (stream-div-real numers denoms))

(define ari-ps (partial-sum ari))

(define ari-acc
	(cons-stream
		(stream-car ari-ps)
		(accelerate ari-ps)
		)
	)

(define ari-super
	(stream-map
		stream-car
		(tableau
			ari-acc
			accelerate
			)
		)
	)


;   /$$$$$$
;  /$$__  $$
; | $$  \ $$
; |  $$$$$$$
;  \____  $$
;  /$$  \ $$
; |  $$$$$$/
;  \______/



;    /$$    /$$$$$$
;  /$$$$   /$$$_  $$
; |_  $$  | $$$$\ $$
;   | $$  | $$ $$ $$
;   | $$  | $$\ $$$$
;   | $$  | $$ \ $$$
;  /$$$$$$|  $$$$$$/
; |______/ \______/

(define (rand-update x)
	(% (/ (* x x) 1000) 1000000)
	)

(define (rgen command-stream)
	(define random-number
		(cons-stream
			(scadr command-stream)
			(stream-map
				(lambda (command)
					(cond
						((null? command)
							the-empty-stream
							)
						((eq? command 'generate)
							(rand-update (stream-car random-number))
							)
						(else ; if command == reset
							(scadr command)
							)
						)
					)
				(stream-cdr (stream-cdr command-stream))
				)
			)
		)
	random-number
	)

;  .----------------.  .----------------.  .-----------------.
; | .--------------. || .--------------. || .--------------. |
; | |  _______     | || | _____  _____ | || | ____  _____  | |
; | | |_   __ \    | || ||_   _||_   _|| || ||_   \|_   _| | |
; | |   | |__) |   | || |  | |    | |  | || |  |   \ | |   | |
; | |   |  __ /    | || |  | '    ' |  | || |  | |\ \| |   | |
; | |  _| |  \ \_  | || |   \ `--' /   | || | _| |_\   |_  | |
; | | |____| |___| | || |    `.__.'    | || ||_____|\____| | |
; | |              | || |              | || |              | |
; | '--------------' || '--------------' || '--------------' |
;  '----------------'  '----------------'  '----------------'

(define (run1)
	(println "WRITE YOUR DAMN TESTS FOR #1 WESTON!")
	)

; (define (run2)

; 	)

(define (run3)
	(println "WRITE YOUR DAMN TESTS FOR #3 WESTON!")
	)

; (define (run4)

; 	)

; (define (run5)

; 	)

(define (run6)
	(println "WRITE YOUR DAMN TESTS FOR #6 WESTON!")
	)

; (define (run7)

; 	)

(define (run8)
	(println "WRITE YOUR DAMN TESTS FOR #8 WESTON!")
	)

; (define (run9)

; 	)

(define (run10)
	(println "WRITE YOUR DAMN TESTS FOR #10 WESTON!")
	)

; (run1)
; (run2)
; (run3)
; (run4)
; (run5)
; (run6)
; (run7)
; (run8)
; (run9)
; (run10)
(display "\n\nassignment 3 loaded!\n\n")