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
			if var.value == variable:
				return val.value
			var = var.right
			val = val.right

		raise UndefinedException(variable)
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

	def __str__(self):
		root = []
		head = self.env_list.left
		while head:
			local = []
			var = head.left
			val = head.right
			while var:
				local.append([var.value, val.value])
				var = var.right
				val = val.right
			root.append(local)
			head = head.right

		return str(root)


if __name__ == '__main__':

	e = Environment()
	# tv = TreeViz("env", e.env_list)
	# tv.viz()
	# tv.create_image()
	# tv.open_image()

	print("Inserting variable x with value 5...")
	var = Lexeme(token_type="VARIABLE", value="x")
	val = Lexeme(token_type="NUMBER", value=5)
	e.insert(var, val, e.env_list)
	# tv = TreeViz("env", e.env_list)
	# tv.viz()
	# tv.create_image()
	# tv.open_image()

	print("Attempting to lookup the variable 'x'...")
	print("x = " + str(e.lookup("x", e.env_list)))

