def zeno_cost(d, c, f):
	cost = c
	d = d/2





"""
Define a function, named zeno_cost, that computes the price of a ticket
for Zeno's Airlines given the distance, d, of the flight in stadia, 
the cost, c, of the first half of the trip in drachma, and a factor, f, 
for computing the cost of the rest of the trip. 
The total cost of a ticket is computed as follows: c drachma for the first 
half of the trip and c * f drachma for the first half of the remaining half. 
Of the part of the trip that still remains, the first half of that is 
c * f * f drachma. Indeed, the first half of the remaining portion is 
always f times the cost of the previous portion. When the cost of the first 
half of the remaining portion becomes less than or equal to a 
hemiobol (one-twelfth of a drachma), the remainder of the trip incurs no 
additional cost. However, if the cost is more than a hemiobol, but the 
length of remaining portion of the flight is less than or equal to a 
daktylos (there are 9,600 daktylos to 1 stadion), the remaining portion 
has a fixed cost of 5 drachma.
Your zeno_cost function should implement a recursive process. 
Expect real or integer numbers as arguments.
"""