; maybe use . notation for parameters:
; (f x y . z) has two names paramenter, then z bundles any additional ones into a list.
; (f . n) has no named parameters, but any given are in the list, n.
; (see exercise 2.2)
(include "ci.lib")


(define (curry f)
	
	)

; (inspect (string+ "w" "x" "y" "z"))
; (inspect ((((((curry string+) "w") "x") "y") "z")))

