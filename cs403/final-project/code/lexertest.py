from lexer import Lexer

def main():
	l = Lexer("/Users/wtodom/repositories/2013-fall/cs403/final-project/bubbleSort.para")
	while l.currentChar != "" or len(l.pushbackStack) != 0:
		w = l.lex()
		if w is not None:
			print(w)
	l.close_file()

main()