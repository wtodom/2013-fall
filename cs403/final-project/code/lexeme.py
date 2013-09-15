class Lexeme:
	"""Stores data about single tokens to be returned by the Lexer."""
	
	def __init__(self, tokenType, partOfSpeech):
		self.tokenType = tokenType
		self.partOfSpeech = partOfSpeech