from exceptions import ParseError
from lexeme import Lexeme
from lexer import Lexer
import sys

import treeviz


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
			raise ParseError(tokenType, self.current.tokenType)
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
			self.check("BOOLEAN") or
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
		while self.functionDefPending() or self.statementsPending():
			if self.functionDefPending():
				self.functionDef()
			if self.statementsPending():
				self.statements()
		self.match("EOF")

	def functionDef(self):
		if self._debug: print(" in functionDef")
		self.match("TO")
		name = self.match("VARIABLE")
		if self._debug: print("         Checking for optSequence.")
		params = self.optSequence()
		if self._debug: print("         about to match colon.")
		self.match("COLON")
		body = self.block()
		tmp = Lexeme(tokenType="GLUE", left=params, right=body)
		tree = Lexeme(tokenType="FUNCTION_DEF", left=name, right=tmp)

		return tree

	def optSequence(self):
		if self._debug: print(" in optSequence")
		tree = None  # may be better to make this an empty LIST lexeme. not sure...
		if self.sequencePending():
			if self._debug: print("Sequence was pending.")
			tree = self.sequence()
		if self._debug: print("         done with optSequence")

		return tree

	def sequence(self):
		if self._debug: print(" in sequence")
		tree = Lexeme(tokenType="LIST")
		tree.left = self.expression()
		if self.check("AND"):
			self.match("AND")
			tmp = Lexeme(tokenType="GLUE")
			tmp.left = self.expression()
			tree.right = tmp
		elif self.commaChainPending():
			tmp = self.commaChain()
			self.match("AND")
			tracer = tmp
			while tracer.right:
				tracer = tracer.right
			tmp2 = Lexeme(tokenType="GLUE")
			tmp2.left = self.expression()
			tmp.rightChild = tmp2
			tree.right = tmp

		return tree

	def commaChain(self):
		if self._debug: print(" in commaChain")
		self.match("COMMA")
		tree = Lexeme(tokenType="GLUE")
		tree.left = self.expression()
		tree.right = self.optCommaChain()

		return tree

	def optCommaChain(self):
		if self._debug: print(" in optCommaChain")
		tree = None
		if self.check("COMMA"):
			tree = Lexeme(tokenType="GLUE")
			self.match("COMMA")
			if self.expressionPending():
				tree.left = self.expression()
				tree.right = self.optCommaChain()

		return tree

	def block(self):
		if self._debug: print(" in block")
		tree = self.optStatements()
		self.match("PERIOD")

		return tree

	def optStatements(self):
		if self._debug: print(" in optStatements")
		tree = None
		if self.statementsPending():
			tree = self.statements()

		return tree

	def statements(self):
		if self._debug: print(" in statements")
		tree = Lexeme(tokenType="STATEMENTS")
		tree.left = self.statement()
		tree.right = self.optStatements()

		return tree

	def statement(self):
		if self._debug: print(" in statement")
		if self.expressionPending():
			tree = self.expression()
			self.match("SEMICOLON")
		elif self.ifStatementPending():
			tree = self.ifStatement()
		elif self.whileStatementPending():
			tree = self.whileStatement()
		elif self.assignmentPending():
			tree = self.assignment()
		else:
			tree = self.match("TODO")

		return tree

	def ifStatement(self):
		if self._debug: print(" in ifStatement")
		self.match("IF")
		tree = Lexeme(tokenType="IF_STATEMENT")
		tmp = Lexeme(tokenType="GLUE")
		tree.left = self.booleanExpression()
		self.match("COMMA")
		tmp.left = self.block()
		tmp.right = self.optOtherwise()
		tree.right = tmp

		return tree

	def whileStatement(self):
		if self._debug: print(" in whileStatement")
		self.match("WHILE")
		tree = Lexeme(tokenType="IF_STATEMENT")
		tree.left = self.booleanExpression()
		self.match("COMMA")
		tree.right = self.block()

		return tree

	def booleanExpression(self):
		tree = Lexeme(tokenType="BOOLEAN_EXPRESSION")
		tmp = Lexeme(tokenType="GLUE")
		tmp.left = self.expression()
		self.match("IS")
		tree.left = self.boolOp()
		tmp.right = self.expression()
		tree.right = tmp

		return tree

	def optOtherwise(self):
		if self._debug: print(" in optOtherwise")
		tree = None
		if self.check("OTHERWISE"):
			self.match("OTHERWISE")
			self.match("COMMA")
			if self.ifStatementPending():
				tree = self.ifStatement()
			else:
				tree = self.block()

		return tree

	def assignment(self):
		if self._debug: print(" in assignment")
		self.match("SET")
		tree = self.match("VARIABLE")
		self.match("TO")
		tree.value = self.expression()
		self.match("SEMICOLON")

		return tree

	def expression(self):
		if self._debug: print(" in expression")
		if self.check("OPEN_PARENTHESIS"):
			self.match("OPEN_PARENTHESIS")
			tmp = self.expression()
			tree = self.operator()
			tree.right = self.expression()
			tree.left = tmp
			self.match("CLOSE_PARENTHESIS")
		elif self.primaryPending():
			tree = self.primary()
		elif self.functionCallPending():
			tree = self.functionCall()

		return tree

	def primary(self):
		if self._debug: print(" in primary")
		if self.check("VARIABLE"):
			tree = self.match("VARIABLE")
		elif self.check("INTEGER"):
			tree = self.match("INTEGER")
		elif self.check("STRING"):
			tree = self.match("STRING")
		elif self.check("NUMBER"):
			tree = self.match("NUMBER")
		elif self.check("NOTHING"):
			tree = self.match("NOTHING")
		elif self.check("BOOLEAN"):
			tree = self.match("BOOLEAN")

		return tree

	def functionCall(self):
		if self._debug: print(" in functionCall")
		self.match("CARROT")
		tree = self.match("VARIABLE")  # IDENTIFIER
		self.match("OPEN_PARENTHESIS")
		tree.left = self.optSequence()
		self.match("CLOSE_PARENTHESIS")
		tree.type = "FUNCTION_CALL"

		return tree

	def operator(self):
		if self._debug: print(" in operator")
		if self.check("PLUS"):
			tree = self.match("PLUS")
		elif self.check("MINUS"):
			tree = self.match("MINUS")
		elif self.check("DIVIDE"):
			tree = self.match("DIVIDE")
		else:
			tree = self.match("MULTIPLY")

		return tree

	def boolOp(self):
		if self.check("DOUBLE_EQUALS"):
			tree = self.match("DOUBLE_EQUALS")
		elif self.check("NOT_EQUAL"):
			tree = self.match("NOT_EQUAL")
		elif self.check("LESS_THAN"):
			tree = self.match("LESS_THAN")
		elif self.check("LESS_THAN_EQUAL"):
			tree = self.match("LESS_THAN_EQUAL")
		elif self.check("GREATER_THAN"):
			tree = self.match("GREATER_THAN")
		else:
			tree = self.match("GREATER_THAN_EQUAL")

		return tree

if __name__ == "__main__":
	p = Parser()
	p.parse()
