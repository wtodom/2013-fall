class Lexeme:
	"""Stores data about single tokens to be returned by the Lexer."""
	
	def __init__(self, tokenType=None, value=None, leftChild=None, rightChild=None):
		self.tokenType = tokenType
		self.value = value
		self.left = leftChild
		self.right = rightChild

	def __str__(self):
		if self.value is not None:
			return self.tokenType + ": " + self.value
		else:
			return self.tokenType