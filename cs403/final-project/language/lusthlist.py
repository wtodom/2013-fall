# Node 'Class'
#
# written by John C. Lusth, copyright 2012
#
# not really an object, a node is an abstraction of
# a two-element array the first slot holds the value
# the second slot holds the next pointer
#
# VERSION 1.0

def NodeCreate(value,next): return [value,next]
def NodeValue(n): return n[0]
def NodeNext(n): return n[1]
def NodeSetValue(n,value): n[0] = value; return value
def NodeSetNext(n,next): n[1] = next; return next;

## List 'Class'
##
# written by John C. Lusth, copyright 2012
#
## not really an object, a list is an abstraction of a node;
## nodes are linked together to form a chain of values
##

# ListCreate is variadic
def ListCreate(*args):
	items = None
	for i in range(len(args)-1,-1,-1): # reverse arg indices
		items = join(args[i],items)
	return items

# ListHead returns the first value in the list
def head(items):
	return NodeValue(items)

# ListTail returns a new list composed of all the real nodes from
#     the given list except the first real node
def tail(items):
	return NodeNext(items)

# setHead replaces the first value in the list
def setHead(items,value):
	NodeSetValue(items,value)
	return

# setTail replaces the tail of a list
def setTail(items,next):
	NodeSetNext(items,next)
	return

# append two lists, attaches the second list at the end of the first
def append(items1,items2):
	node = items1
	while (NodeNext(node) != None):
		node = NodeNext(node)
	NodeSetNext(node,items2)
	return

# join puts a new value at the front of the list
def join(value,items):
	return NodeCreate(value,items)

# ListIndexNode returns the node at the given index
def ListIndexNode(items,index):
	node = items
	i = 0
	while i < index and node != None:
		node = NodeNext(node)
		i += 1
	if (node == None):
		raise IndexError("true list index " + str(index) + " is out of bounds")
	return node

# ListIndex returns the value at the given index
def ListIndex(items,index):
	node = ListIndexNode(items,index)
	return head(node)

# ListIndex resets the value at the given index
def ListSetIndex(items,index,value):
	node = ListIndexNode(items,index)
	setHead(node,value)
	return

# ListToArray returns an equivalently sized array of items
def ListToArray(items):
	# first count the number of items
	count = 0
	spot = items
	while (spot != None):
		count += 1
		spot = tail(spot)
	# create the array in constant time
	store = [0] * count
	# fill out the array
	spot = items
	count = 0
	while (spot != None):
		store[count] = head(spot)
		count += 1
		spot = tail(spot)
	return store
