(define (check-and-go $expr1 $expr2)
	(cond
		((not (error? (catch (eval $expr1 this)))) (eval $expr1 this))
		(else
			((eval $expr2 this) (catch (eval $expr1 this)))
			)
		)
	)

(inspect (check-and-go (/ 4 0)
        (lambda (error)
            (ppTable error)
            )
        )
	)