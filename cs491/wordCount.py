"""
CS 491 Assignment 3


The output to this program is the word(s) or letter and the number of occurrences.
Once the output is printed, your program should allow the user to make another choice.  

You should also keep track of how long it takes for your program to compute each request.

Give users menu options:
1)  Allow the user to input a word so your program can count the number of occurrences of a specified word.
2)  Alternatively, allow the user to input a letter and count the number of words that start with that letter.
3)  Allow the user to input two words and count the number of times those 2 words occur together (bigram).
4)  Exit the program
"""
import time


startRead = time.clock()
words = open("bible-and-shakespeare", "r").read().split()
stopRead = time.clock()

readTime = stopRead - startRead

def newline():
	print()

def count_for(word):
	newline()
	t = time.clock()
	count = words.count(word)
	countTime = time.clock() - t
	print("I found " + str(count) + " occurrences of the word \"" + word + "\".")
	print("It took " + str(readTime + countTime) + " seconds to read the file and count the words.")
	newline()

def count_for_words_that_start_with(letter):
	newline()
	t = time.clock()
	count = sum(1 for word in words if word[0] == letter)
	countTime = time.clock() - t
	print("I found " + str(count) + " occurrences of words starting with '" + letter + "'.")
	print("It took " + str(readTime + countTime) + " seconds to read the file and count the words.")
	newline()

def count_for_bigram(word1, word2):
	# code for the generator is influenced by vpekar's post on stackoverflow
	# user's profile: http://stackoverflow.com/users/1859772/vpekar
	# post: http://stackoverflow.com/a/14183015/1337661
	newline()
	t = time.clock()
	count = sum(1 for x, y in zip(*[words[i:] for i in range(2)]) if x == word1 and y == word2)
	countTime = time.clock() - t
	print("I found " + str(count) + " occurrences of the bigram \"" + word1 + " " + word2 + "\".")
	print("It took " + str(readTime + countTime) + " seconds to read the file and count the words.")
	newline()

def main_menu():
	choice = ""
	newline()
	print("Today we'll be counting words in the Holy Bible, New Shakespeare Version.")

	while choice != '4':
		print("Please select one of the following options:")
		print("1)  Enter a word to see how many times it occurs.")
		print("2)  Enter a letter to see how many words start with that letter.")
		print("3)  Enter two words to see how many times those two words occur together.")
		print("4)  Exit.")

		choice = input(">> ")

		if choice == '1':
			print("Which word would you like to count?")
			word = input(">> ")
			count_for(word)

		elif choice == '2':
			print("Which letter should would you like to search for?")
			letter = input(">> ")
			count_for_words_that_start_with(letter)

		elif choice == '3':
			print("Enter the first word.")
			word1 = input(">> ")
			print("Okay, now enter the second word.")
			word2 = input(">> ")
			count_for_bigram(word1, word2)

		elif choice == '4':
			print("Bye!")

		else:
			print("I'm sorry, I didn't understand that. Please choose try again:")

if __name__ == "__main__":
	main_menu()