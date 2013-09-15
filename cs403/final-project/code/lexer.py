class Lexer:
	"""Scans files and returns a Lexeme object for each token discovered."""

	def __init__(self, source):
		self.f = self.openFile(source)	
		self.currentChar = None
		self.pushbackStack = []

	def openFile(self, source):
		return open(source, "r")

	def closeFile(self):
		self.f.close()

	def readChar(self):
		if len(self.pushbackStack) != 0:
			self.currentChar = self.pushbackStack.pop()
		else:
			self.currentChar = self.f.read(1).lower()

	def skipWhitespace(self):
		while self.currentChar in [" ", "\n", "\t", "\r"]:
			print(" ")
			self.readChar()

	def pushback(self):
		self.pushbackStack.append(self.currentChar)

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
			# return Lexeme(PERIOD)
			print("PERIOD")
		elif self.currentChar == "(":
			# return Lexeme(OPEN_PAREN)
			print("OPEN_PAREN")
		elif self.currentChar == ")":
			# return Lexeme(CLOSE_PAREN)
			print("CLOSE_PAREN")
		elif self.currentChar == "[":
			# return Lexeme(OPEN_BRACKET)
			print("OPEN_BRACKET")
		elif self.currentChar == "]":
			# return Lexeme(CLOSE_BRACKET)
			print("CLOSE_BRACKET")
		elif self.currentChar == "+":
			# return Lexeme(PLUS)
			print("PLUS")
		elif self.currentChar == "-":
			# return Lexeme(MINUS)
			print("MINUS")
		elif self.currentChar == "/":
			# return Lexeme(DIVIDE)
			print("DIVIDE")
		elif self.currentChar == "*":
			# return Lexeme(MULTIPLY)
			print("MULTIPLY")
		else:
			# return self.lexVariable()
			print(self.currentChar)

		self.readChar()

	def lexVariable(self):
		if self.currentChar.isalpha():
			self.pushback()
			return self.getVariable()
		elif self.currentChar.isdigit():
			self.pushback()
			return self.getNumber()
		elif self.currentChar == "\"":
			self.pushback()
			return self.getString()

	def getVariable(self): # and keywords
		pass

	def getNumber(self):
		pass

	def getString(self):
		pass
