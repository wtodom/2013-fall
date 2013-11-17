## MapReduce for Data Intensive Scientific Analyses - Jaliya Ekanayake, Shrideep Pallickara, and Geoffrey Fox

- Brief description of the area of research
	- They authors were interested in processing scientific data that fit into what they called "the class of composable applications". Their reasoning was that as time goes on, the sheer amount of data being produced in fields such as astronomy and physics is immense and demands efficient computation techniques.
	- They looked at three possible approaches:
		- Threads
		- Message Passing Interface (MPI)
		- MapReduce
	- They decided on using MapReduce for the following reasons:
		- its relaxed synchronization constraints do not impose much of an overhead for large data analysis tasks
		- the simplicity and robustness of the programming model supersede the additional overheads
	- ##### Goal of the paper: "We compare the performance of these implementations in the context of these scientific applications and make recommendations regarding the usage of MapReduce techniques for scientific data analyses."
	- Described and compared a couple of MapReduce implementations
		- Google's MapReduce (covered in class)
		- Hadoop (covered in class)
		- CGL-MapReduce, "a novel streaming-based MapReduce" implemented by the authors

- Contribution of paper claimed by authors
	- One big advantage of the MapReduce implementation they developed is that it was customized for the way they wanted to load and save data, resulting in performance gains over established implementations like Hadoop. For 1000GB of data using 12 compute nodes, CGL-MapReduce was about 17 minutes faster (91 minutes vs 108 minnutes).
	- We performed the above two data analyses using Hadoop and CGL-MapReduce and compared the results. Our results confirm the following observations:
 		1. Most scientific data analyses, which has some form of SMPD algorithm can benefit from the MapReduce technique to achieve speedup and scalability.
		2. As the amount of data and the amount of computation increases, the overhead induced by a particular runtime diminishes.
		3. Even tightly coupled applications can benefit from the MapReduce technique if the appropriate size of data and an efficient runtime are used.

	- Our experience shows that some features such as the necessity of accessing binary data, the use of different programming languages, and the use of iterative algorithms, exhibited by scientific applications may limit the applicability of the existing MapReduce implementations directly to the scientific data processing tasks. However, we strongly believe that MapReduce implementations with support for the above features as well as better fault tolerance strategies would definitely be a valuable tool for scientific data analyses.


- Brief discussion of problem/solution addressed by paper
	- "Although there are many examples for using MapReduce for textual data processing using Hadoop, we could not find any schemes for using MapReduce for these types of applications."
		- "these types of applications":
			- "The goal of the analysis is to execute a set of analysis functions on a collection of data files produced by high-energy physics experiements. After processing each data file, the analysis produces a histogram of identified features. These histograms are then combined to produce the final result of the overall analysis."
	- Kmeans Clustering
		- "In Kmeans clustering, the target is to cluster a set of data points to a predefined number of clusters. An iteration of the algorithm produces a set of cluster centers where it is compared with the set of cluster centers produced during the previous iteration. The total error is the difference between the cluster centers produced at nth iteration and the cluster centers produced at (n-1)th iteration. The iterations continue until the error reduces to a predefined threshold value."
		- "In Kmeans clustering, each map function gets a portion of the data, and it needs to access this data split in each iteration. These data items do not change over the iterations, and it is loaded once for the entire set of iterations. The variable data is the current cluster centers calculated during the previous iteration and hence used as the input value for the map function."

- Criticism of the paper and how you would improve it
	- "Since the overall performance is limited by the I/O bandwidth, we use only one processor core in each node for this evaluation."
		- If this is the case, it seems like a better topic would have been how to make the I/O process more efficient.

- What you liked about the paper
	-

- You should also list 2 questions that you will ask the class during the discussion
	-