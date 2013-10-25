from lexeme import Lexeme

class Lexer:
	"""Scans files and returns a Lexeme object for each token discovered."""

	def __init__(self, source):
		self.f = self.open_file(source)	
		self.pushbackStack = []
		self.currentChar = None
		self.keywords = ["set", "to", "is", "return", "true", "false"]

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
		while self.currentChar in [" ", "\n", "\t", "\r"]:
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
		elif self.currentChar == "(":
			return Lexeme(tokenType="OPEN_PAREN")
		elif self.currentChar == ")":
			return Lexeme(tokenType="CLOSE_PAREN")
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
		if self.currentChar == None:
			return
		if self.currentChar.isalpha():
			return self.get_variable()
		elif self.currentChar.isdigit():
			return self.get_number()
		elif self.currentChar == "\"":
			return self.get_string()

	def get_variable(self): # and keywords
		var = ""
		while self.currentChar.isalpha():
			var += self.currentChar
			self.read_char()

		self.pushback()

		if var == "to":
			return Lexeme(tokenType="TO", value="to")
		elif var == "set":
			return Lexeme(tokenType="SET", value="set")
		elif var == "is":
			return Lexeme(tokenType="IS", value="is")
		elif var == "while":
			return Lexeme(tokenType="WHILE", value="while")
		elif var == "if":
			return Lexeme(tokenType="IF", value="if")
		elif var == "true":
			return Lexeme(tokenType="TRUE", value="true")
		elif var == "false":
			return Lexeme(tokenType="FALSE", value="false")
		elif var == "if":
			return Lexeme(tokenType="IF", value="if")
		elif var == "if":
			return Lexeme(tokenType="IF", value="if")
		else:
			return Lexeme(tokenType="VARIABLE", value=var)
		# todo: check for keywords
		# todo: check for inequality symbols

	def get_number(self):
		num = ""
		while self.currentChar.isdigit():
			num += self.currentChar
			self.read_char()

		self.pushback()

		return Lexeme(tokenType="Number", value=num)

	def get_string(self):
		self.read_char()
		string = ""
		while self.currentChar != "\"":
			string += self.currentChar
			self.read_char()

		return Lexeme(tokenType="STRING", value=string)
