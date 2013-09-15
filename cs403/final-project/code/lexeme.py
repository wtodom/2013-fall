class Lexeme:
	"""Stores data about single tokens to be returned by the Lexer."""
	
	def __init__(self, tokenType, value):
		self.tokenType = tokenType
		self.value = value
