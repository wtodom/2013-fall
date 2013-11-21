import unittest
from environment import Environment
from exceptions import UndefinedException
from lexeme import Lexeme
from treeviz import TreeViz


class EnvironmentTest(unittest.TestCase):

	def test_lookup(self):
		e = Environment()
		env = e.env_list
		var = Lexeme(token_type="VARIABLE", value="x")
		self.assertRaises(UndefinedException, e.lookup, var, env)

	def test_insert(self):
		e = Environment()
		env = e.env_list
		var = Lexeme(token_type="VARIABLE", value="x")
		val = Lexeme(token_type="NUMBER", value=5)
		e.insert(var, val, env)
		self.assertEqual(e.lookup(var, env), 5)

	def test_update(self):
		e = Environment()
		env = e.env_list
		var = Lexeme(token_type="VARIABLE", value="x")
		val = Lexeme(token_type="NUMBER", value=5)
		new_val = Lexeme(token_type="NUMBER", value=10)
		e.insert(var, val, env)
		self.assertEqual(e.lookup(var, env), 5)
		e.update(var, new_val, env)
		self.assertEqual(e.lookup(var, env), 10)

	def test_extend(self):
		# todo: edit to test the new environment structure
		e = Environment()
		env = e.env_list

		var1 = Lexeme(token_type="VARIABLE", value="y")
		var2 = Lexeme(token_type="VARIABLE", value="x")
		gvar2 = Lexeme(token_type="GLUE", left=var2)
		gvar1 = Lexeme(token_type="GLUE", left=var1, right=gvar2)

		val1 = Lexeme(token_type="NUMBER", value=7)
		val2 = Lexeme(token_type="NUMBER", value=5)
		gval2 = Lexeme(token_type="GLUE", left=val2)
		gval1 = Lexeme(token_type="GLUE", left=val1, right=gval2)

		self.assertRaises(UndefinedException, e.lookup, var1, env)
		self.assertRaises(UndefinedException, e.lookup, var2, env)

		xenv = e.extend(gvar1, gval1, env)

		self.assertEqual(e.lookup(var1, xenv), 7)
		self.assertEqual(e.lookup(var2, xenv), 5)

		# tv = TreeViz("xenv", xenv)
		# tv.viz()
		# tv.create_image()
		# tv.open_image()

if __name__ == '__main__':
	unittest.main()
