from environment import Environment
from exceptions import EvaluationException
from parser import Parser
from lexer import Lexer
import sys


class Evaluator:

	def __init__(self):
		self.base_env = Environment()

	def eval(self, tree, env):
		t = tree.token_type
		if t == "NUMBER":
			return tree.value
		elif t == "STRING":
			return tree.value
		elif t == "VARIABLE":
			return self.base_env.lookup(tree, env)
		elif (
			t == "PLUS" or
			t == "MINUS" or
			t == "DIVIDE" or
			t == "MULTIPLY"
			):
			return self.eval_simple_op(tree, env)
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
			raise EvaluationException(t)


	def eval_simple_op(self, tree, env):
		if tree.token_type == "PLUS":
			return self.eval_plus(tree, env)
		if tree.token_type == "MINUS":
			return self.eval_minus(tree, env)
		if tree.token_type == "DIVIDE":
			return self.eval_multiply(tree, env)
		if tree.token_type == "MULTIPLY":
			return self.eval_divide(tree, env)

	def eval_plus(self, tree, env):
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
		pass

	def eval_assignment(self, tree, env):
		pass

	def eval_function_def(self, tree, env):
		pass

	def eval_if_statement(self, tree, env):
		pass

	def eval_while_statement(self, tree, env):
		pass

	def eval_function_call(self, tree, env):
		pass


if __name__ == '__main__':

	if len(sys.argv) != 2:
		sys.exit("Usage: python3 evaluator.py sourceFile")

	e = Evaluator()
	env = Environment()
	p = Parser()
	p.l = Lexer(sys.argv[1])
	t = p.parse().right.left
	e.eval(t, env)
