; Create an infinite stream of integers whose only prime factors are 3, 11, and 17.
; The first few elements of the stream are [3,9,11,17,27,...]. Name the stream pf-3-11-17.

(include "assign3/stream.lib")

; (define ones (cons-stream 1 ones))

; (define base
;     (cons-stream
;         1
;         (stream-add
;             ones
;             base
;             )
;         )
;     )

(define pf-3-11-17-full
    (cons-stream
        1
        (merge
            (scale-stream
                pf-3-11-17-full
                3
                )
            (merge
                (scale-stream
                    pf-3-11-17-full
                    11
                    )
                (scale-stream
                    pf-3-11-17-full
                    17
                    )
                )
            )
        )
    )

(define pf-3-11-17 (stream-cdr pf-3-11-17-full))

; (inspect (stream-car pf-3-11-17))
; (inspect (stream-car (stream-cdr pf-3-11-17)))
; (inspect (stream-car (stream-cdr (stream-cdr pf-3-11-17))))
; (inspect (stream-car (stream-cdr (stream-cdr (stream-cdr pf-3-11-17)))))

(define (stream-print s start stop)
    (define (streamIter curr)
        (cond
            ((= curr stop) nil)
            (else
                (println (stream-ref s curr))
                (streamIter (+ curr 1))
                )
            )
        )
    (streamIter start)
    )

(stream-print pf-3-11-17 0 331)