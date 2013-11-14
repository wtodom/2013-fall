from environment import Environment
from exceptions import EvaluationException
from parser import Parser
from lexer import Lexer, Lexeme
from treeviz import TreeViz
import sys


class Evaluator:

	def __init__(self):
		self.base_env = Environment()

	def eval(self, tree, env):
		t = tree.token_type
		if t == "NUMBER":
			# print("In eval('NUMBER')")
			# print(tree.value)
			return tree.value
		elif t == "STRING":
			return tree.value
		elif t == "VARIABLE":
			return self.base_env.lookup(tree, env)
		elif t == "PLUS":
			return self.eval_plus(tree, env)
		elif t == "MINUS":
			return self.eval_minus(tree, env)
		elif t == "DIVIDE":
			return self.eval_multiply(tree, env)
		elif t == "MULTIPLY":
			return self.eval_divide(tree, env)
		elif t == "STATEMENTS":
			# print("In eval('STATEMENTS')")
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
			raise EvaluationException(t)

	def eval_plus(self, tree, env):
		# print(tree)
		print(self.eval(tree.left, env) + self.eval(tree.right, env))
		return self.eval(tree.left, env) + self.eval(tree.right, env)

	def eval_minus(self, tree, env):
		return self.eval(tree.left, env) - self.eval(tree.right, env)

	def eval_multiply(self, tree, env):
		return int(self.eval(tree.left, env) / self.eval(tree.right, env))

	def eval_divide(self, tree, env):
		return self.eval(tree.left, env) * self.eval(tree.right, env)

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
		# value = self.eval(tree.right, env)
		if self.base_env.lookup(val, env):
			self.base_env.update(var, val, env)
		else:
			self.base_env.insert(tree.left, tree.right, env)

	def eval_if_statement(self, tree, env):
		if self.eval(tree.left, env):
			self.eval(tree.right, env)

	def eval_while_statement(self, tree, env):
		pass

	def eval_function_def(self, tree, env):
		closure = Lexeme(token_type="CLOSURE", left=env, right=tree)
		self.base_env.insert(self.get_function_def_name(tree), closure, env)

	def eval_function_call(self, tree, env):
		closure = eval(self.get_function_call_name(tree), env)
		args = self.get_func_call_args(tree)
		params = self.get_closure_params(closure)
		body = self.get_closure_body(closure)
		senv = self.get_closure_environment(closure)
		eargs = self.eval_args(args, env)
		xenv = self.base_env.extend(senv, params, eargs)

		return eval(body, xenv)

	def get_function_def_name(self, tree):
		return tree.left.value

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
	env = Environment().env_list
	p = Parser()
	p.l = Lexer(sys.argv[1])
	t = p.parse().right.left
	# tv = TreeViz("test", t)
	# tv.viz()
	# tv.create_image()
	# tv.open_image()
	e.eval(t, env)
