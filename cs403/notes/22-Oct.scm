; function evalCall(t, scope) ; t is the parse tree
; {
; 	var closure = lookup(t.left, scope);
; 	var denv = closure.left; defining environment
; 	var params = closure.right.left;
; 	var args = t.right;
; 	var eargs = evalArgs(args, scope); evaluated arguments
; 	var body = closure.right.right; note - these locations depend on how i build parse trees.
; 	var xenv = extend(params, eargs, denv); extended environment
; 	return eval(body, xenv);
; }

;concurrency controls:

; (can read about in the concurrency chapter of scam reference manual)

; Streams

(define (ints-from a)
	(cons-stream
		append(ints-from (+ a 1))
		)
	)

(define (stream-add s t)
	(cons-stream
		(+ (stream-car s) (stream-car t))
		(stream-add (stream-cdr s) (stream-cdr t))
		)
	)

(define fibs
	(cons-stream 0
		(cons-stream 1
			(stream-add
				fibs
				(stream-cdr fibs)
				)
			)
		)
	)

