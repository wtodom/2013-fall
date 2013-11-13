from environment import Environment
from parser import Parser
from lexer import Lexer
import sys


class Evaluator:

	def __init__(self):
		self.base_env = Environment()

	def eval(self, tree, env):
		t = tree.token_type
		if t == "NUMBER":
			return tree
		elif t == "STRING":
			return tree
		elif t == "VARIABLE":
			return self.base_env.lookup(tree, env)
		elif (
			t == "PLUS" or
			t == "MINUS" or
			t == "DIVIDE" or
			t == "MULTIPLY"
			):
			self.eval_simple_op(tree, env)
		elif t == "STRING":
			pass
		elif t == "STRING":
			pass
		elif t == "STRING":
			pass
		elif t == "STRING":
			pass
		elif t == "STRING":
			pass
		elif t == "STRING":
			pass
		elif t == "STRING":
			pass
		elif t == "STRING":
			pass
		elif t == "STRING":
			pass
		elif t == "STRING":
			pass
		elif t == "STRING":
			pass

	def eval_simple_op(self, tree, env):
		if tree.token_type == "PLUS":
			return tree.left.value + tree.right.value


if __name__ == '__main__':

	if len(sys.argv) != 2:
		sys.exit("Usage: python3 evaluator.py sourceFile")

	e = Evaluator()
	env = Environment()
	p = Parser()
	p.l = Lexer(sys.argv[1])
	t = p.parse().right.left.left
	print(e.eval_simple_op(t, env))
