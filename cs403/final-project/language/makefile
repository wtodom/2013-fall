all:
	echo "My language doesn't require compilation/building."

add:
	python3 -B evaluator.py ../paragraph-code/add.para

func:
	python3 -B evaluator.py ../paragraph-code/function.para

return:
	echo
	echo "The code file being run:"
	echo "|-------------------------------------------------------------------"
	cat ../paragraph-code/return.para
	echo
	echo "-------------------------------------------------------------------|"
	echo
	echo "output:"
	echo "|-------------------------------------------------------------------"
	python3 -B evaluator.py ../paragraph-code/return.para
	echo
	echo "-------------------------------------------------------------------|"

list:
	python3 -B evaluator.py ../paragraph-code/list.para

array:
	python3 -B evaluator.py ../paragraph-code/array.para

cond2:
	python3 -B evaluator.py ../paragraph-code/cond2.para

while:
	python3 -B evaluator.py ../paragraph-code/while.para

hello:
	python3 -B evaluator.py ../paragraph-code/printHello.para

cond:
	python3 -B evaluator.py ../paragraph-code/conditional.para

sort:
	python3 -B evaluator.py ../paragraph-code/bubblesort.para

loops:
	python3 -B evaluator.py ../paragraph-code/loops.para

tests:
	python3 -B tests.py -v

clean:
	rm -f *.dot
	rm -f *.png
	rm -f .DS_Store
	rm -rf __pycache__