## The Shunting-Yard Algorithm for infix -> prefix

- Reverse the input string.
- While there are tokens to be read:
	- Read a token.
	- If the token is a number:
		- Add it to the output stack.
	- If the token is an operator, o1, then:
		- While there is an operator token, o2, at the top of the stack, and either o1 is left-associative and its precedence is equal to that of o2, or o1 has precedence less than that of o2, pop o2 off the stack, onto the output stack;
- When there are no more tokens to read:
	- While there are still operator tokens in the stack:
		- If the operator token on the top of the stack is a parenthesis, then there are mismatched parentheses.
		- Pop the operator onto the output stack.
- Exit.