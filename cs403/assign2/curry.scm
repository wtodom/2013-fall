; maybe use . notation for parameters:
; (f x y . z) has two names paramenter, then z bundles any additional ones into a list.
; (f . n) has no named parameters, but any given are in the list, n.
; (see exercise 2.2)
; (include "ci.lib")

(define (curry f)
	; (ppTable this)
	)

; (inspect (- 9 4 1))
; (ppTable (((((curry -) 9) 4) 1)))

(define (f a b c d e f)

	)

; (inspect (get 'parameters f))
; (inspect (length (get 'parameters f)))