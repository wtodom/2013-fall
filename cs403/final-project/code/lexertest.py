from lexer import Lexer

def main():
	l = Lexer("/Users/wtodom/repositories/2013-fall/cs403/final-project/bubbleSort.para")
	while l.currentChar != "":
		l.lex()
	l.closeFile()

main()