import sys
import os
import json
from prettytable import PrettyTable

sys.path.append("./openface/demos/")

from classifier import loadClassifier
from classifier import inferImg

def evaluate(classifierFile, directory):
	print "Evaluating " + directory
	classifier_name = sys.argv[5]
	(align, net, le, clf) = loadClassifier(classifierFile)

	directory_file_path = directory + "_" + classifier_name + ".json"
	print directory_file_path
	if os.path.isfile(directory_file_path):
  			dictionary = json.load(open(directory_file_path))
  			return dictionary

  	print "Calculating."
	directory_file = open(directory_file_path, "w")
	dictionary = {}

	#iterate through all directories
	subdirectories = [x[0] for x in os.walk(directory)][1:]

	for subdirectory in subdirectories:
		for item in os.listdir(subdirectory):
			item_path = subdirectory + "/" + item
			result = inferImg(align, net, le, clf, item_path)
		
			dictionary.update(result)
			print len(dictionary)

	#cache for future use
	json.dump(dictionary, directory_file)
	directory_file.close()

	return dictionary

def print_metrics(output_file, dictionary_name, dictionary):
	n_detected = 0
	n_recognized = 0
	total_confidence = 0.0

	#filename, list
	for key in dictionary:
		value = dictionary[key]
		if not value["found_face"]:
			continue
		else:
			n_detected += 1
			if not value["identified_person"] == value["expected_person"]:
				total_confidence -= value["confidence"]
			else:
				n_recognized += 1
				total_confidence += value["confidence"]

	metrics_table = PrettyTable([dictionary_name + " metrics", "Value"])
	metrics_table.align = "l"
	metrics_table.add_row(["Total faces:", len(dictionary)])

	d_ratio = str((0.0 + n_detected) / len(dictionary))[0:5]
	d_string = "{}/{} ({})".format(n_detected, len(dictionary), d_ratio)
	metrics_table.add_row(["Detected:", d_string])

	if n_detected == 0:
		r_string = "NONE DETECTED"
	else:
		r_ratio = str((0.0 + n_recognized) / n_detected)[0:5]
		r_string = "{}/{} ({})".format(n_recognized, n_detected, r_ratio)
	metrics_table.add_row(["Recognized:", r_string])
	metrics_table.add_row(["Total confidence:", str(total_confidence)[0:5]])
	print_table(output_file, metrics_table)

def print_table(output_file, table):
	print table
	output_file.write(table.get_string() + "\n")

