;;;  Proving Programs Correct ;;;

; assertions are similar to invariants, so we'll use invariants
; prove code correctness

invariant-based proving:
	precondition (often with term "requires")
	code
	postcondition (often with "ensures")


ex:

	<< x > 0 >> (call this "P")
	x = x + 1
	<< x > 1 >> (call this "Q")

Proof rule for assignment:
	P -> Qx/e (left side of assignment is "x", right side is "e")
	alternate syntax:
		p -> Q pushback S
	this means:
		replace every instance of x with e in Q and see if the implication holds

Proof rule for conditionals:
	(P and E -> Q pushback S) and (P and ~E -> Q pushback ST)

Loop Invariant:
	- some quantity that is perserved at the top and bottom of the loop
	- to prove that the code for a loop is correct, you've got to find this invariant
