class Lexer:
	"""Scans files and returns a Lexeme object for each token discovered."""

	def __init__(self, inFile):
		self.f = inFile
