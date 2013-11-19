from lexeme import Lexeme

class Lexer:
	"""Scans files and returns a Lexeme object for each token discovered."""

	def __init__(self, source):
		self.f = self.open_file(source)
		self.pushbackStack = []
		self.currentChar = None
		self.boolean_symbols = ["<", ">", "!", "="]
		self.keywords = ["set", "to", "is", "return", "true", "false"]
		self.whitespace_chars = [" ", "\n", "\t", "\r"]
		self.connectors = ["-", "_"]

	def open_file(self, source):
		return open(source, "r")

	def close_file(self):
		self.f.close()

	def read_char(self):
		if len(self.pushbackStack) != 0:
			self.currentChar = self.pushbackStack.pop()
		else:
			self.currentChar = self.f.read(1).lower()

	def skip_whitespace(self):
		while self.currentChar == "~" or self.currentChar in self.whitespace_chars:
			while self.currentChar in self.whitespace_chars:
				self.read_char()
			if self.currentChar == "~":
				self.read_char()
				while self.currentChar != "~":
					self.read_char()
				self.read_char()

	def pushback(self):
		self.pushbackStack.append(self.currentChar)

	def lex(self):
		self.read_char()
		self.skip_whitespace()

		if self.currentChar == ",":
			return Lexeme(token_type="COMMA")
		elif self.currentChar == ":":
			return Lexeme(token_type="COLON")
		elif self.currentChar == ";":
			return Lexeme(token_type="SEMICOLON")
		elif self.currentChar == ".":
			return Lexeme(token_type="PERIOD")
		elif self.currentChar == "^":
			return Lexeme(token_type="CARROT")
		elif self.currentChar == "(":
			return Lexeme(token_type="OPEN_PARENTHESIS")
		elif self.currentChar == ")":
			return Lexeme(token_type="CLOSE_PARENTHESIS")
		elif self.currentChar == "[":
			return Lexeme(token_type="OPEN_BRACKET")
		elif self.currentChar == "]":
			return Lexeme(token_type="CLOSE_BRACKET")
		elif self.currentChar == "+":
			return Lexeme(token_type="PLUS")
		elif self.currentChar == "-":
			return Lexeme(token_type="MINUS")
		elif self.currentChar == "/":
			return Lexeme(token_type="DIVIDE")
		elif self.currentChar == "*":
			return Lexeme(token_type="MULTIPLY")
		else:
			return self.lex_variable()

	def lex_variable(self):
		if self.currentChar.isalpha():
			return self.get_variable()
		elif self.currentChar.isdigit():
			return self.get_number()
		elif self.currentChar == "\"":
			return self.get_string()
		elif self.currentChar in self.boolean_symbols:
			return self.get_boolean_operator()
		elif self.currentChar == "":
			return Lexeme("EOF")

	def get_boolean_operator(self):
		op = ""
		while self.currentChar in self.boolean_symbols and len(op) <= 2:
			op += self.currentChar
			self.read_char()

		if op == "<":
			return Lexeme(token_type="LESS_THAN")
		elif op == ">":
			return Lexeme(token_type="GREATER_THAN")
		elif op == "<=":
			return Lexeme(token_type="LESS_THAN_EQUAL")
		elif op == ">=":
			return Lexeme(token_type="GREATER_THAN_EQUAL")
		elif op == "!=":
			return Lexeme(token_type="NOT_EQUAL")
		elif op == "==":
			return Lexeme(token_type="DOUBLE_EQUALS")

	def get_variable(self): # and keywords
		var = ""
		while (
			self.currentChar.isalpha() or
			self.currentChar in self.connectors
			):
			var += self.currentChar
			self.read_char()

		self.pushback()

		if var == "to":
			return Lexeme(token_type="TO", value="KEYWORD")
		elif var == "set":
			return Lexeme(token_type="SET", value="KEYWORD")
		elif var == "is":
			return Lexeme(token_type="IS", value="KEYWORD")
		elif var == "while":
			return Lexeme(token_type="WHILE", value="KEYWORD")
		elif var == "if":
			return Lexeme(token_type="IF", value="KEYWORD")
		elif var == "true":
			return Lexeme(token_type="BOOLEAN", value=True)
		elif var == "false":
			return Lexeme(token_type="BOOLEAN", value=False)
		elif var == "or":
			return Lexeme(token_type="OR", value="KEYWORD")
		elif var == "and":
			return Lexeme(token_type="AND", value="KEYWORD")
		elif var == "otherwise":
			return Lexeme(token_type="OTHERWISE", value="KEYWORD")
		elif var == "nothing":
			return Lexeme(token_type="NOTHING", value=None)
		elif var == "show":
			return Lexeme(token_type="SHOW", value=None)
		else:
			return Lexeme(token_type="VARIABLE", value=var)

	def get_number(self):
		num = ""
		while self.currentChar.isdigit():
			num += self.currentChar
			self.read_char()

		self.pushback()

		return Lexeme(token_type="NUMBER", value=int(num))

	def get_string(self):
		self.read_char()
		string = ""
		while self.currentChar != "\"":
			string += self.currentChar
			self.read_char()

		return Lexeme(token_type="STRING", value=string)
