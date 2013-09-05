CS 475 - Programming Languages
==============================

## Regular Expressions - 28 August 2013

# !!! Quiz Friday on FSMs!!!

- TERM: Regular Expression = 
- TERM: Operators (in order of increasing precedence)
	- Union = or
	- Concatenation = (normal def.)
	- Asterisk (*) = repeat zero or more times

- EXAMPLE
	- strings over {a, b} with the 4rd rightmost symbol being "b"
	- (a UNION b)* b (a UNION b) (a UNION b)

##### Convert regex to NFSM

- notebook-7

- The NFSMs we construct will have one final state, and that state will be distinct from the start state.

- notebook-8

- notebook-9

- notebook-10

- IMAGE @ 1:45

- IMAGE @ 1:50

## Regular Expressions (cont.) - 4 September 2013

- Example:
	- Identifiers (start with a letter, and the rest of the characters are either letters, digits, or underscores)
	- letter(letter|digit|"_")*
	- the first instance of letter above is same as [a-z]|[A-Z] or [a-zA-Z]
	- same goes for digit: [0-9]
	- full regex: \[a-zA-Z]([a-zA-Z]|[0-9]|"_")*

- Example:
	- write an expression that captures any string over {a, b} where the # of a's is odd (inclusive) or the # of b's is odd.
	- jsut the a part: a(aa)\*
	- both: b*ab*(\*ab\*)\*|a\*ba\*(ba\*ba\*)\*

- Example:
	- converting from regex to non-deterministic finite state machine
	- notebook-17

##### more regex shorthands

	- ? means optional. Ex: [0-9]? means a digit is optional
	- Epsilon represents the empty string

##### Regex Properties

- Associative:
	- (RS)T = R(ST) = RST
	- (R|S)|T = R|(S|T) = R|S|T

- Commutative:
	- R|S = S|R
	- RS != SR

- Distributive:
	- R(S|T) = RS|RT
		- Remember, concatenation has higher precedence than union.
	- (R|S)T = RT|ST

