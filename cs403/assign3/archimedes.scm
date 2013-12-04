; http://en.wikipedia.org/wiki/1/4_%2B_1/16_%2B_1/64_%2B_1/256_%2B_%C2%B7_%C2%B7_%C2%B7

(include "assign3/stream.lib")

(define ones (cons-stream 1 ones))

(define fours (cons-stream 4 fours))

(define powers-of-four
	(cons-stream 1 (stream-mult fours powers-of-four)))

(define numers ones)

(define denoms (stream-cdr powers-of-four))

; (inspect (stream-car powers-of-four))
; (inspect (stream-car (stream-cdr powers-of-four)))
; (inspect (stream-car (stream-cdr (stream-cdr powers-of-four))))
; (inspect (stream-car (stream-cdr (stream-cdr (stream-cdr powers-of-four)))))

(define ari (stream-div-real numers denoms))

; (inspect (stream-car ari))
; (inspect (stream-car (stream-cdr ari)))
; (inspect (stream-car (stream-cdr (stream-cdr ari))))
; (inspect (stream-car (stream-cdr (stream-cdr (stream-cdr ari)))))

(define ari-ps (partial-sum ari))

; (inspect (stream-car ari-ps))
; (inspect (stream-car (stream-cdr ari-ps)))
; (inspect (stream-car (stream-cdr (stream-cdr ari-ps))))
; (inspect (stream-car (stream-cdr (stream-cdr (stream-cdr ari-ps)))))

(define ari-acc
	(cons-stream
		(stream-car ari-ps)
		(accelerate ari-ps)
		)
	)

; (inspect (stream-car ari-acc))
; (inspect (stream-car (stream-cdr ari-acc)))
; (inspect (stream-car (stream-cdr (stream-cdr ari-acc))))
; (inspect (stream-car (stream-cdr (stream-cdr (stream-cdr ari-acc)))))

(define ari-super
	(stream-map
		stream-car
		(tableau
			ari-acc
			accelerate
			)
		)
	)

; (inspect (stream-car ari-super))
; (inspect (stream-car (stream-cdr ari-super)))
; (inspect (stream-car (stream-cdr (stream-cdr ari-super))))
; (inspect (stream-car (stream-cdr (stream-cdr (stream-cdr ari-super)))))

(stream-print ari-super 0 8)