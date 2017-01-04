import sys
import os
import gc
import json

sys.path.append("./openface/demos/")

from classifier import loadClassifier
from classifier import inferImg

def evaluate(directory):
	print "evaluating " + directory
	(align, net, le, clf) = loadClassifier()

	#remove this file
	directory_file_path = directory + ".json"
	directory_file = open(directory_file_path, "w")

	if os.stat(directory_file_path).st_size == 0:
    		dictionary = {}
  	else:
  			dictionary = json.load(directory_file)
  			return dictionary

	#iterate through all directories
	subdirectories = [x[0] for x in os.walk(directory)][1:]

	gc_count = 0
	for subdirectory in subdirectories:
		if (gc_count % 50 == 0):
			gc.collect()
		gc_count += 1

		for item in os.listdir(subdirectory):
			item_path = subdirectory + "/" + item
			result = inferImg(align, net, le, clf, item_path)
		
			dictionary.update(result)
			print len(dictionary)

	#cache for future use
	json.dump(dictionary, directory_file)
	directory_file.close()

	return dictionary

def compare(target, given):
	print "comparing."
	n_disguised = 0
	n_exposed = 0
	total_score = 0.0

	for i in xrange(0, len(target)):
		a = target[i]
		b = given[i]

		print str(a) + " " + str(b)
		if a > 0 and b == 0:
			n_disguised += 1

		elif a == 0 and b > 0:
			n_exposed += 1

		total_score += (a - b)		
		print str(total_score)	

	print "FINAL COMPARE METRICS:"
	print "\tTotal faces: " + len(target)
	print "\tDisguised: " + str(n_disguised)
	print "\tExposed: " + str(n_exposed)
	print "\tTotal score: "+ str(total_score)

first = evaluate(sys.argv[1])
second = evaluate(sys.argv[2])

# compare(first, second)

