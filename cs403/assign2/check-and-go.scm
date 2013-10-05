(define (check-and-go $expr1 $expr2) ;;; DONE ;;;
	(cond
		((not (error? (catch (eval $expr1 this)))) (eval $expr1 this))
		(else
			(eval $expr2 this))
		)
	)

(inspect (check-and-go (/ 4 0) 3))
(inspect (check-and-go (/ 4) "Second"))
(inspect (check-and-go (cons 0) (* 2 4 2)))
(inspect (check-and-go (* 32 23) 3))
(inspect (check-and-go "fsdf" 3))