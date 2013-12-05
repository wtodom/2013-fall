from exceptions import ParseError
from lexeme import Lexeme
from lexer import Lexer
from treeviz import TreeViz
import sys


class Parser:


	def __init__(self):
		self._debug = False
		self.current = None
		self.old = None
		self.l = self.setup()

	def setup(self):
		if len(sys.argv) != 2:
			sys.exit("Usage: python3 parser.py sourceFile")
		return Lexer(sys.argv[1])

	def parse(self):
		self.current = self.l.lex()
		tree = self.program()
		self.l.close_file()
		if self._debug: print()
		if self._debug: print("###############################")
		if self._debug: print("### Parsing was successful. ###")
		if self._debug: print("###############################")
		# v = tv.TreeViz(sys.argv[-1][18:-5], tree)
		# v.viz()
		# v.create_image()
		# v.open_image()

		return tree

	def check(self, token_type):
		return self.current.token_type == token_type

	def match(self, token_type):
		if self._debug: print("Attempting to match Lexeme: " + str(self.current))
		if not self.check(token_type):
			raise ParseError(token_type, self.current.token_type)
		if self._debug: print("token matched.")
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
			self.check("OPEN_PARENTHESIS") or
			self.check("SHOW")
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
		return self.expressionPending()

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

	def returnPending(self):
		if self._debug: print(" in returnPending")
		return self.check("RETURN")

	def program(self):
		if self._debug: print(" in program")
		tree = Lexeme(token_type="PROGRAM")
		sections = []
		while self.functionDefPending() or self.statementsPending():
			if self.functionDefPending():
				sections.append(self.functionDef())
			if self.statementsPending():
				sections.append(self.statements())
		self.match("EOF")
		tmp = Lexeme(token_type="GLUE")
		tracer = tmp
		for section in sections:
			tracer.left = section
			tracer.right = Lexeme(token_type="GLUE")
			tracer = tracer.right
		tree.right = tmp

		return tree

	def functionDef(self):
		if self._debug: print(" in functionDef")
		self.match("TO")
		name = self.match("VARIABLE")
		if self._debug: print("         Checking for optSequence.")
		params = self.optSequence()
		if self._debug: print("         about to match colon.")
		self.match("COLON")
		body = self.block()
		tmp = Lexeme(token_type="GLUE", left=params, right=body)
		tree = Lexeme(token_type="FUNCTION_DEF", left=name, right=tmp)

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
		tree = Lexeme(token_type="GLUE")  # this will be attached to the "head" in my environment
		tree.left = self.expression()
		if self.check("AND"):
			self.match("AND")
			tmp = Lexeme(token_type="GLUE")
			tmp.left = self.expression()
			tree.right = tmp
		elif self.commaChainPending():
			tmp = self.commaChain()
			self.match("AND")
			tracer = tmp
			while tracer.right:
				tracer = tracer.right
			tracer.left = self.expression()
			tree.right = tmp

		return tree

	def commaChain(self):
		if self._debug: print(" in commaChain")
		self.match("COMMA")
		tree = Lexeme(token_type="GLUE")
		tree.left = self.expression()
		tree.right = self.optCommaChain()

		return tree

	def optCommaChain(self):
		if self._debug: print(" in optCommaChain")
		tree = None
		if self.check("COMMA"):
			tree = Lexeme(token_type="GLUE")
			self.match("COMMA")
			if self.expressionPending():
				tree.left = self.expression()
				tree.right = self.optCommaChain()

		return tree

	def block(self):
		if self._debug: print(" in block")
		tree = self.optStatements()
		### todo: this may be wrong
		if tree is not None:
			tree.left.left = self.optReturn()
		else:
			tree = self.optReturn()
		self.match("HASH")

		return tree

	def optReturn(self):
		if self._debug: print(" in optReturn")
		if self.returnPending():
			self.match("RETURN")
			tree = self.expression()
			self.match("PERIOD")
			return tree
		return None

	def optStatements(self):
		if self._debug: print(" in optStatements")
		tree = None
		if self.statementsPending():
			tree = self.statements()

		return tree

	def statements(self):
		if self._debug: print(" in statements")
		tree = Lexeme(token_type="STATEMENTS")
		tree.left = Lexeme(token_type="GLUE")
		tree.left.right = self.statement()
		tree.right = self.optStatements()

		return tree

	def statement(self):
		if self._debug: print(" in statement")
		if self.expressionPending():
			tree = self.expression()
			self.match("PERIOD")
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
		tree = Lexeme(token_type="IF_STATEMENT")
		tmp = Lexeme(token_type="GLUE")
		tree.left = self.booleanExpression()
		self.match("COMMA")
		tmp.left = self.block()
		tmp.right = self.optOtherwise()
		tree.right = tmp

		return tree

	def whileStatement(self):
		if self._debug: print(" in whileStatement")
		self.match("WHILE")
		tree = Lexeme(token_type="WHILE_STATEMENT")
		tree.left = self.booleanExpression()
		self.match("COMMA")
		tree.right = self.block()

		return tree

	def booleanExpression(self):
		tree = Lexeme(token_type="BOOLEAN_EXPRESSION")
		tmp = Lexeme(token_type="GLUE")
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
		tree = Lexeme(token_type="ASSIGNMENT")
		tree.left = self.match("VARIABLE")
		self.match("TO")
		tree.right = self.expression()
		self.match("PERIOD")

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
		else:  # show is pending
			tree = self.show()

		return tree

	def show(self):
		tree = self.match("SHOW")
		tree.left = self.expression()

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
		tree.token_type = "FUNCTION_CALL"

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
