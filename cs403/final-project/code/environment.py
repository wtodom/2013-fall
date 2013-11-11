from collections import deque
from lexeme import Lexeme

class Environment:

	def __init__(self, parent_env=None):
		self.parent_env = parent_env
		self.env_list = deque()
		self.env_list.appendleft(self.create())

	def create(self):
		new_env = deque()
		new_env.append(deque())
		new_env.append(deque())
		return new_env

	def lookup(self, variable):
		for env in self.env_list:
			for i, var in enumerate(env[0]):
				if var == variable:
					return env[1][i]
		return None

	def update(self, variable, new_value):
		for env in self.env_list:
			for i, var in enumerate(env[0]):
				if var == variable:
					env[1][i] = new_value

	def insert(self, variable, value):
		self.env_list[0][0].appendleft(variable)
		self.env_list[0][1].appendleft(value)

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