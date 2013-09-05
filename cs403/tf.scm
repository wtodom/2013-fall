(define (my-if a b c)
    (if (true? a)
        b
        c
        )
    )

(println "'my-if' and 'if' perform differently due to the 
consequent and alternative being evaluated/replaced in a 
different way. In the original if, only the statement 
that is appropriate based on the predicate's value is
evaluated. However, in 'my-if', both parts are evaluated 
before the predicate. For many statements (such as the one 
given as an example) this doesn't have much effect, but when
the consequent and/or alternative can have side effects or 
produce output, unintended consequences will occur.

For example, consider the following two statements:

(if #t 
	(println 'Regular if prints this if true.') 
	(println 'Regular if prints this if false.')
	)

(my-if #t 
	(println 'My-if prints this if true.) 
	(println 'My-if prints this if false.')
	)

In these cases, both the consequent and alternative produce 
output, so evaluating them prior to the predicate will result
in malfunctioning code.

Below is the output of the two statements. Notice that for 
the original 'if' only one statement prints, whereas for 
'my-if' both statements print.")

(newline)

(if #t 
	(println "Regular if prints this if true.") 
	(println "Regular if prints this if false.")
	)

(my-if #t 
	(println "My-if prints this if true.") 
	(println "My-if prints this if false.")
	)
