; map-reduce
; ==========

;;; build a list ;;;
(define (interval lo hi step)
	(if (>= lo hi)
		nil
		(cons lo (generate (+ step lo) hi step))
		)
	)

;;; would only use a function like this (that is,
;;; with two calls rather than just one) when there
;;; are side effects, e.g. printing
(define (for-each f items)
	(cond
		((null? items) nil)
		(else
			(f (car items))
			(for-each f (cdr items))
			)
		)
	)

;;; filter when you keep the items that match ;;;
(define (keep p? items)
	((null? items) nil)
	((p? (car items)) (cons (car items) (keep p? (cbr items))))
	(else
		((keep p? (cdr items)))
		)
	)

;;; filter when you don't keep them ;;;
(define (remove p? items)
	(keep? (lambda (x) (not (p? x))) items)
	)