; http://en.wikipedia.org/wiki/1/4_%2B_1/16_%2B_1/64_%2B_1/256_%2B_%C2%B7_%C2%B7_%C2%B7

(include "stream.lib")

(define fours (cons-stream 4 fours))

(define powers-of-four
	(cons-stream 1 (stream-mult fours powers-of-four)))

(define numers ones)

(define denoms (stream-cdr powers-of-four))

; (inspect (stream-car powers-of-four))
; (inspect (stream-car (stream-cdr powers-of-four)))
; (inspect (stream-car (stream-cdr (stream-cdr powers-of-four))))
; (inspect (stream-car (stream-cdr (stream-cdr (stream-cdr powers-of-four)))))

(define ari (stream-div numers denoms))

; (inspect (stream-car ari))
; (inspect (stream-car (stream-cdr ari)))
; (inspect (stream-car (stream-cdr (stream-cdr ari))))
; (inspect (stream-car (stream-cdr (stream-cdr (stream-cdr ari)))))

(define ari-ps (psum ari))

; (inspect (stream-car ari-ps))
; (inspect (stream-car (stream-cdr ari-ps)))
; (inspect (stream-car (stream-cdr (stream-cdr ari-ps))))
; (inspect (stream-car (stream-cdr (stream-cdr (stream-cdr ari-ps)))))

(define ari-acc
	(cons-stream
		(stream-car ari-ps)
		(stream-transform euler-transform ari-ps)
		)
	)

(inspect (stream-car ari-acc))
(inspect (stream-car (stream-cdr ari-acc)))
(inspect (stream-car (stream-cdr (stream-cdr ari-acc))))
(inspect (stream-car (stream-cdr (stream-cdr (stream-cdr ari-acc)))))

(define ari-super
	(stream-map
		stream-car
		(make-tableau-with-transform
			ari-acc
			euler-transform
			)
		)
	)

(inspect (stream-car ari-super))
(inspect (stream-car (stream-cdr ari-super)))
(inspect (stream-car (stream-cdr (stream-cdr ari-super))))
(inspect (stream-car (stream-cdr (stream-cdr (stream-cdr ari-super)))))
