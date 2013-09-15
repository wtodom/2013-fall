class Lexer:
	"""Scans files and returns a Lexeme object for each token discovered."""

	def __init__(self, source):
		self.f = self.openFile(source)	
		self.currentChar = None
		self.pushBack = []

	def openFile(self, source):
		return open(source, "r")

	def closeFile(self):
		self.f.close()

	def readChar(self):
		if len(self.pushBack) != 0:
			self.currentChar = self.pushBack.pop()
		else:
			self.currentChar = self.f.read(1)

	def skipWhitespace(self):
		while self.currentChar == " " or self.currentChar == "\n" or self.currentChar == "\t":
			print(" ")
			self.readChar()

	def lex(self):
		self.skipWhitespace()
		if self.currentChar == ",":
			# return Lexeme(COMMA)
			print("COMMA")
		elif self.currentChar == ":":
			# return Lexeme(COLON)
			print("COLON")
		elif self.currentChar == ";":
			# return Lexeme(SEMICOLON)
			print("SEMICOLON")
		elif self.currentChar == ".":
			# return Lexeme(SEMICOLON)
			print("PERIOD")
		elif self.currentChar == "(":
			# return Lexeme(SEMICOLON)
			print("OPEN_PAREN")
		elif self.currentChar == ")":
			# return Lexeme(SEMICOLON)
			print("CLOSE_PAREN")
		elif self.currentChar == "[":
			# return Lexeme(SEMICOLON)
			print("OPEN_BRACKET")
		elif self.currentChar == "]":
			# return Lexeme(SEMICOLON)
			print("CLOSE_BRACKET")
		elif self.currentChar == "+":
			# return Lexeme(SEMICOLON)
			print("PLUS")
		elif self.currentChar == "-":
			# return Lexeme(SEMICOLON)
			print("MINUS")
		elif self.currentChar == "/":
			# return Lexeme(SEMICOLON)
			print("DIVIDE")
		elif self.currentChar == "*":
			# return Lexeme(SEMICOLON)
			print("MULTIPLY")
		else:
			# return self.lexVariable()
			print(self.currentChar)

		self.readChar()

	def lexVariable(self):
		pass
