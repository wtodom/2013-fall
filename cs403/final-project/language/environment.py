from lexeme import Lexeme
from exceptions import UndefinedException
from treeviz import TreeViz

class Environment:

	def __init__(self):
		self._debug = False
		self.env_list = self.create()

	def create(self):
		return self.extend(None, None, None)

	def lookup(self, variable, env_list):
		"""
		Returns the value of a variable if defined, None otherwise.

		Parameters:
			variable -- A VARIABLE type Lexeme object with the variable's
						name as its value.
			env_list -- The Environment list into which to begin the
						the variable.
		"""
		if self._debug: print("Looking up -> " + str(variable))
		head = env_list.left
		while head is not None:
			var = head.left
			val = head.right
			while var is not None:
				if var.value == variable.value:
					return val.value
				var = var.right
				val = val.right
			head = head.right

		return None

	def update(self, variable, new_val, env_list):
		"""
		Updates the value of an existing variable in
		the specified environment to new_val.

		Parameters:
			variable -- A VARIABLE type Lexeme object with the variable's
						name as its value.

			new_val  -- A NUMBER, BOOLEAN, or STRING type Lexeme object
						with the variable's value as its value.

			env_list -- The Environment list in which to update
						the variable.
		"""
		if self._debug: print(str(variable))
		if self._debug: print(str(new_val))
		head = env_list.left
		var = head.left
		val = head.right
		while var:
			if var.value == variable.value:
				val.value = new_val.value
				return
			var = var.right
			val = val.right

		raise UndefinedException(str(variable) + " is undefined.")
		return None

	def insert(self, variable, value, env_list):
		"""
		Inserts a new variable with the specified value
		into the specified environment.

		Parameters:
			variable -- A VARIABLE type Lexeme object with the variable's
						name as its value.

			value 	 -- A NUMBER, BOOLEAN, or STRING type Lexeme object
						with the variable's value as its value.

			env_list -- The Environment list into which to insert
						the variable.
		"""
		if self._debug: print(
			"Inserting variable [" + str(variable) + "]")
		if self._debug: print(
			"        with value [" + str(value) + "].")
		head = env_list.left
		variable.right = head.left
		value.right = head.right
		head.left = variable
		head.right = value

	def extend(self, variables, values, parent_env):
		"""
		Inserts a new variable with the specified value
		into the specified environment.

		Parameters:
			variables 	-- The first Lexeme in a chain of VARIABLE
						   Lexemes that should be in the new
						   environment.

			values 		-- The first Lexeme in a chain of NUMBER, STRING,
					  	   and BOOLEAN Lexemes that should be in the new
					  	   environment.

			parent_env 	-- The Environment list that the new environment
						   should be attached to.
		"""
		if self._debug: print("In extend().")
		glue = Lexeme(token_type="GLUE", left=variables, right=values)
		env = Lexeme(token_type="ENVIRONMENT", left=glue, right=parent_env)

		return env


if __name__ == '__main__':

	e = Environment()
	env = e.env_list
	# tv = TreeViz("env_pre", env)
	# tv.viz()
	# tv.create_image()
	# tv.open_image()

	print("Inserting variable x with value 5...")
	var = Lexeme(token_type="VARIABLE", value="x")
	val = Lexeme(token_type="NUMBER", value=5)
	e.insert(var, val, env)
	# tv = TreeViz("env_post", env)
	# tv.viz()
	# tv.create_image()
	# tv.open_image()

	print("Attempting to lookup the variable 'x'...")
	print("x = " + str(e.lookup(var, env)))


	print("Updating x to value: 999...")
	e.update(var, 999, env)

	print("Attempting to lookup the variable 'x' after update...")
	print("x = " + str(e.lookup(var, env)))