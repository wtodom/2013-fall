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