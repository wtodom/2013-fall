from environment import Environment
from exceptions import EvaluationException, UndefinedException
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
		else:
			raise EvaluationException(tree)

	def eval_show(self, tree, env):
		print(self.eval(tree.left, env))

	def eval_plus(self, tree, env):
		left = tree.left
		right = tree.right
		if self._debug: print("Left,  pre eval:  " + str(left))
		if self._debug: print("Right, pre eval:  " + str(right))

		lt = left.token_type
		rt = right.token_type
		if lt == "VARIABLE":
			left = self.base_env.lookup(left, env)
		else:
			left = self.eval(left, env)
		if rt == "VARIABLE":
			right = self.base_env.lookup(right, env)
		else:
			right = self.eval(right, env)

		if self._debug: print("Left,  post eval: " + str(left))
		if self._debug: print("Right, post eval: " + str(right))

		added = left + right
		return Lexeme(token_type="NUMBER", value=added)

	def eval_minus(self, tree, env):
		left = tree.left
		right = tree.right
		if self._debug: print("Left,  pre eval:  " + str(left))
		if self._debug: print("Right, pre eval:  " + str(right))

		lt = left.token_type
		rt = right.token_type
		if lt == "VARIABLE":
			left = self.base_env.lookup(left, env)
		else:
			left = self.eval(left, env)
		if rt == "VARIABLE":
			right = self.base_env.lookup(right, env)
		else:
			right = self.eval(right, env)

		if self._debug: print("Left,  post eval: " + str(left))
		if self._debug: print("Right, post eval: " + str(right))

		difference = left - right
		return Lexeme(token_type="NUMBER", value=difference)

	def eval_multiply(self, tree, env):
		left = tree.left
		right = tree.right
		if self._debug: print("Left,  pre eval:  " + str(left))
		if self._debug: print("Right, pre eval:  " + str(right))

		lt = left.token_type
		rt = right.token_type
		if lt == "VARIABLE":
			left = self.base_env.lookup(left, env)
		else:
			left = self.eval(left, env)
		if rt == "VARIABLE":
			right = self.base_env.lookup(right, env)
		else:
			right = self.eval(right, env)

		if self._debug: print("Left,  post eval: " + str(left))
		if self._debug: print("Right, post eval: " + str(right))

		product = left * right
		return Lexeme(token_type="NUMBER", value=product)

	def eval_divide(self, tree, env):
		left = tree.left
		right = tree.right
		if self._debug: print("Left,  pre eval:  " + str(left))
		if self._debug: print("Right, pre eval:  " + str(right))

		lt = left.token_type
		rt = right.token_type
		if lt == "VARIABLE":
			left = self.base_env.lookup(left, env)
		else:
			left = self.eval(left, env)
		if rt == "VARIABLE":
			right = self.base_env.lookup(right, env)
		else:
			right = self.eval(right, env)

		if self._debug: print("Left,  post eval: " + str(left))
		if self._debug: print("Right, post eval: " + str(right))

		# integer division since i'm not implementing reals
		quotient = left // right
		return Lexeme(token_type="NUMBER", value=quotient)

	def eval_statements(self, tree, env):
		while tree:
			self.eval(tree.left, env)
			tree = tree.right

	def eval_boolean_expression(self, tree, env):
		op = tree.left.token_type
		if op == "LESS_THAN":
			return self.eval(tree.right.left) < self.eval(tree.right.right)
		elif op == "GREATER_THAN":
			return self.eval(tree.right.left) > self.eval(tree.right.right)
		elif op == "LESS_THAN_EQUAL":
			return self.eval(tree.right.left) <= self.eval(tree.right.right)
		elif op == "GREATER_THAN_EQUAL":
			return self.eval(tree.right.left) >= self.eval(tree.right.right)
		elif op == "NOT_EQUAL":
			return self.eval(tree.right.left) != self.eval(tree.right.right)
		elif op == "DOUBLE_EQUALS":
			return self.eval(tree.right.left) == self.eval(tree.right.right)

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
		# if self.base_env.lookup(var, env) is not None:
		# else:


	def eval_if_statement(self, tree, env):
		# print(tree)
		# print(tree.left)
		# print(tree.right)
		if self.eval(tree.left, env):
			self.eval(tree.right.left, env)
		elif tree.right.right:
			self.eval(tree.right.right, env)

	def eval_while_statement(self, tree, env):
		pass

	def eval_function_def(self, tree, env):
		closure = Lexeme(token_type="CLOSURE", left=env, right=tree)
		self.base_env.insert(self.get_function_def_name(tree), closure, env)

	def eval_function_call(self, tree, env):
		closure = self.eval(self.get_function_call_name(tree), env)
		args = self.get_func_call_args(tree)
		params = self.get_closure_params(closure)
		body = self.get_closure_body(closure)
		senv = self.get_closure_environment(closure)
		eargs = self.eval_args(args, env)
		xenv = self.base_env.extend(senv, params, eargs)

		return eval(body, xenv)

	def get_function_def_name(self, tree):
		return tree.left

	def get_function_call_name(self, tree):
		return tree.value

	def get_func_call_args(self, tree):
		return tree.left

	def get_closure_params(self, closure):
		pass

	def get_closure_body(self, closure):
		pass

	def get_closure_environment(self, closure):
		pass

	def eval_args(self, args, env):
		pass

if __name__ == '__main__':

	if len(sys.argv) != 2:
		sys.exit("Usage: python3 evaluator.py sourceFile")

	e = Evaluator()
	env = e.base_env.env_list
	p = Parser()
	p.l = Lexer(sys.argv[1])
	t = p.parse().right
	# tv = TreeViz("test", t)
	# tv.viz()
	# tv.create_image()
	# tv.open_image()
	e.eval(t.left, env)
