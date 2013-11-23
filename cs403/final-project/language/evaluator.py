from environment import Environment
from exceptions import EvaluationException, TypeException, UndefinedException
from parser import Parser
from lexer import Lexer, Lexeme
from treeviz import TreeViz
import sys


class Evaluator:

	def __init__(self):
		self._debug = False
		self.base_env = Environment()

	def eval(self, tree, env):
		t = tree.token_type
		if t == "SHOW":
			return self.eval_show(tree, env)
		elif t == "NUMBER":
			return tree.value
		elif t == "STRING":
			return tree.value
		elif t == "BOOLEAN":
			return tree.value
		elif t == "VARIABLE":
			return self.base_env.lookup(tree, env)
		elif t == "PLUS":
			return self.eval_plus(tree, env)
		elif t == "MINUS":
			return self.eval_minus(tree, env)
		elif t == "DIVIDE":
			return self.eval_divide(tree, env)
		elif t == "MULTIPLY":
			return self.eval_multiply(tree, env)
		elif t == "STATEMENTS":
			return self.eval_statements(tree, env)
		elif t == "BOOLEAN_EXPRESSION":
			return self.eval_boolean_expression(tree, env)
		elif t == "ASSIGNMENT":
			return self.eval_assignment(tree, env)
		elif t == "FUNCTION_DEF":
			return self.eval_function_def(tree, env)
		elif t == "IF_STATEMENT":
			return self.eval_if_statement(tree, env)
		elif t == "WHILE_STATEMENT":
			return self.eval_while_statement(tree, env)
		elif t == "FUNCTION_CALL":
			return self.eval_function_call(tree, env)
		elif t == "PROGRAM":
			# this may need adjustment depending on how various trees look.
			self.eval(tree.right.left, env)
			if tree.right.right.left:
				self.eval(tree.right.right.left, env)
		else:
			raise EvaluationException(tree)

	def eval_show(self, tree, env):
		### This doesn't work, but it's kind what I'm thinking.
		### I only want to print literal values, not Lexemes.
		### Will figure it out later.
		# var = tree.left
		# while (
		# 	type(var) is Lexeme and
		# 	var.token_type != "NUMBER" and
		# 	var.token_type != "STRING" and
		# 	var.token_type != "BOOLEAN"
		# 	):
		# 	var = self.eval(var, env)

		### This version gives rudimentary printing.
		print(self.eval(tree.left, env))

	def reduce_to_literals(self, tree, env):
		"""
		Returns a tuple containing the literals represented
		by the parse tree.
		"""
		left = tree.left
		right = tree.right
		if self._debug: print("Left,  pre eval:  " + str(left))
		if self._debug: print("Right, pre eval:  " + str(right))

		# assumes integers.
		while not (isinstance(left, int) or isinstance(left, str)):
			left = self.eval(left, env)
		while not (isinstance(right, int) or isinstance(right, str)):
			right = self.eval(right, env)

		if self._debug: print("Left,  post eval: " + str(left))
		if self._debug: print("Right, post eval: " + str(right))

		return (left, right)

	### todo: Add type checks, Lexeme type setting, and throw appropriate exceptions
	def eval_plus(self, tree, env):
		(left, right) = self.reduce_to_literals(tree, env)
		added = left + right
		return Lexeme(token_type="NUMBER", value=added)

	def eval_minus(self, tree, env):
		(left, right) = self.reduce_to_literals(tree, env)
		difference = left - right
		return Lexeme(token_type="NUMBER", value=difference)

	def eval_multiply(self, tree, env):
		(left, right) = self.reduce_to_literals(tree, env)
		product = left * right
		return Lexeme(token_type="NUMBER", value=product)

	def eval_divide(self, tree, env):
		(left, right) = self.reduce_to_literals(tree, env)
		# integer division since i'm not implementing reals
		quotient = left // right
		return Lexeme(token_type="NUMBER", value=quotient)

	def eval_statements(self, tree, env):
		### original, working, non-return version:
		# while tree:
		# 	self.eval(tree.left, env)
		# 	tree = tree.right
		return_statment = tree.left.left
		while tree:
			self.eval(tree.left.right, env)
			tree = tree.right
		if return_statment is not None:
			return self.eval_return_statement(return_statment, env)

	def eval_return_statement(self, tree, env):
		return self.eval(tree, env)

	def eval_boolean_expression(self, tree, env):
		op = tree.left.token_type
		left = tree.right.left
		right = tree.right.right

		# make sure they're either number or variable Lexemes
		if (left.token_type != "NUMBER" and
			left.token_type != "VARIABLE" and
			right.token_type != "NUMBER" and
			right.token_type != "VARIABLE"
			):
			raise TypeException(
				[left.token_type, right.token_type],
				["Lexeme: NUMBER", "Lexeme: NUMBER"]
				)

		# reduce them down to literals
		while not self.is_literal(left):
			left = self.eval(left, env)
		while not self.is_literal(right):
			right = self.eval(right, env)

		# make sure those literals are ints
		if not isinstance(left, int) or not isinstance(right, int):
			raise TypeException(
				[type(left), type(right)],
				["Lexeme: NUMBER", "Lexeme: NUMBER"]
				)

		# compare
		if op == "LESS_THAN":
			return left < right

		elif op == "GREATER_THAN":
			return left > right

		elif op == "LESS_THAN_EQUAL":
			return left <= right

		elif op == "GREATER_THAN_EQUAL":
			return left >= right

		elif op == "NOT_EQUAL":
			return left != right

		elif op == "DOUBLE_EQUALS":
			return left == right

	def is_literal(self, thing):
		return (
			isinstance(thing, int) or
			isinstance(thing, str) or
			isinstance(thing, bool)
			)

	def eval_assignment(self, tree, env):
		var = tree.left
		val = tree.right
		if (val.token_type != "NUMBER" and
			val.token_type != "BOOLEAN" and
			val.token_type != "STRING"
			):
			val = self.eval(tree.right, env)
		try:
			self.base_env.lookup(var, env)
			if self._debug: print("Updating " + str(var) + " to " + str(val))
			self.base_env.update(var, val, env)
		except UndefinedException:
			if self._debug: print("Inserting " + str(var) + " with value " + str(val))
			self.base_env.insert(var, val, env)

	def eval_if_statement(self, tree, env):
		if self.eval(tree.left, env):
			self.eval(tree.right.left, env)
		elif tree.right.right:
			self.eval(tree.right.right, env)

	def eval_while_statement(self, tree, env):
		while self.eval(tree.left, env):
			self.eval(tree.right, env)

	def eval_function_def(self, tree, env):
		closure = Lexeme(token_type="CLOSURE", left=env, right=tree)
		self.base_env.insert(self.get_function_def_name(tree), closure, env)
		### closure definitely exists here. uncomment viz code to see it.

	def eval_function_call(self, tree, env):
		### check tree.token_type here to catch built-ins first.
		if tree.value == "new_array":
			return self.eval_builtin(tree, env)

		closure = self.eval(self.get_function_call_name(tree), env)
		args = self.get_func_call_args(tree)
		params = self.get_closure_params(closure)
		body = self.get_closure_body(closure)
		senv = self.get_closure_environment(closure)
		eargs = self.eval_args(args, env)
		xenv = self.base_env.extend(params, eargs, senv)
		return self.eval(body, xenv)

	def get_function_def_name(self, tree):
		return tree.left

	def get_function_call_name(self, tree):
		return Lexeme(token_type="VARIABLE", value=tree.value)

	def get_func_call_args(self, tree):
		return tree.left

	def get_closure_params(self, closure):
		return closure.right.right.left

	def get_closure_body(self, closure):
		return closure.right.right.right

	def get_closure_environment(self, closure):
		return closure.left

	def eval_args(self, args, env):
		head = args
		while head is not None:
			if head.left.token_type != "NUMBER" and head.left.token_type != "BOOLEAN":
				head.left = self.eval(head.left, env)
			head = head.right

		return args

	def add_builtins(self, env):
		self.add_array_constructor(env)

	def add_array_constructor(self, env):
		arg = Lexeme(token_type="VARIABLE", value="size")
		params = Lexeme(token_type="GLUE", left=arg)
		name = Lexeme(token_type="VARIABLE", value="new_array")
		tmp = Lexeme(token_type="GLUE", left=params)
		tree = Lexeme(token_type="BUILT-IN", value="new_array", left=name, right=tmp)

		### this probably won't work
		self.base_env.insert(tree, tree, env)

	def eval_builtin(self, closure, env):
		if closure.value == "new_array":
			array = [None] * closure.left.left.value
			return Lexeme(token_type="ARRAY", value=array)


if __name__ == '__main__':

	if len(sys.argv) != 2:
		sys.exit("Usage: python3 evaluator.py sourceFile")

	e = Evaluator()
	env = e.base_env.env_list
	e.add_builtins(env)
	p = Parser()
	p.l = Lexer(sys.argv[1])
	t = p.parse()
	# tv = TreeViz("test", t)
	# tv.viz()
	# tv.create_image()
	# tv.open_image()
	e.eval(t, env)
