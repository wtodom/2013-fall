from lexeme import Lexeme
from exceptions import UndefinedException

class Environment:

	def __init__(self, parent_env=None):
		self.parent_env = parent_env
		self.env_list = self.create()

	def create(self):
		return Lexeme(token_type="ENVIRONMENT", right=Lexeme(tokenType="ENVIRONMENT"))

	def lookup(self, variable, env_list):
		while env_list is not None:
			vars = env_list.left
			vals = env_list.right.left
			while vars is not None:
				if (sameVariable(variable, vars.left)):  # TODO: finish insert so I can figure this part out.
					return vals.left
				vars = vars.right
				vals = vals.right
			env_list = env_list.right.right

		raise UndefinedException(variable)

		# return None  # is this needed?

	def update(self, variable, new_value):
		# for env in self.env_list:
		# 	for i, var in enumerate(env[0]):
		# 		if var == variable:
		# 			env[1][i] = new_value
		pass

	def insert(self, variable, value):
		self.env_list = Lexeme(token_type="JOIN", left=variable, right=self.env_list)
		val = Lexeme(token_type="JOIN", left=value, right=self.env_list.right.left)
        # setCar(
        # 	envList,
        # 	cons(
        # 		JOIN,
        # 		variable,
        # 		car(envList)
        # 		)
        # 	)
        # setCar(
        # 	cdr(envList),
        # 	cons(
        # 		JOIN,
        # 		value,
        # 		cadr(envList)
        # 		)
        # 	)
		pass

	def extend(self, variables, values, parent):
		# new_env = deque()
		# new_env.append(deque(variables))
		# new_env.append(deque(values))
		# print(new_env)
		pass

e = Environment()
print("Inserting variable x with value 5...")
e.insert("x", 5)
print("Attempting to lookup the variable 'x'...")
print("x = " + str(e.lookup("x")))
# print(e.env_list)
# e.extend(["x", "y", "z", "w"], [1, 2, 3, 4], None)
# print(e.env_list)