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
		tracer = env_list
		while tracer is not None:
			head = tracer.left
			var = head.left
			val = head.right
			while var is not None:
				if var.left.value == variable.value:
					return val.left
				var = var.right
				val = val.right
			tracer = tracer.right
		raise UndefinedException(str(variable))

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
		tracer = env_list
		while tracer is not None:
			head = tracer.left
			var = head.left
			val = head.right
			while var:
				if var.left.value == variable.value:
					val.left.value = new_val.value
					val.left.token_type = new_val.token_type
					return
				var = var.right
				val = val.right
			tracer = tracer.right

		raise UndefinedException(str(variable) + " is undefined.")
		# return None

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

		var_glue = Lexeme(token_type="GLUE", left=variable)
		val_glue = Lexeme(token_type="GLUE", left=value)

		head = env_list.left
		var_glue.right = head.left
		val_glue.right = head.right
		head.left = var_glue
		head.right = val_glue

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
		head = Lexeme(token_type="GLUE", left=variables, right = values)
		env = Lexeme(token_type="ENVIRONMENT", left=head, right=parent_env)

		return env