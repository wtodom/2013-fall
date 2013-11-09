class Error(Exception):
	"""Base class for exceptions in this module."""
	pass

class ParseError(Error):
	"""
	Raised when the parser fails to match a type specified
	in the grammar.

	Attributes:
		typeExpected -- the token type the parser attempted to match
		typeFound -- the token type found by the parser
	"""

	def __init__(self, expected, found):
		self.expected = expected
		self.found = found
