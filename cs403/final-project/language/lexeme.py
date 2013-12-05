class Lexeme:
	"""Stores data about single tokens to be returned by the Lexer."""

	def __init__(self, token_type=None, value=None, left=None, right=None):
		self.token_type = token_type
		self.value = value
		self.left = left
		self.right = right

	def __str__(self):
		# if self.value is not None:
		# 	return str(self.token_type) + ": " + str(self.value)
		# else:
		# 	return str(self.token_type)
		return str(self.token_type) + ": " + str(self.value)

	def __eq__(self, other):
		"""
		Returns True if all properties are equal, False otherwise.
		"""
		return (
			self.token_type == other.token_type and
			self.value == other.value and
			self.left == other.left and
			self.right == other.right
		)
