(include "assign3.scm")

(println "Test Script: VERSION 2\n")

(define (scadr s) (stream-car (stream-cdr s)))
(define (scaddr s) (stream-car (stream-cdr (stream-cdr s))))
(define (scadddr s) (stream-car (stream-cdr (stream-cdr (stream-cdr s)))))

(define (fakestream items)
    (cons-stream
        (car items)
        (fakestream (cdr items))
        )
    )

(println "author...\n")

(author)

(println)

(print "PROBLEM 1:")
(if (defined? 'run1 this)
    (begin
        (println "\n\n------your tests--------------------\n")
        (run1)
        (println "\n-------my tests---------------------\n")
        (inspect (define (square-pants x) (define pants (* x x)) this))
        (inspect (scoping 'sponge-bob (square-pants 5)))
        (println "    [it should (likely) be undefined]")
        )
    (println " NOT IMPLEMENTED\n")
    )

(print "PROBLEM 2:")
(if (defined? 'run2 this)
    (begin
        (println "\n\n------your tests--------------------\n")
        (run1)
        (println "\n-------my tests---------------------\n")
        (inspect (define (multiply a b) (* a b)))
        (inspect (define (square x) (multiply x x)))
        (inspect (compile square))
        (inspect (get 'code square))
        (println "square now is:")
        (pretty square)
        (inspect (square 10))
        (println "    [it should be 100]")
        )
    (println " NOT IMPLEMENTED\n")
    )

(print "PROBLEM 3:")
(if (defined? 'run3 this)
    (begin
        (println "\n\n------your tests--------------------\n")
        (run3)
        (println "\n-------my tests---------------------\n")
        (inspect (define t (bst)))
        (inspect ((t 'insert) 3 4 5 1 0))
        (inspect ((t 'find) 5))   ; should return #t
        (println "    [it should be #t]\n")
        (inspect ((t 'find) 7))   ; should return #f
        (println "    [it should be #f]\n")
        (inspect ((t 'root)))     ; should return 3
        (println "    [it should be 3]\n")
        (inspect ((t 'size)))     ; should return 5
        (println "    [it should be 5]\n")
        (print "traversal of t: ")
        ((t 'traverse))           ; should print 3 4 1 0 5
        (println)
        (println "    [it should be 3 1 0 4 5]\n")
        )
    (println " NOT IMPLEMENTED\n")
    )

(print "PROBLEM 4:")
(if (defined? 'run4 this)
    (begin
        (println "\n\n------your tests--------------------\n")
        (run4)
        (println "\n-------my tests---------------------\n")
        (define input-1 (make-wire))
        (define input-2 (make-wire))
        (define output-xor (make-wire))
        (define output-xnor (make-wire))
        
        (xor-gate input-1 input-2 output-xor)
        (xnor-gate input-1 input-2 output-xnor)

        (print "xor:  0 0 -> ")
        (set-signal! input-1 0)
        (set-signal! input-2 0)
        (propagate)
        (println (get-signal output-xor))
        (println "    [should be 0]")
        (print "xnor: 0 1 -> ")
        (set-signal! input-1 0)
        (set-signal! input-2 1)
        (propagate)
        (println (get-signal output-xnor))
        (println "    [should be 0]")
        (println)
        )
    (println " NOT IMPLEMENTED\n")
    )

(print "PROBLEM 5:")
(if (defined? 'run5 this)
    (begin
        (println "\n\n------your tests--------------------\n")
        (run5)
        (println "\n-------my tests---------------------\n")
        (define (f) (sleep 1) ((m'p)) (println "f") ((m'v)))
        (define (g) (sleep 1) ((m'p)) (println "g") ((m'v)))
        (define (h) (sleep 1) ((m'p)) (println "h") ((m'v)))
        (inspect (define m (mmutex 2)))
        (allocateSharedMemory)
        (pexecute (f) (g) (h))
        (freeSharedMemory)
        (println)
        )
    (println " NOT IMPLEMENTED (extra credit)\n")
    )

(print "PROBLEM 6:")
(if (defined? 'run6 this)
    (begin
        (println "\n\n------your tests--------------------\n")
        (run6)
        (println "\n-------my tests---------------------\n")
        (inspect (stream-car pf-3-11-17))
        (println "    [it should be 3]\n")
        (inspect (stream-car (stream-cdr pf-3-11-17)))
        (println "    [it should be 9]\n")
        (inspect (stream-car (stream-cdr (stream-cdr pf-3-11-17))))
        (println "    [it should be 11]\n")
        )
    (println " NOT IMPLEMENTED\n")
    )

(print "PROBLEM 7:")
(if (defined? 'run7 this)
    (begin
        (println "\n\n------your tests--------------------\n")
        (run7)
        (println "\n-------my tests---------------------\n")
        (define poly (fakestream (list .0 .1 .2 .3 .4 .3 .2 .1 .0)))
        (define intPoly (integral poly 0.1))
        (inspect (stream-car poly))
        (println "    [it should be 0.0]\n")
        (inspect (stream-car intPoly))
        (println "    [it should be 0.0]\n")
        (inspect (stream-car (differential intPoly .1)))
        (println "    [it should be 0.1]\n")
        (inspect (stream-car (subStreams poly poly)))
        (println "    [it should be 0.0]\n")
        )
    (println " NOT IMPLEMENTED\n")
    )

(print "PROBLEM 8:")
(if (defined? 'run8 this)
    (begin
        (println "\n\n------your tests--------------------\n")
        (run8)
        (println "\n-------my tests---------------------\n")
        (println "2nd element of ari: " (stream-car (stream-cdr ari)))
        (println "    [it should be 0.062500]\n")
        (println "2nd element of ari-ps: " (stream-car (stream-cdr ari-ps)))
        (println "    [it should be 0.312500]\n")
        (println "2nd element of ari-acc " (fmt "%.20f" (stream-car (stream-cdr ari-acc))))
        (println "    [it should be 0.33333333333333331483]\n")
        (println "1st element of ari-super: " (stream-car ari-super))
        (println "    [it should be 0.250000]\n")
        )
    (println " NOT IMPLEMENTED\n")
    )

(print "PROBLEM 9:")
(if (defined? 'run9 this)
    (begin
        (println "\n\n------your tests--------------------\n")
        (run9)
        (println "\n-------my tests---------------------\n")
        (inspect (stream-car (ramanujan)))
        (println "    [it should be 1729]\n")
        )
    (println " NOT IMPLEMENTED\n")
    )

(print "PROBLEM 10:")
(if (defined? 'run10 this)
    (begin
        (println "\n\n------your tests--------------------\n")
        (run10)
        (println "\n-------my tests---------------------\n")
        (define r
            (rand
                (fakestream '(
                    reset 2500 
                    generate 
                    generate 
                    reset 5542 
                    generate 
                    generate 
                    generate
                    ))
                )
            )
        (inspect (stream-car r))
        (println "    [it should be 2500]\n")
        (inspect (stream-car (stream-cdr r)))
        (println "    [it should be 6250]\n")
        )
    (println " NOT IMPLEMENTED\n")
    )