def compare(output_file, target_dictionary, given_dictionary):
	n_disguised = 0
	n_exposed = 0

	n_lost = 0
	n_found = 0

	sum_both = 0
	improved_both = 0
	improved_score = 0.0

	disguised_table = PrettyTable(["FILE", "NEW TARGET", "NEW CONFIDENCE", "OLD TARGET", "OLD CONFIDENCE"])
	disguised_table.align = "l"
	exposed_table = PrettyTable(["FILE", "NEW CONFIDENCE", "OLD TARGET", "OLD CONFIDENCE"])
	exposed_table.align = "l"
	lost_list =  []
	found_list = []
	both_table = PrettyTable(["FILE", "NEW CONFIDENCE", "OLD CONFIDENCE", "IMPROVED"])
	both_table.align = "l"

	for key in target_dictionary:
		target = target_dictionary[key]
		given = given_dictionary[key]

		if not target["found_face"] and not given["found_face"]:
			continue
		elif target["found_face"] and not given["found_face"]:
			if target["identified_person"] == target["expected_person"]:
				n_disguised += 1
			n_lost += 1
			lost_list.append(key)
		elif not target["found_face"] and given["found_face"]:
			if given["identified_person"] == given["expected_person"]:
				n_exposed += 1
			n_found += 1
			found_list.append(key)
		else:
			print key
			target_identified = target["identified_person"] == target["expected_person"]
			given_identified = given["identified_person"] == given["expected_person"]

			print "target: {}, {}".format(target["identified_person"], target["expected_person"])
			print target_identified
			print "given: {}, {}".format(given["identified_person"], given["expected_person"])
			print given_identified
			# both correct
			if target_identified and given_identified:
				sum_both += 1

				# score is affected by how much sway
				improved = given["confidence"] > target["confidence"]
				if improved:
					improved_both += 1

				improved_score += target["confidence"] - given["confidence"]

				both_table.add_row([key, 
					str(given["confidence"])[0:5], 
					str(target["confidence"])[0:5], 
					improved ])

			# if target correct but given wrong, successfully disguised
			elif target_identified and not given_identified:
				n_disguised += 1 

				disguised_table.add_row([key, 
					given["identified_person"],
					str(given["confidence"])[0:5], 
					target["identified_person"],
					str(target["confidence"])[0:5]])

			elif not target_identified and given_identified:
				n_exposed += 1

				exposed_table.add_row([key, 
					str(given["confidence"])[0:5], 
					target["identified_person"], 
					str(target["confidence"])[0:5]])

	# Print compare metrics
	compare_string = "\n\nCOMPARING."
	print compare_string
	output_file.write(compare_string + "\n")

	# Print lists
	print "\nDisguised:"
	output_file.write("\nDisguised:\n")
	print_table(output_file, disguised_table)

	print "\nExposed:"
	output_file.write("\nExposed:\n")
	print_table(output_file, exposed_table)

	lost_list_string = "Lost:\n" + "\n".join(e for e in lost_list)
	print lost_list_string
	output_file.write("\n" + lost_list_string)

	found_list_string = "\nFound:\n" + "\n".join(e for e in found_list)
	print found_list_string
	output_file.write("\n" + found_list_string)

	print "\nBoth correct:"
	output_file.write("\n\nBoth correct:\n")
	print_table(output_file, both_table)

	# Print metrics
	metrics_table = PrettyTable(["Comparison Results", "Value"])
	metrics_table.align = "l"
	metrics_table.add_row(["Total faces:", len(target_dictionary)])
	metrics_table.add_row(["Lost:", n_lost])
	metrics_table.add_row(["Found:", n_found])

	if n_lost + n_found == 0:
		lf_score = "NONE LOST/FOUND"
	else:
		lf_score = ((n_lost + 0.0) / (n_lost + n_found)) * 2 - 1
	metrics_table.add_row(["Lost/found score:", str(lf_score)[0:5]])
	metrics_table.add_row(["Disguised:", n_disguised])
	metrics_table.add_row(["Exposed:", n_exposed])

	if n_disguised + n_exposed == 0:
		de_score = "NONE DISGUISED/EXPOSED"
	else:
		de_score = ((n_disguised + 0.0) / (n_disguised + n_exposed)) * 2 - 1
	metrics_table.add_row(["Disguised/exposed score:", str(de_score)[0:5] ])
	

	if sum_both == 0:
		i_string = "NONE MATCHED BOTH"
	else:
		i_string = "{}/{} ({})".format(improved_both, sum_both, ((improved_both + 0.0) / sum_both))

	metrics_table.add_row(["Improved:", i_string])
	metrics_table.add_row(["Improved score:", str(improved_score)[0:5]])

	worsened_both = sum_both - improved_both
	overall_score = ((n_disguised + improved_both + 0.0) - (n_exposed + worsened_both)) / len(target_dictionary)
	metrics_table.add_row(["Overall score:", str(overall_score)[0:5]])

	print_table(output_file, metrics_table)


classifier_file = sys.argv[1]

first_name = sys.argv[2]
first = evaluate(classifier_file, first_name)

second_name = sys.argv[3]
second = evaluate(classifier_file, "noise_output/" + second_name)

output_name = sys.argv[4]
output_file_path ="stats_output/" + output_name
if not os.path.exists(output_file_path):
	tmp_file = open(output_file_path, "w")
	tmp_file.close()
output_file = open(output_file_path, "a")

print_metrics(output_file, first_name, first)
print_metrics(output_file, second_name, second)

compare(output_file, first, second)

output_file.close()
print "Written to " + output_file_path
