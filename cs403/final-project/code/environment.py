from lexeme import Lexeme

class Environment:

	def __init__(self):
		self.envList = self.create()

	def create(self):
		# maybe one of these:
			# [[[],[]]]
			# Lexeme(token_type="ENVIRONMENT", right=Lexeme(token_type="ENVIRONMENT"))
		pass

	def lookup(self, variable, env_list):
		pass

	def update(self, variable, new_value, env_list):
		pass

	def insert(self, variable, value, env_list):
		pass

	def extend(self, variables, values, env_list):
		pass
