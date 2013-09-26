from exceptions import ParseException
from lexer import Lexer
import sys

class Parser:

	def __init__(self):
		self.current = None
		self.old = None
		self.l = self.setup()

	def setup(self):
		if len(sys.argv) != 2:
			sys.exit("Usage: python3 parser.py sourceFile")
		return Lexer(sys.argv[1])

	def parse(self):
		self.current = self.l.lex()
		self.program()
		self.match("END_OF_FILE")

	def check(self, tokenType):
		return self.current.tokenType == tokenType

	def match(self, tokenType):
		if self.check(tokenType) == False:
			raise ParseException(tokenType)
		self.old = self.current
		self.current = self.l.lex()
		return self.old

	def blockPending(self):
		# todo
		pass

	def statementsPending(self):
		# todo
		pass

	def ifStatementPending(self):
		# todo
		pass

	def whileStatementPending(self):
		# todo
		pass

	def expressionPending(self):
		# todo
		pass

	def sequencePending(self):
		# todo
		pass

	def program(self):
		# todo
		pass

	def ifStatement(self):
		self.match("IF")
		self.primary()
		self.match("IS")
		self.primary()
		self.match("COMMA")
		self.block()
		self.optOtherwise()

	def whileStatement(self):
		self.match("WHILE")
		self.primary()
		self.match("IS")
		self.primary()
		self.match("COMMA")
		self.block()
		self.optOtherwise()

	def block(self):
		self.optStatements()
		self.match("PERIOD")

	def optOtherwise(self):
		if self.check("OTHERWISE"):
			self.match("OTHERWISE")
			if self.blockPending():
				self.block()
			else:
				self.ifStatement()
		else:
			pass

	def optStatements(self):
		if self.statementsPending():
			self.statements()
		else:
			pass

	def statements(self):
		self.statement()
		self.optStatements()

	def statement(self):
		if self.expressionPending():
			self.expression()
			self.match("SEMICOLON")
		elif self.ifStatementPending():
			self.ifStatement()
		elif self.whileStatementPending():
			self.whileStatement()
		else:
			self.match("TODO")

	def primary(self):
		if self.check("VARIABLE"):
			self.match("VARIABLE")
		elif self.check("INTEGER"):
			self.match("INTEGER")
		elif self.check("STRING"):
			self.match("STRING")
		elif self.check("NOTHING"):
			self.match("NOTHING")
		elif self.expressionPending():
			self.expression()
		else:
			self.boolean()

	def functionCall(self):
		self.match("IDENTIFIER")
		self.match("OPEN_PARENTHESIS")
		self.optSequence()
		self.match("CLOSE_PARENTHESIS")

	def optSequence(self):
		if self.sequencePending():
			self.sequence()

	def sequence(self):
		self.primary()
		if self.check("AND"):
			self.match("AND")
			self.primary()
		else:
			self.commaChain()
			self.match("COMMA")
			self.match("AND")
			self.primary()

	def commaChain(self):
		if self.check("COMMA"):
			self.match("COMMA")
			self.primary()
			self.commaChain()
		else:
			pass

	def functionDef(self):
		self.match("TO")
		self.match("VARIABLE")
		self.optSequence()
		self.match("COLON")

	def expr(self):
		if self.check("OPEN_PARENTHESIS"):
			self.match("OPEN_PARENTHESIS")
			self.primary()
			self.operator()
			self.primary()
			self.match("CLOSE_PARENTHESIS")
		else:
			self.functionCall()

	def operator(self):
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
