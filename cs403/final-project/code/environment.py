from lexeme import Lexeme
from exceptions import UndefinedException
from treeviz import TreeViz

class Environment:

	def __init__(self):
		self.env_list = self.create()

	def create(self):
		return self.extend(None, None, None)

	def lookup(self, variable, env_list):
		head = env_list.left
		var = head.left
		val = head.right
		while var != None:
			if var.value == variable.value:
				return val.value
			var = var.right
			val = val.right

		return None

	def update(self, variable, new_value, env_list):
		head = env_list.left
		var = head.right
		val = head.right
		while var != None:
			if var.value == variable:
				val.value = new_value
			var = var.right
			val = val.right

		raise UndefinedException(variable)
		return None

	def insert(self, variable, value, env_list):
		head = env_list.left
		variable.right = head.left
		value.right = head.right
		head.left = variable
		head.right = value

	def extend(self, variables, values, parent):
		glue = Lexeme(token_type="GLUE", left=variables, right=values)
		env = Lexeme(token_type="ENVIRONMENT", left=glue, right=parent)

		return env


if __name__ == '__main__':

	e = Environment()
	# tv = TreeViz("env_pre", e.env_list)
	# tv.viz()
	# tv.create_image()
	# tv.open_image()

	print("Inserting variable x with value 5...")
	var = Lexeme(token_type="VARIABLE", value="x")
	val = Lexeme(token_type="NUMBER", value=5)
	e.insert(var, val, e.env_list)
	# tv = TreeViz("env_post", e.env_list)
	# tv.viz()
	# tv.create_image()
	# tv.open_image()

	print("Attempting to lookup the variable 'x'...")
	print("x = " + str(e.lookup("x", e.env_list)))

