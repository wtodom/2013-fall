;{
Define a procedure named tuple that computes all tuples of a given size such that no entry in the tuples is less than zero or greater than a given limit. Moreover, a value in the tuple cannot exceed the following value in the tuple. For example:
    (tuple 4 2)
should generate the list:

    ((0 0 0 0) (0 0 0 1) (0 0 0 2) (0 0 1 1) (0 0 1 2) ... (2 2 2 2))
The order of the tuples is not specified.
;}

(define (tuple width max)
	
	)