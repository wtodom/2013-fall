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

- maybe notebook...

## 24 September 2013

- just r stuff.

## 26 September 2013 - Test Review

- worked old exam in class

## 3 October 2013

##### Sampling Distrobutions

- Recall that discrete and continuus distrobutions have parameters. These parameters are almost always unknown.
- Sample Statistic - Some numerical descriptive measure calculated based on the observations in our sample.
	- Examples: notebook-65
- Sampling Distrobution - is a probability distrobution of a statistic
- Different statistics have different sampling distrobutions
- Additional terminology:
	- A statistic g(x1, x2, ..., xn) is an unbiased estimator of the parameter Rho (notebook-66) if the expected value of g(x1, x2, ..., xn) = Rho.
- Example: notebook-67
	- "iid" - independent identically distributed
- An unbiased estimator with the smallest variance is called a "minimum variance unbiased estimator".


## 8 October 2013

- Important Results:
	1. If a random sample of size n is selected from a population with normal distrobition, the sampling distrobution of xBAR is also normal. Therefore, if x1, x2, x3, x4, x5, xn~(iid)Normal(MU, SIGMA^2), then XBAR~Normal(MU, (SIGMA^2)/n)
	2. If a random sample of size n (n -> infinity)is selected from *any* distrobution with mean MU and variance SIGMA^2, the sampling distrobution of XBAR is approximately normal with mean MU and variance ((SIGMA^2)/n). If x1, x2, x3, x4, xn ~(iid)f(MU, SIGMA^2) (that is, some distrobution) and n is **large**, then XBAR~(approx)Normal(MU, ((SIGMA^2)/n)). This is the Central Limit Theorem. Many books recommend n >= 30 (large) and don't use CLT for n < 30. This isn't a hard limit.

- Example:
	- x1, x2, x3, xn~(iid)Bernoulli(p) (for example, 0, 0, 1, 0, 0, 1, 1, 1, 0, ...)
	- Assume n is large. notebook-73

#### Inference Based on a Single Sample

##### Confidence Intervals

- We used to work with point estimators. For example, xBAR is a point estimator for MU. Now we will consider interval estimators called confidence intervals.

- The confidence coefficient is the probability that an interval estimator encloses the population parameter.

- The confidence level is literally the same thing as the confidence coefficient, but expressed as a percentage.

- If we have a sample x1, x2, x3, x4, ..., xn~(iid)Normal(MU, SIGMA^2), we know that XBAR~Normal(MU, ((SIGMA^2)/n)).
	- notebook-74
	- Example:
		- We want 95% CI.
		- (1 - alpha) * 100% = 95%
		- 1 - alpha = .95
		- alpha = 0.05
		- (alpha / 2) = 0.025 -> notebook-75
- SImilarly, but the CLT, is x1, x2, x3, ..., xn~(iid)f(MU, SIGMA^2) and n is large, then (1 - alpha) * 100% CI for MU is notebook-76

- Interpretation:
	- We can be (1 - alpha) * 100% confident that MU lies between the lower and upper bounds of the CI.

- Example:
	- Suppose we have a sample of size 100.
	- The observed XBAR = 15.
	- SIGMA = 5.
	- Find 95% CI for MU.
	- By CLT (since n is large), (1 - alpha) * 100% CI for MU is notebook-76.
		- for 95% CI, Z = 1.96
		- notebook-77
	- Conclusion: With 95% confidence we can statee that MU is between 14.02 and 15.98.

- Problem: We almost never know SIGMA in real life situations. Sometimes we can assume that SIGMA is known based on pilot studies. If SIGMA is unknown, we can use S instead of SIGMA. If SIGMA^2 is unknown and we use S^2 instead, we have to rely on the T-Dristrobution rather than the Z-Distrobution (standard normal distrobution).

- ###### T-Distrobution
	- Also bell-shaped
	- very similar to normal for large degrees of freedom
	- notation: notebook-78
	- different from normal for df < 30
	- has heavy tails.
	- The higher the df, the closer it is to normal.

