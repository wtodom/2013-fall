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
		while self.currentChar == "~" or self.currentChar in self.whitespace:
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
			return Lexeme(tokenType="COMMA")
		elif self.currentChar == ":":
			return Lexeme(tokenType="COLON")
		elif self.currentChar == ";":
			return Lexeme(tokenType="SEMICOLON")
		elif self.currentChar == ".":
			return Lexeme(tokenType="PERIOD")
		elif self.currentChar == "^":
			return Lexeme(tokenType="CARROT")
		elif self.currentChar == "(":
			return Lexeme(tokenType="OPEN_PARENTHESIS")
		elif self.currentChar == ")":
			return Lexeme(tokenType="CLOSE_PARENTHESIS")
		elif self.currentChar == "[":
			return Lexeme(tokenType="OPEN_BRACKET")
		elif self.currentChar == "]":
			return Lexeme(tokenType="CLOSE_BRACKET")
		elif self.currentChar == "+":
			return Lexeme(tokenType="PLUS")
		elif self.currentChar == "-":
			return Lexeme(tokenType="MINUS")
		elif self.currentChar == "/":
			return Lexeme(tokenType="DIVIDE")
		elif self.currentChar == "*":
			return Lexeme(tokenType="MULTIPLY")
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
			return Lexeme(tokenType="LESS_THAN")
		elif op == ">":
			return Lexeme(tokenType="GREATER_THAN")
		elif op == "<=":
			return Lexeme(tokenType="LESS_THAN_EQUAL")
		elif op == ">=":
			return Lexeme(tokenType="GREATER_THAN_EQUAL")
		elif op == "!=":
			return Lexeme(tokenType="NOT_EQUAL")
		elif op == "==":
			return Lexeme(tokenType="DOUBLE_EQUALS")

	def get_variable(self): # and keywords
		var = ""
		while self.currentChar.isalpha():
			var += self.currentChar
			self.read_char()

		self.pushback()

		if var == "to":
			return Lexeme(tokenType="TO")
		elif var == "set":
			return Lexeme(tokenType="SET")
		elif var == "is":
			return Lexeme(tokenType="IS")
		elif var == "while":
			return Lexeme(tokenType="WHILE")
		elif var == "if":
			return Lexeme(tokenType="IF")
		elif var == "true":
			return Lexeme(tokenType="TRUE")
		elif var == "false":
			return Lexeme(tokenType="FALSE")
		elif var == "if":
			return Lexeme(tokenType="IF")
		elif var == "and":
			return Lexeme(tokenType="AND")
		elif var == "otherwise":
			return Lexeme(tokenType="OTHERWISE")
		else:
			return Lexeme(tokenType="VARIABLE", value=var)

	def get_number(self):
		num = ""
		while self.currentChar.isdigit():
			num += self.currentChar
			self.read_char()

		self.pushback()

		return Lexeme(tokenType="NUMBER", value=num)

	def get_string(self):
		self.read_char()
		string = ""
		while self.currentChar != "\"":
			string += self.currentChar
			self.read_char()

		return Lexeme(tokenType="STRING", value=string)
