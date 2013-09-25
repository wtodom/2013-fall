def ifStatement():
	match(IF)
	primary()
	match(IS)
	primary()
	match(COMMA)
	block()
	optOtherwise()

def whileStatement():
	match(WHILE)
	primary()
	match(IS)
	primary()
	match(COMMA)
	block()
	optOtherwise()

def block():
	optStatements()
	match(PERIOD)

def optOtherwise():
	if check(OTHERWISE):
		match(OTHERWISE)
		if blockPending():
			block()
		else:
			ifStatement()
	else:
		pass

def optStatements():
	if statementsPending():
		statements()
	else:
		pass

def statements():
	statement()
	optStatements()

def statement():
	if expressionPending():
		expression()
		match(SEMICOLON)
	elif ifStatementPending():
		ifStatement()
	elif whileStatementPending():
		whileStatement()
	else:
		match(TODO)

def primary():
	if check(VARIABLE):
		match(VARIABLE)
	elif check(INTEGER):
		match(INTEGER)
	elif check(STRING):
		match(STRING)
	elif check(NOTHING):
		match(NOTHING)
	elif expressionPending():
		expression()
	else:
		boolean()

def functionCall():
	match(IDENTIFIER)
	match(OPEN_PARENTHESIS)
	optList()
	match(CLOSE_PARENTHESIS)

def optList():
	if listPending():
		list() # change name

def list(): # rename from list since python has built-in
	primary()
	if check(AND):
		match(AND)
		primary()
	else:
		commaChain()
		match(COMMA)
		match(AND)
		primary()

def commaChain():
	if check(COMMA):
		match(COMMA)
		primary()
		commaChain()
	else:
		pass

def functionDef():
	match(TO)
	match(VARIABLE)
	optList()
	match(COLON)

def expr():
	if check(OPEN_PARENTHESIS):
		match(OPEN_PARENTHESIS)
		primary()
		operator()
		primary()
		match(CLOSE_PARENTHESIS)
	else:
		functionCall()

def operator():
	if check(PLUS):
		match(PLUS)
	elif check(MINUS):
		match(MINUS)
	elif check(DIVIDE):
		match(DIVIDE)
	elif check(MULTIPLY):
		match(MULTIPLY)
	elif check(DOUBLE_EQUALS):
		match(DOUBLE_EQUALS)
	elif check(NOT_EQUAL):
		match(NOT_EQUAL)
	elif check(LESS_THAN):
		match(LESS_THAN)
	elif check(LESS_THAN_EQUAL):
		match(LESS_THAN_EQUAL)
	elif check(GREATER_THAN):
		match(GREATER_THAN)
	else:
		match(GREATER_THAN_EQUAL)
