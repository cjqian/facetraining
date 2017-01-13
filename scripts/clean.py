# Traverses a given input and removes all folders with less than 4 images.
import sys
import os
import shutil

directory = sys.argv[1]
print directory
subdirectories = [x[0] for x in os.walk(directory)][1:]
for subdirectory in subdirectories:
	if not os.listdir(subdirectory):
    		os.rmdir(subdirectory)
    		print "Removed " + subdirectory
   	
   	l = len(os.listdir(subdirectory))
   	if l < 4:
    		print "Removed {}: {}".format(subdirectory, l)
    		shutil.rmtree(subdirectory)