- Recall that Z(0.025) - 1.96
	- t with one df (and 0.025) = 12.706
	- with 10, 2.228
	- with 30, 2.042
	- with 120, 1.98
	- with infinity, 1.96

- For one sample, df = n - 1

- If SIGMA^2 is unknown, but x1, x2, x3, x3, ..., xn~(iid)Normal(MU, SIGMA^2, we use S^2.
	- Then (1 - alpha) * 100% for MU is notebook-79

- Example: breakfast time
	- Find 95% CI for mean breakfast time MU. Assume n=9.
	- data points: 15.25, 9.5, 8.5, 9, 9.75, 8, 7.017, 10.5, 7.25
	- XBAR = 10.95
	- S^2 = 29.47
	- (using formula from notebook-79) : t-value is 2.306, XBAR = 9.42, S^2 = 6.10. answer: (7.52, 11.32)

- Summary: notebook-83

## 10 October 2013 - Sample Size Detection

- Assume we know SIGMA^2. We need to know how many subjects we need to recruitto guarantee the width of the confidence interval (1 - alpha) * 100%, W. The number is notebook-84.

- If we don't know SIGMA^2, things are more complicated.
	- notebook-85

#### Hypothesis testing

- notebook-86
- notebook-87
- p-value: notebook-88
	- Compare p-value with alpha-level.
	- If p-value is <= alpha, reject null hypothesis.
		- Else, fail to reject the null hypothesis.
	- Interpretation: We have (or don't have) enough evidence to reject the null hypothesis.

- SUMMARY:
	- IMAGE @

## Confidence Interval Z-values

<p><strong>Small Table of z-values for Confidence Intervals</strong></p>
<table style="width: 13%; height: 132px" cellspacing="7" cellpadding="4">
	<tbody>
		<tr>
			<td><strong>Confidence Level</strong></td>
			<td style="width: 114px"><strong>z</strong></td>
		</tr>
		<tr>
			<td>0.70</td>
			<td style="width: 114px">1.04</td>
		</tr>
		<tr>
			<td>0.75</td>
			<td style="width: 114px">1.15</td>
		</tr>
		<tr>
			<td>0.80</td>
			<td style="width: 114px">1.28</td>
		</tr>
		<tr>
			<td>0.85</td>
			<td style="width: 114px">1.44</td>
		</tr>
		<tr>
			<td>0.90</td>
			<td style="width: 114px">&nbsp;1.645</td>
		</tr>
		<tr>
			<td>0.92</td>
			<td style="width: 114px">1.75</td>
		</tr>
		<tr>
			<td>0.95</td>
			<td style="width: 114px">1.96</td>
		</tr>
		<tr>
			<td>0.96</td>
			<td style="width: 114px">2.05</td>
		</tr>
		<tr>
			<td>0.98</td>
			<td style="width: 114px">2.33</td>
		</tr>
		<tr>
			<td>0.99</td>
			<td style="width: 114px">2.58</td>
		</tr>
</table>

## 17 October 2013

- Sampling Size Detection (notebook 84 and 85 cont.)
	- Assume that variance1 and variance2 are both known. Then the (1-alpha)*100% CI for MU1-MU2 is notebook-92.
	- Assume that the desired width of a (1-alpha)*100% CI (denoted by W) is provided. Then, notebook-93.
	- Asume that variance1 = variance2 = variance, and variance is unknown. (1-alpha)*100% CI for mu1-mu2 is notebook-94

- Paired Samples
	- Example: healthy and sick twins. volume of brain regions measued.
		- photo @ 4:43

## 24 October 2013 - Categorical Data Analysis

- categorical variables: gender, political party, pass/fail, etc.
- topics:
	- inference for one proportion
	- inference for two proportions
	- chi-square tests
	- Fisher's exact test

#### Inference for a single proportion

- have sample x1, x2, x3, xn ~(iid)Bernoulli(p)
- xi represents the number of successes of one trial
- E(xi) = p
- Var(xi) = p(1-p)
- (some stuff about phat)
- (1-alpha)*100% CI for p is notebook-100
- hypothesis testing, notebook-101

- Example: pepsi vs coke
	- notebook-102

#### Inference for two proportions
- have independent samples:
	- have sample x11, x12, x13, xn ~(iid)Bernoulli(p1)
	- have sample x21, x22, x23, xn ~(iid)Bernoulli(p2)
- find phat for each respective sample
- p1hat and p2hat are both approx Normal (same as before, with subscripts)
- notebook-103
- example: notebook-105

## 29 October 2013 - Contingency Tables

- notation is image on phone
- null hypothesis: Depends on particular table
	- This means that row and column classifications are independent. In other words, the distrobution of proportions over columns is the same for all rows.
- Test Statistic: Chi^2 observed (http://en.wikipedia.org/wiki/Chi-squared_distribution)
	- notebook-106
- p-value: notebook-107
- Requirements:
	- all Eij's > 1
	- 80% of them >= 5

## 5 November 2013 - Goodness of Fit Test

- Fisher's Exact Test
	- Previous methods based on large samples
	- compares two proportions and computest he exact probability of observing a table and more extreme tables
	- Keep totals for colums and rows the same.

## 7 November 2013 - Non-parametric Statistics Methods (NPSM)

- Distrobution-free tests - That is, we don't have to assume that our data are normally disctributed.
- Often, we have relatively low sample sizes and normality cannot be assumed.
- Then we cannot use the T distrobution or Central Limit Theorem.
- NPST deals with ranks of observations instead of actual measurments.
- The inference is about the median, not about the mean (like it was before).

#### Inference based on one sample - The Sign Test

- ###### One-tailed test:
	- H0: m = m0 (m0 is the median)
	- HA: m > m0 (or m < m0)
	- Test Statistic: S, the number of measurements greater than m0
	- pval = p(y >= S) (or p(y <= S) if using second HA)
		- y~Binomial(n, p=0.5)

- ###### Two-tailed test:
	- H0: m = m0
	- HA: m != m0
	- Test Statistic: S, larger of S1 and S2, where S1 is the number of measurements < m0, and S2 is the number of measurements > m0.
	- pval = 2(p(y >= S))
		- y~Binomial(n, p=0.5)

- ##### Both:
	- If we have any observations exactly equal to m0, drop them before beginning analysis.

- Example: notebook-114

#### Inference based on two samples - Wilcoxon Rank Sum Test

- Check the difference in medians
- replace observations with their combined ranks
- n1 >= 10, n2 >= 10
- n1 <= n2 in this test

- H0: m1 = m2
- HA: m1 != m2 or m1 > m2 or m1 < m2
- Zobs = (T1 - (n1(n1+n2+1))/2)/sqrt((n1*n2(n1+n2+1))12)
- pval: 2(p(Z > |Zobs|)) or p(Z > Zobs) or p(Z < Zobs) (same order as HAs above)

- example: notebook-115

#### Inference for paired samples - Wilcoxon Signed Rank Test

- We calculate differences and obtain W - the sum of positive ranks
- First, we rank absolute values and then assign "+" or "-" to the obtained ranks
- We require n >= 20.
- If there are any differences of 0 (same value in both sides), exclude them from the sample.

- H0: md = 0
- HA: md != 0 or HA: md < 0 or HA: md > 0
- Zobs = (W-(n(n+1)))/sqrt((n(n+1)(2n+1))/24)
- pval: 2(p(Z > |Zobs|)) or p(Z < Zobs) or p(Z > Zobs) (same order as HAs above)

- example: notebook-116

## 19 November 2013 One-way ANOVA

- Assume indepenedent random samplesfrom r (some integer) populations.
- It can be a randomized experiment with r treatments or observational
study with r different groups.
- There are two sources of variation in measurements.
	- variation within groups
	- variation between groups
- ANOVA allows answering questions like:
	- Do all groups have the same population mean?
- hypothesis testing:
	- H0: mu1 = mu2 = mu3 = ... = muR
	- Ha: at least one mean is different

## 21 November 2013 - ANOVA cont.

- all written - just listened. PRINT STUFF FROM ONLINE!