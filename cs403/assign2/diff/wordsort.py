from operator import itemgetter

with open("words_and_values", "r") as f, open("sorted_list", "w") as w:
	lines = f.read().split("\n")
	pairs = [line.split() for line in lines][:-1]
	for pair in pairs:
		pair[1] = int(pair[1])
	sorted_pairs = sorted(pairs, key=itemgetter(1))
	for pair in sorted_pairs:
		w.write(str(pair) + "\n")