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

(inspect (scoping 'y ((define (zurp x) (define y (+ x 1)) this) 5)))
(println "[should be: 'bound]\n")
(inspect (scoping '* ((define (zarp x) this) 5)))
(println "[should be: 'free]\n")
(inspect (scoping 'cs403sucks ((define (zirp x) this) 5)))
(println "[should be: 'undefined]\n")
