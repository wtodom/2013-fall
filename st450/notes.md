ST450 - Statistics
==================

## 27 August 2013

- Example of an observational study
	- At some bank, there are 32 male clerks and 61 female clerks.
	- Goal is to compare their starting salaries.
	- Results: (see notebook-2)
	- We have convincing evidence that the males received larger starting salaries than the females. Did the bank discriminatorily pay higher starting salaries to men than women?
		- No. It is only an observational study, so we can't know enough about the participants. The evidence is consistent with discrimination, but there are other possible explanations (e.g. difference in years of prior experience, position, degree, etc.)
- IMPORTANT: We cannot draw cause and effect conclusions from observational studies.
- Why do we need observational studies?
	1. Sometimes randomized experiments are not possible. (se above example)
	2. Randomized studies aren't possible for ethical or other reasons (e.g. can't force people to do drugs.)
	3. They suggest areas/topics for future studies, perhaps randomized experiments.

contents of table, notebook-3:
<table style="border: 1px solid black">
	<tr >
		<td style="border: 1px solid black">A random sample is selected from one population; units are randomly assigned to different treatment groups.</td>
		<td style="border: 1px solid black">Random samples are selected from existing distinct populations</td>
	</tr>
	<tr>
		<td style="border: 1px solid black">A groups of study units is found; units are then randomly assigned to treatment groups.</td>
		<td style="border: 1px solid black">Collection of available units from distinct groups are examined.</td>
	</tr>
</table>

prior to this will not be tested, but will have homework

##### Graphical Representations

- dotplot
- stem-and-leaf diagram
- histogram
- boxplaot (covered a little later)
- scatterplot (also covered a little later)

!! notebook-4 !!

##### Measures of Central Tendency

- Mean
	- sum of measurements divided by the number of measurements.
	- distinguish between population mean and sample mean
		- notebook-5
- Median
	- middle element in the ordered sample if n is odd, else the middle of the middle two elements.
- Mode
	- the measurement that occurs most frequently.

##### Measures of Variability

- measure spread in data
	- Range
		- notebook-6
	- Variance
		- Population Variance
			- notebook-11
		- Sample Variance
			- notebook-12
	- Population Standard Deviation
		- take square root of pop. variance
	- Sample Standard Deviation
		- take square root of sample variance
	- One typical use of standard deviations is to report intervals (notebook-13)

- pth percentile is the number such that p% of the measurements fall below that number.
- Lower quartile == 25th percentile
- Upper quartile == 75th percentile
- notebook-14 for notation

- Boxplots
	- notebook-15
- How find Q1 and Q3?
	- Q1 = ((n + 1) / 4)th value
	- Q3 = (3(n + 1) / 4)th value
	- Remeber, Q2 is the median
	- Example:
		- data: 3, 4, 5, 6, 7, 10, 12
		- Q1: n+1/4 = 7+1/4 = 2, so Q1 = 4
		- Q3: 3(n+1)/4 = 3(7+1)/4 = 6, so Q3 = 10

- Scatterplot
	- Used to represent bi-varied relationships.
	- notebook-16

##### Probability Theory

- Example:
	- Experiment - Toss a coin three times
	- Sample Space is the collection of all possible outcomes in an experiment.
	- And Event is a sub-collection of the sample space.
	- sub-example:
		- Event A: First toss is Tails. = {THH, THT, TTH, TTT}
		- Event B: At least two heads in a row. = {HHH, HHT, THH}
- Some additional TERMinology
	- Union
	- Intersection
	- Compliment (denoted by A^c)
	- Empty Set

- Probability is a real-valued function that assigns chances to events.
	- notation: P(A), where P stands for "probability" and A is an event.
	- Probability is always between 0 and 1
- Disjoint Events (mutually exclusive events)
	- events such that A intersection B = Empty Set
	- With disjoint events, the probability of the union of the events is equal to the sum of the probability of the individual events.
- (Maybe learn some basic probability rules)

## 3 September 2013 - Permutations, Combinatorics, etc.
- If some complex action can be decomposed into K component actions such that the first action can be done in N1 ways, then the second action can be done in N2 ways, … , then the Kth action can be done in Nk ways, then there are N1 * N2 * … * Nk ways to do the complex action.
- The number of permutations of the N different elements taken n at a time is N! / (N - n)!
- In permutations order matters, in combinations order does not matter.
- The number of combinations of the N different elements taken n at a time is N! / n! * (N - n)!
- The probability of some event A is equal to the number of outcomes in A divided by the number of outcomes in the sample space. (assumes all outcomes equally likely).
- Example:
  	- 10 people buy tickets together at a movie theater. They are distributed randomly. What is the probability that persons A and B sit next to each other (among their group of 10 seats)?
  	- 10! possible seating arrangements (sample space)
  	- 9 * 2 * 8! possible ways to seat everyone fitting criteria (9 pairs, either could be on left, 8! for other people)
  	- (9 * 2 * 8!) / 10! =  0.2
