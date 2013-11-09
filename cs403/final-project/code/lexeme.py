class Lexeme:
	"""Stores data about single tokens to be returned by the Lexer."""

	def __init__(self, tokenType=None, value=None, left=None, right=None):
		self.tokenType = tokenType
		self.value = value
		self.left = left
		self.right = right

	def __str__(self):
		if self.value is not None:
			return str(self.tokenType) + ": " + str(self.value)
		else:
			return str(self.tokenType)