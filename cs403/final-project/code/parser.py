from exceptions import ParseError
from lexer import Lexer
import sys


class Parser:

	def __init__(self):
		print(" in ifStatementPending")
		self.current = None
		self.old = None
		self.l = self.setup()

	def setup(self):
		print(" in ifStatementPending")
		if len(sys.argv) != 2:
			sys.exit("Usage: python3 parser.py sourceFile")
		return Lexer(sys.argv[1])

	def parse(self):
		print(" in ifStatementPending")
		self.current = self.l.lex()
		self.program()
		self.match("END_OF_FILE")

	def check(self, tokenType):
		return self.current.tokenType == tokenType

	def match(self, tokenType):
		print("Attempting to match: " + str(self.current))
		if not self.check(tokenType):
			raise ParseError(tokenType)
		print("token matched.")
		self.old = self.current
		self.current = self.l.lex()
		return self.old

	def functionCallPending(self):
		# TODO: write this function.
		return False

	def ifStatementPending(self):
		print(" in ifStatementPending")
		return self.check("IF")

	def whileStatementPending(self):
		print(" in whileStatementPending")
		return self.check("WHILE")

	def expressionPending(self):
		print(" in expressionPending")
		return self.check("OPEN_PARENTHESIS")

	def statementsPending(self):
		print(" in statementsPending")
		return (
			self.ifStatementPending() or
			self.whileStatementPending() or
			self.expressionPending() or
			self.assignmentPending() or
			self.check("TODO")
			)

	def sequencePending(self):
		print(" in sequencePending")
		return self.primaryPending()

	def primaryPending(self):
		print(" in primaryPending")
		return (
			self.check("VARIABLE") or
			self.check("INTEGER") or
			self.check("STRING") or
			self.check("TRUE") or
			self.check("FALSE") or
			self.check("NOTHING") or
			self.expressionPending()
			)

	def commaChainPending(self):
		print(" in commaChainPending")
		return self.check("COMMA")

	def assignmentPending(self):
		print(" in assignmentPending")
		return self.check("SET")

	def program(self):
		print(" in program")
		self.functionDef()
		if self.statementsPending():
			self.statements()

	def functionDef(self):
		print(" in functionDef")
		self.match("TO")
		self.match("VARIABLE")
		print("         Checking for optSequence.")
		self.optSequence()
		print("         about to match colon.")
		self.match("COLON")
		self.block()

	def optSequence(self):
		print(" in optSequence")
		if self.sequencePending():
			print("Sequence was pending.")
			self.sequence()
		print("         done with optSequence")

	def sequence(self):
		print(" in sequence")
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
		print(" in commaChain")
		self.match("COMMA")
		self.expression()
		self.optCommaChain()

	def optCommaChain(self):
		print(" in optCommaChain")
		if self.check("COMMA"):
			self.match("COMMA")
			self.expression()
			self.optCommaChain()

	def block(self):
		print(" in block")
		self.optStatements()
		self.match("PERIOD")

	def optStatements(self):
		print(" in optStatements")
		if self.statementsPending():
			self.statements()

	def statements(self):
		print(" in statements")
		self.statement()
		self.optStatements()

	def statement(self):
		print(" in statement")
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
		print(" in ifStatement")
		self.match("IF")
		self.expression()
		self.match("IS")
		self.expression()
		self.match("COMMA")
		self.block()
		self.optOtherwise()

	def whileStatement(self):
		print(" in whileStatement")
		self.match("WHILE")
		self.expression()
		self.match("IS")
		self.expression()
		self.match("COMMA")
		self.block()

	def optOtherwise(self):
		print(" in optOtherwise")
		if self.check("OTHERWISE"):
			self.match("OTHERWISE")
			if self.ifStatementPending():
				self.ifStatement()
			else:
				self.block()

	def assignment(self):
		print(" in assignment")
		self.match("SET")
		self.match("VARIABLE")
		self.match("TO")
		self.expression()
		self.match("SEMICOLON")

	def expression(self):
		print(" in expression")
		if self.primaryPending():
			self.primary()
		elif self.check("OPEN_PARENTHESIS"):
			self.match("OPEN_PARENTHESIS")
			self.primary()
			self.operator()
			self.primary()
			self.match("CLOSE_PARENTHESIS")
		elif self.functionCallPending():
			self.functionCall()
		elif self.assignmentPending():
			self.assignment()

	def primary(self):
		print(" in primary")
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
		print(" in functionCall")
		self.match("VARIABLE")  # IDENTIFIER
		self.match("OPEN_PARENTHESIS")
		self.optSequence()
		self.match("CLOSE_PARENTHESIS")

	def operator(self):
		print(" in operator")
		if self.check("PLUS"):
			self.match("PLUS")
		elif self.check("MINUS"):
			self.match("MINUS")
		elif self.check("DIVIDE"):
			self.match("DIVIDE")
		elif self.check("MULTIPLY"):
			self.match("MULTIPLY")
		elif self.check("DOUBLE_EQUALS"):
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