- (Example: What's the chance that at least two people have same birthday?)

## 5 September 2013 - Permutations and Combinations (cont.)

- Example:
	- Player takes 5 cards at random
	- What is the chance that the player gets a full house?
		- P(A) = num(A)/num(S)
		- num(S) = 52choose5 = 52!/(5!*(51-5)!).
		- num(A) = 13\*4choose3\*12\*4choose2
		- P(A) = .0014

##### Conditional probability and Independence

- Conditional probability that event A occurs given that event B occurs: P(A|B) = (P(A and B))/P(B)
- Example
	- A = "rain tomorrow"
	- B = "rain today"
	- P(B) = .8
	- P(A|B) = .9
	- P(A and B) = P(B)*P(A|B) = .8*.9 = .72

- *** Important *** Example: Medical Test problem *** Important ***
	- Some medical test detects a disease correctly in 90% of cases. It detects incorrectly in 5% of cases.
	- Assume .1% of all people are infected.
	- What is the chance that a person is sick if the test result is positive?
	- A = "test result is positive"
	- B = "disease present"
	- P(A|B) = .9
	- P(A|~B) = .05
	- P(B) = .001
	- P(~A|B) = .1
	- P(~A|~B) = 1-P(A|~B) = .95
	- P(~B) = 1-.001 = .999
	- notebook-19
	- So, P(B|A) = P(AandB)/P(A) = P(AandB)/(P(Aand~B) + P(AandB)) = 1.77%

##### Independence

- Events A and B are independent if P(A given B) = P(A)
- Original formula: P(AandB) = P(A)*P(B|A)
- However, iff A and B are independent, P(AandB) = P(A)*P(B)
- Independent != Disjoint
- If events A1, A2, ..., Ak are independent, then (notebook-20)
- *** BAYES RULE *** (notebook-21)

## 10 September 2013 - Random Variables

- A random cariable assumes numerical values associated with outcomes.
- Only one numerical value is assigned to each outcome.
- Discrete random variables are associated with counts.
- Continuous random variables are associated with intervals.
- Random variable are always denoted by a capital letter.
- Probability Mass Function: notebook-29

- Expected value and variance: notebook-30
- Expected value can be thought of as "long run average"

- Properties of E() and Var()
	- notebook-31

## 12 September 2013 - Distrobutions

##### Bernoulli Distrobution

- One attempt with two possible outcomes.
- Example:
	- A basketball player scores with probability P in one trial.
	- There are two possible outcomes for a trial:
		- Success (score)
		- Failure (miss)
	- p = P(success)
	- 1-p = P(failure)
- notation: notebook-35
- Example using notation
	- A basketball player scores with probability 0.2 on each attempt.
	- notebook-36

##### Binomial Distrobution

- Assume n independent identical Bernoulli trials
- Example: Toss a coin 3 times.
- notation: notebook-37
- Example using notation
	- n = 5
	- p = 0.2
	- What is the probabilit that the player scores exactly two times?
	- notebook-38

##### Hypergeometric Distrobution

- Example
	- A box contains 10 balls: 6 red, 4 black. We take 5 balls at random without replacement.
	- What's the probability that we see exactly 3 red balls?
	- notebook-39 (example and notation)

## 17 September 2013 - Continuous Random Variables

- the function representing the curve of a histogram is called the probability density funtionc
	- fx(x) >= 0 for any x
	- The area under the curve = 1
	- P(a < x < b) is the area under the curve between a and b.
	- P(x = a) = 0, for any continuous random variable X.
	- P(a < x < b) = P(a <= x < b) = P(a < x <= b) = P(a <= x <= b)

#### Distrobutions

##### Uniform Distrobution

- Every outcome is equally likely.
- pdf: 1 / (d - c) for c < x < d, 0 otherwise
- notation: X~Uniform(c, d)
- E(X) = c + (d - c)/2
- Var(X) = ((d - c)^2)/12
- Example
	- notebook-44
	- image @ 4:02

##### Normal Distrobution

- Example: Height of females
- notation: notebook-45
- It is difficult to calculate the area under the normal curve. Tables are available. Since probabilities depend on particular values of Mu and Sigma^2, we would like to standardize them.
- notebook-46 (graphical representation of the standardization shift)
- notebook-47

## 19 September 2013

