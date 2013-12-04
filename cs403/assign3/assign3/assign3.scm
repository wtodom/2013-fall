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

(define (make-wire)
	(let ((signal-value 0) (action-procedures '()))
		(define (set-my-signal! new-value)
			(if (not (= signal-value new-value))
					(begin (set! signal-value new-value)
								 (call-each action-procedures))
					'done))
		(define (accept-action-procedure! proc)
			(set! action-procedures (cons proc action-procedures))
			(proc))
		(define (dispatch m)
			(cond ((eq? m 'get-signal) signal-value)
						((eq? m 'set-signal!) set-my-signal!)
						((eq? m 'add-action!) accept-action-procedure!)
						(else (error "Unknown operation -- WIRE" m))))
		dispatch))
(define (call-each procedures)
	(if (null? procedures)
			'done
			(begin
				((car procedures))
				(call-each (cdr procedures)))))
(define (get-signal wire)
	(wire 'get-signal))
(define (set-signal! wire new-value)
	((wire 'set-signal!) new-value))
(define (add-action! wire action-procedure)
	((wire 'add-action!) action-procedure))
(define (make-agenda) (list 0))
(define the-agenda (make-agenda))
(define (after-delay delay action)
	(add-to-agenda! (+ delay (current-time the-agenda))
									action
									the-agenda))
(define (propagate)
	(if (empty-agenda? the-agenda)
			'done
			(let ((first-item (first-agenda-item the-agenda)))
				(first-item)
				(remove-first-agenda-item! the-agenda)
				(propagate))))
(define (current-time agenda) (car agenda))
(define (set-current-time! agenda time)
	(set-car! agenda time))
(define (empty-agenda? agenda)
	(null? (segments agenda)))
(define (add-to-agenda! time action agenda)
	(define (belongs-before? segments)
		(or (null? segments)
				(< time (segment-time (car segments)))))
	(define (make-new-time-segment time action)
		(let ((q (make-queue)))
			(insert-queue! q action)
			(make-time-segment time q)))
	(define (add-to-segments! segments)
		(if (= (segment-time (car segments)) time)
				(insert-queue! (segment-queue (car segments))
											 action)
				(let ((rest (cdr segments)))
					(if (belongs-before? rest)
							(set-cdr!
							 segments
							 (cons (make-new-time-segment time action)
										 (cdr segments)))
							(add-to-segments! rest)))))
	(let ((segments (segments agenda)))
		(if (belongs-before? segments)
				(set-segments!
				 agenda
				 (cons (make-new-time-segment time action)
							 segments))
				(add-to-segments! segments))))
(define (make-time-segment time queue)
	(cons time queue))
(define (segment-time s) (car s))
(define (segment-queue s) (cdr s))
(define (make-agenda) (list 0))
(define (current-time agenda) (car agenda))
(define (set-current-time! agenda time)
	(set-car! agenda time))
(define (segments agenda) (cdr agenda))
(define (set-segments! agenda segments)
	(set-cdr! agenda segments))
(define (first-segment agenda) (car (segments agenda)))
(define (rest-segments agenda) (cdr (segments agenda)))
(define (empty-agenda? agenda)
	(null? (segments agenda)))
(define (add-to-agenda! time action agenda)
	(define (belongs-before? segments)
		(or (null? segments)
				(< time (segment-time (car segments)))))
	(define (make-new-time-segment time action)
		(let ((q (make-queue)))
			(insert-queue! q action)
			(make-time-segment time q)))
	(define (add-to-segments! segments)
		(if (= (segment-time (car segments)) time)
				(insert-queue! (segment-queue (car segments))
											 action)
				(let ((rest (cdr segments)))
					(if (belongs-before? rest)
							(set-cdr!
							 segments
							 (cons (make-new-time-segment time action)
										 (cdr segments)))
							(add-to-segments! rest)))))
	(let ((segments (segments agenda)))
		(if (belongs-before? segments)
				(set-segments!
				 agenda
				 (cons (make-new-time-segment time action)
							 segments))
				(add-to-segments! segments))))
(define (remove-first-agenda-item! agenda)
	(let ((q (segment-queue (first-segment agenda))))
		(delete-queue! q)
		(if (empty-queue? q)
				(set-segments! agenda (rest-segments agenda)))))
(define (first-agenda-item agenda)
	(if (empty-agenda? agenda)
			(error "Agenda is empty -- FIRST-AGENDA-ITEM")
			(let ((first-seg (first-segment agenda)))
				(set-current-time! agenda (segment-time first-seg))
				(front-queue (segment-queue first-seg)))))
(define (front-ptr queue) (car queue))
(define (rear-ptr queue) (cdr queue))
(define (set-front-ptr! queue item) (set-car! queue item))
(define (set-rear-ptr! queue item) (set-cdr! queue item))
(define (empty-queue? queue) (null? (front-ptr queue)))
(define (make-queue) (cons '() '()))
(define (front-queue queue)
	(if (empty-queue? queue)
			(error "FRONT called with an empty queue" queue)
			(car (front-ptr queue))))
(define (insert-queue! queue item)
	(let ((new-pair (cons item '())))
		(cond ((empty-queue? queue)
					 (set-front-ptr! queue new-pair)
					 (set-rear-ptr! queue new-pair)
					 queue)
					(else
					 (set-cdr! (rear-ptr queue) new-pair)
					 (set-rear-ptr! queue new-pair)
					 queue))))
(define (delete-queue! queue)
	(cond ((empty-queue? queue)
				 (error "DELETE! called with an empty queue" queue))
				(else
				 (set-front-ptr! queue (cdr (front-ptr queue)))
				 queue)))
(define (logical-and x y)
 (if (and (= x 1) (= y 1))
		 1
		 0))
(define (logical-not x)
	(if (= x 1)
		0
		1
		)
	)

(define nand-gate-delay 6)

(define (nand-gate a1 a2 output)
	(define (nand-action-procedure)
		(let ((new-value
					 (logical-not (logical-and (get-signal a1) (get-signal a2)))))
			(after-delay nand-gate-delay
									 (lambda ()
										 (set-signal! output new-value)))))
	(add-action! a1 nand-action-procedure)
	(add-action! a2 nand-action-procedure)
	'ok)


(define (xor-gate a b out)
	(let
	   ((c (make-wire))
		(d (make-wire))
		(e (make-wire)))
		(nand-gate a b c)
		(nand-gate a c d)
		(nand-gate b c e)
		(nand-gate d e out)
		'OK
		)
	)

(define (xnor-gate a b out)
	(let
	   ((c (make-wire)))
		(xor-gate a b c)
		(nand-gate c c out)
		'OK
		)
	)

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
	(println "None written.")
	)

; (define (run2)

; 	)

(define (run3)
	(println "None written.")
	)

(define (run4)
	(define input-1 (make-wire))
    (define input-2 (make-wire))
    (define output-xor (make-wire))
    (define output-xnor (make-wire))

    (xor-gate input-1 input-2 output-xor)
    (xnor-gate input-1 input-2 output-xnor)

	(println)
    (print "xor:  0 0 -> ")
    (set-signal! input-1 0)
    (set-signal! input-2 0)
    (propagate)
    (println (get-signal output-xor))
    (println "    [should be 0]")
	(println)
	(println)
    (print "xor:  0 1 -> ")
    (set-signal! input-1 0)
    (set-signal! input-2 1)
    (propagate)
    (println (get-signal output-xor))
    (println "    [should be 1]")
	(println)
    (print "xor:  1 0 -> ")
    (set-signal! input-1 1)
    (set-signal! input-2 0)
    (propagate)
    (println (get-signal output-xor))
    (println "    [should be 1]")
	(println)
    (print "xor:  1 1 -> ")
    (set-signal! input-1 1)
    (set-signal! input-2 1)
    (propagate)
    (println (get-signal output-xor))
    (println "    [should be 0]")
	(println)
    (print "xnor: 0 0 -> ")
    (set-signal! input-1 0)
    (set-signal! input-2 0)
    (propagate)
    (println (get-signal output-xnor))
    (println "    [should be 1]")
	(println)
    (print "xnor: 0 1 -> ")
    (set-signal! input-1 0)
    (set-signal! input-2 1)
    (propagate)
    (println (get-signal output-xnor))
    (println "    [should be 0]")
	(println)
    (print "xnor: 1 0 -> ")
    (set-signal! input-1 1)
    (set-signal! input-2 0)
    (propagate)
    (println (get-signal output-xnor))
    (println "    [should be 0]")
	(println)
    (print "xnor: 1 1 -> ")
    (set-signal! input-1 1)
    (set-signal! input-2 1)
    (propagate)
    (println (get-signal output-xnor))
    (println "    [should be 1]")
	(println)
	)

; (define (run5)

; 	)

(define (run6)
	(println)
	(println "I verified many elements were correct using Wolfram Alpha,")
	(println "but I didn't write any particular tests.")
	(println)
	(println "Printing elements 0 through 51 of the stream...")
	(stream-print pf-3-11-17 0 51)
	(println)
	)

; (define (run7)

; 	)

(define (run8)
	(println "As you can see below, the partial sum stream reaches Scam's")
	(println "precision limit by the 10th term, while the super-accelerated")
	(println "stream only requires two terms.")
	(println)
	(println "From what I could find online, Archimedes originally began")
	(println "the stream with 1 (then continued with what we have), and")
	(println "his answer was 4/3.")
	(println)

	(println "partial sum stream:")
	(stream-print ari-ps 0 10)
	(println)

	(println "super-accelerated stream:")
	(stream-print ari-super 0 5)
	(println)
	)

; (define (run9)

; 	)

(define (run10)
	(println "None written.")
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