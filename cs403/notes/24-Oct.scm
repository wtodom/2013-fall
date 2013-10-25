; hacky way to print:

; add a rule that looks like a func call to primary:

; primary: PRINT OPAREN argList CPAREN
; 	   | [everything else]
; 	   can also do:
	   ; | ARRAY OPAREN expr CPAREN

; elegant way to print:

; in final version we have an inital invironment:

; env = extend(null, null, null);
; addBuiltins(env); ; function to add built-in functions to language
; p = parse(filename);
; eval(p, env);


; function addBuiltins(env)
; {
; 	addVariable(new Lexeme(ID, "print"), new Lexeme(BUILTIN, "PRINT"), env);
	; and so on
; }

; function evalCall(t, env)
; {
	; some stuff here
; 	closure = lookup(t.left, env); ; or wherever the name of the func we want to call is located in the tree
; 	if (closure.type == BUILTIN)
; 	{
; 		return evalBuiltin(closure, env);
; 	}
; }

; =============== OTHER STREAM SEQUENCES =================

(define ones
	(cons-stream 1 ones)
	)
(define nats
	(cons-stream 1 (stream-add ones nats))
	)
(define facts
	(cons-stream 1 (stream-mult facts (stream-cdr nats)))
	)

(define (cons-stream # a $b)
	(list a $b #)
	)

(define (stream-car c)
	(car c)
	)

(define (stream-cdr c)
	(eval (cadr c) (caddr c)) ; this isn't what scam does - this doesn't memoize
	)

;;;; making sieve of erastosthenes

(define (stream-remove stream pred?)
	(if (pred? (stream-car stream))
		(stream-remove (stream-cdr stream) pred?)
		(cons-stream (stream-car s) (stream-remove (stream-cdr s) pred?))
		)
	)

(define (sieve numbers) ; initial call: (sieve (stream-cdr nats))
	(cons-stream
		(stream-car numbers)
		(sieve (stream-remove (stream-cdr numbers) (lambda (x) (= (% x (stream-car numbers)) 0))))
		)
	)

;;;;;;; streams of partial sums (ex: generating partial sum of pi/4)

(define (psum s)
	(cons-stream
		(stream-car s)
		(psum
			(cons-stream
				(+ (stream-car s) (stream-cadr s))
				(stream-cddr s)
				)
			)
		)
	)

; if you multiply through by the 4 from pi/4, all numerators are +- 4
(define nums (cons-stream 4 (cons-stream -4 nums)))
; the denoms become just the odd nums
(define denoms (cons-stream 1 (stream-add twos denoms)))
(define pi-terms (stream-div nums denoms))
(define pi-approx (psum pi-terms))

; this takes FOREVER to converge.
; 14 decimal places of accuracy takes 10^13 iterations

; use euler transform to make faster

(define (transform s)
	(define Sn+1 (stream-car s))
	(define Sn (stream-cadr s))
	(define Sn-1 (stream-caddr s))
	(- Sn+1 (/ (^ (- Sn+1 Sn) 2) (+ Sn-1 (* -2 Sn) Sn+1)))
	)

(define pi-approx1
	(cons-stream
		(stream-car pi-approx)
		(stream-map transform pi-approx)
		)
	)

(define (make-tableau s trasn) ; a stream and a transform function
	(cons-stream
		s
		(make-tableau
			(stream-map trans s)
			trans)
		)
	)

(define pi-super
	(stream-map
		stream-car
		(make-tableau
			pi-approx
			transform
			)
		)
	)