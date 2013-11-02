from exceptions import ParseError
from lexer import Lexer
import sys


class Parser:


	def __init__(self):
		self._debug = False
		self.current = None
		self.old = None
		self.l = self.setup()

	def setup(self):
		if self._debug: print(" in ifStatementPending")
		if len(sys.argv) != 2:
			sys.exit("Usage: python3 parser.py sourceFile")
		return Lexer(sys.argv[1])

	def parse(self):
		if self._debug: print(" in ifStatementPending")
		self.current = self.l.lex()
		self.program()
		self.l.close_file()
		print()
		print("###############################")
		print("### Parsing was successful. ###")
		print("###############################")

	def check(self, tokenType):
		return self.current.tokenType == tokenType

	def match(self, tokenType):
		print("Attempting to match Lexeme: " + str(self.current))
		if not self.check(tokenType):
			raise ParseError(tokenType)
		print("token matched.")
		self.old = self.current
		self.current = self.l.lex()
		return self.old

	def functionDefPending(self):
		if self._debug: print(" in functionDefPending")
		return self.check("TO")

	def functionCallPending(self):
		if self._debug: print(" in functionCallPending")
		return self.check("CARROT")

	def ifStatementPending(self):
		if self._debug: print(" in ifStatementPending")
		return self.check("IF")

	def whileStatementPending(self):
		if self._debug: print(" in whileStatementPending")
		return self.check("WHILE")

	def expressionPending(self):
		if self._debug: print(" in expressionPending")
		return (
			self.primaryPending() or
			self.functionCallPending() or
			self.check("OPEN_PARENTHESIS")
		)

	def statementsPending(self):
		if self._debug: print(" in statementsPending")
		return (
			self.ifStatementPending() or
			self.whileStatementPending() or
			self.expressionPending() or
			self.assignmentPending() or
			self.check("TODO")
			)

	def sequencePending(self):
		if self._debug: print(" in sequencePending")
		return self.primaryPending()

	def primaryPending(self):
		if self._debug: print(" in primaryPending")
		return (
			self.check("VARIABLE") or
			self.check("NUMBER") or
			self.check("STRING") or
			self.check("TRUE") or
			self.check("FALSE") or
			self.check("NOTHING")
			)

	def commaChainPending(self):
		if self._debug: print(" in commaChainPending")
		return self.check("COMMA")

	def assignmentPending(self):
		if self._debug: print(" in assignmentPending")
		return self.check("SET")

	def program(self):
		if self._debug: print(" in program")
		if self.functionDefPending():
			self.functionDef()
		if self.statementsPending():
			self.statements()
		self.match("EOF")

	def functionDef(self):
		if self._debug: print(" in functionDef")
		self.match("TO")
		self.match("VARIABLE")
		if self._debug: print("         Checking for optSequence.")
		self.optSequence()
		if self._debug: print("         about to match colon.")
		self.match("COLON")
		self.block()

	def optSequence(self):
		if self._debug: print(" in optSequence")
		if self.sequencePending():
			if self._debug: print("Sequence was pending.")
			self.sequence()
		if self._debug: print("         done with optSequence")

	def sequence(self):
		if self._debug: print(" in sequence")
		self.expression()
		if self.check("AND"):
			self.match("AND")
			self.expression()
		elif self.commaChainPending():
			self.commaChain()
			self.match("COMMA")
			self.match("AND")
			self.expression()

	def commaChain(self):
		if self._debug: print(" in commaChain")
		self.match("COMMA")
		self.expression()
		self.optCommaChain()

	def optCommaChain(self):
		if self._debug: print(" in optCommaChain")
		if self.check("COMMA"):
			self.match("COMMA")
			self.expression()
			self.optCommaChain()

	def block(self):
		if self._debug: print(" in block")
		self.optStatements()
		self.match("PERIOD")

	def optStatements(self):
		if self._debug: print(" in optStatements")
		if self.statementsPending():
			self.statements()

	def statements(self):
		if self._debug: print(" in statements")
		self.statement()
		self.optStatements()

	def statement(self):
		if self._debug: print(" in statement")
		if self.expressionPending():
			self.expression()
			self.match("SEMICOLON")
		elif self.ifStatementPending():
			self.ifStatement()
		elif self.whileStatementPending():
			self.whileStatement()
		elif self.assignmentPending():
			self.assignment()
		else:
			self.match("TODO")

	def ifStatement(self):
		if self._debug: print(" in ifStatement")
		self.match("IF")
		self.booleanExpression()
		self.match("COMMA")
		self.block()
		self.optOtherwise()

	def whileStatement(self):
		if self._debug: print(" in whileStatement")
		self.match("WHILE")
		self.booleanExpression()
		self.match("COMMA")
		self.block()

	def booleanExpression(self):
		self.expression()
		self.match("IS")
		self.boolOp()
		self.expression()

	def optOtherwise(self):
		if self._debug: print(" in optOtherwise")
		if self.check("OTHERWISE"):
			self.match("OTHERWISE")
			if self.ifStatementPending():
				self.ifStatement()
			else:
				self.block()

	def assignment(self):
		if self._debug: print(" in assignment")
		self.match("SET")
		self.match("VARIABLE")
		self.match("TO")
		self.expression()
		self.match("SEMICOLON")

	def expression(self):
		if self._debug: print(" in expression")
		if self.check("OPEN_PARENTHESIS"):
			self.match("OPEN_PARENTHESIS")
			self.expression()
			self.operator()
			self.expression()
			self.match("CLOSE_PARENTHESIS")
		elif self.primaryPending():
			self.primary()
		elif self.functionCallPending():
			self.functionCall()

	def primary(self):
		if self._debug: print(" in primary")
		if self.check("VARIABLE"):
			self.match("VARIABLE")
		elif self.check("INTEGER"):
			self.match("INTEGER")
		elif self.check("STRING"):
			self.match("STRING")
		elif self.check("NUMBER"):
			self.match("NUMBER")
		elif self.check("NOTHING"):
			self.match("NOTHING")
		elif self.check("TRUE"):
			self.match("TRUE")
		elif self.check("FALSE"):
			self.match("FALSE")

	def functionCall(self):
		if self._debug: print(" in functionCall")
		self.match("CARROT")
		self.match("VARIABLE")  # IDENTIFIER
		self.match("OPEN_PARENTHESIS")
		self.optSequence()
		self.match("CLOSE_PARENTHESIS")

	def operator(self):
		if self._debug: print(" in operator")
		if self.check("PLUS"):
			self.match("PLUS")
		elif self.check("MINUS"):
			self.match("MINUS")
		elif self.check("DIVIDE"):
			self.match("DIVIDE")
		else:
			self.match("MULTIPLY")

	def boolOp(self):
		if self.check("DOUBLE_EQUALS"):
			self.match("DOUBLE_EQUALS")
		elif self.check("NOT_EQUAL"):
			self.match("NOT_EQUAL")
		elif self.check("LESS_THAN"):
			self.match("LESS_THAN")
		elif self.check("LESS_THAN_EQUAL"):
			self.match("LESS_THAN_EQUAL")
		elif self.check("GREATER_THAN"):
			self.match("GREATER_THAN")
		else:
			self.match("GREATER_THAN_EQUAL")

if __name__ == "__main__":
	p = Parser()
	p.parse()
