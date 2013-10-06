(include "ci.lib")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; These functions use regular style. ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; the "rm-" prefix stands for "row major"

(define (dot-product v w)
	(accumulate + 0 (map * v w))
	)

(define (rm-matrix-*-vector m v)
	(map (lambda (row-in-m) (dot-product row-in-m v)) m)
	)

(define (transpose m)
	(cond
		((eq? (type (car m)) 'CONS) (accumulate-n cons () m))
		(else
			(map (lambda (x) (list x)) m)
			)
		)
	)

(define (otranspose m)
	(accumulate-n cons () m)
	)

(define (rm-matrix-*-matrix m n)
	(let ((n-cols (transpose n)))
    	(map
    		(lambda (m-row) (rm-matrix-*-vector n-cols m-row))
        	m
        	)
    	)
	)

(define mone (list (list 1 2 3) (list 4 5 6)))
(define mtwo (list (list 1 3 5 7) (list 2 4 6 8) (list -1 -2 -3 -4)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; These functions use col maj style. ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (matrix-*-vector m v)
	(rm-matrix-*-vector (transpose m) v)
	)

(define (matrix-*-matrix m n)
	(rm-matrix-*-matrix (transpose m) (transpose n))
	)

(inspect (dot-product '(1 2) '(3 4)))
(println "    [it should be 11]")

(inspect (matrix-*-vector '((1 2) (3 4)) '(5 6)))
(println "    [it should be (23 34)]")

(inspect (transpose '((1 2) (3 4))))
(println "    [it should be ((1 3) (2 4))]")

(inspect (matrix-*-matrix '((1 2) (3 4)) '((1 0) (0 1))))
(println "    [it should be ((1 3) (2 4))]")

(inspect (matrix-*-matrix '((1 2 6 4) (3 4 -3 0)) '((1 0) (0 1) (5 5))))
