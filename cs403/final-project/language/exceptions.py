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

	def __str__(self):
		print("ParseError: Expected " + str(self.expected) + ", but found " + str(self.found))

class UndefinedException(Error):
	"""
	Raised when the a variable is referenced before it has been defined in
	the local or any parent scopes.

	Attributes:
		variable -- the name of the referenced variable
	"""

	def __init__(self, variable):
		self.variable = variable

class EvaluationException(Error):
	"""
	~Todo~

	Attributes:
		node_type -- the type of the referenced node
	"""

	def __init__(self, node_type):
		self.node_type = node_type

class TypeException(Error):
	"""
	~Todo~

	Attributes:
		node_type -- the type of the referenced node
	"""

	def __init__(self, types_received, types_expected):
		self.received = types_received
		self.expected = types_expected

	def __str__(self):
		msg = "Received type(s) {0} but expected {1}.".format(
			self.received,
			self.expected
			)
		return msg