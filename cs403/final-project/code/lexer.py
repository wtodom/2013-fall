class Lexer:
	"""Scans files and returns a Lexeme object for each token discovered."""

	def __init__(self, source):
		self.f = self.openFile(source)	
		self.pushbackStack = []
		self.currentChar = self.readChar()

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
			self.lexVariable()
			# print(self.currentChar)

		self.readChar()

	def lexVariable(self):
		if self.currentChar == None:
			return
		if self.currentChar.isalpha():
			self.getVariable()
		elif self.currentChar.isdigit():
			self.getNumber()
		elif self.currentChar == "\"":
			self.getString()

	def getVariable(self): # and keywords
		var = ""
		while self.currentChar.isalpha():
			var += self.currentChar
			self.readChar()

		print(var)
		# todo: check for keywords
		# todo: check for inequality symbols

	def getNumber(self):
		num = ""
		while self.currentChar.isdigit():
			num += self.currentChar
			self.readChar()
		# return Lexeme(NUMBER, int(num))
		print(int(num))

	def getString(self):
		string = ""
		while self.currentChar != "\"":
			string += self.currentChar
			self.readChar()
		# return Lexeme(STRING, string[1:])
		print(string)
