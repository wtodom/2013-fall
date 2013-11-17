import unittest
from environment import Environment
from lexeme import Lexeme


class EnvironmentTest(unittest.TestCase):

	def test_lookup(self):
		e = Environment()
		env = e.env_list
		var = Lexeme(token_type="VARIABLE", value="x")
		self.assertIsNone(e.lookup(var, env))

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
		e.insert(var, val, env)
		self.assertEqual(e.lookup(var, env), 5)
		e.update(var, 10, env)
		self.assertEqual(e.lookup(var, env), 10)

	def test_extend(self):
		e = Environment()
		env = e.env_list
		var = Lexeme(token_type="VARIABLE", value="y")
		val = Lexeme(token_type="NUMBER", value=7)
		var2 = Lexeme(token_type="VARIABLE", value="x", right=var)
		val2 = Lexeme(token_type="NUMBER", value=5, right=val)
		self.assertIsNone(e.lookup(var, env))
		xenv = e.extend(var2, val2, env)
		self.assertEqual(e.lookup(var, xenv), 7)
		self.assertEqual(e.lookup(var2, xenv), 5)

if __name__ == '__main__':
	unittest.main()
