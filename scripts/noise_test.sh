# LFW DATASET
	# CREATE OUTER ALIGNMENT
	rm -rf lfw_outer_aligned
	mkdir lfw_inner_aligned
	for N in {1..8}; do ./openface/util/align-dlib.py lfw/ align innerEyesAndBottomLip lfw_outer_aligned --size 96 & done
	# At this point, lfw_outer_aligned/ contains lfw dataset aligned pictures. 

		# TRAIN LINEAR SVM
		rm -rf lfw_outer_linear_features
		mkdir lfw_outer_linear_features

		./openface/batch-represent/main.lua -outDir lfw_outer_linear_features -data lfw_outer_aligned 
		./openface/demos/classifier.py train lfw_outer_linear_features

		# NOW MAKE THE NOISE
		python noise.py lfw_outer_aligned gauss lfw_outer_aligned_gauss100 100 & \
		python eval.py lfw_outer_linear_features/classifier.pkl lfw_outer_aligned lfw_outer_aligned_gauss100 lfw_outer_linear_gauss100 & \


		python noise.py lfw_outer_aligned gauss lfw_outer_aligned_gauss500 500 & \
		python eval.py lfw_linear_features/classifier.pkl lfw_outer_aligned lfw_outer_aligned_gauss500 lfw_outer_linear_gauss500.out & \

		python noise.py lfw_outer_aligned gauss lfw_outer_aligned_gauss1000 1000
		python noise.py lfw_outer_aligned poisson lfw_outer_aligned_poisson
		python noise.py lfw_outer_aligned speckle lfw_outer_aligned_speckle25 .25 
		python noise.py lfw_outer_aligned speckle lfw_outer_aligned_speckle50 50
		python noise.py lfw_outer_aligned speckle lfw_outer_aligned_speckle100 100

		# NOW EVALUATE
		python eval.py lfw_linear_features/classifier.pkl lfw_outer_aligned lfw_outer_aligned_gauss1000 lfw_outer_linear_gauss1000.out
		python eval.py lfw_linear_features/classifier.pkl lfw_outer_aligned lfw_outer_aligned_poisson lfw_outer_linear_poisson.out
		python eval.py lfw_linear_features/classifire.pkl lfw_outer_aligned lfw_outer_aligned_speckle25 lfw_outer_linear_speckle25.out
		python eval.py lfw_linear_features/classifier.pkl lfw_outer_aligned lfw_outer_aligned_speckle50 lfw_outer_linear_speckle50.out
		python eval.py lfw_linear_features/classifier.pkl lfw_outer_aligned lfw_outer_aligned_speckle100 lfw_outer_linear_speckle100.out

# 		"feature_directory/classifier.pkl"
# # make the feature directory
# classifiers = ("LinearSvm", "GridSearchSvm", "GMM", "RadialSvm", "DecisionTree", "GaussianNB", "DBN")
# for i in "${classifiers[@]}"
# do
# 	rm -rf lfw_feature_directory
# 	mkdir lfw_feature_directory
# 	./openface/batch-represent/main.lua -outDir lfw_feature_directory -data lfw_outer_aligned 
# 	./openface/demos/classifier.py train -- classifier $CLASSIFIER lfw_feature_directory
# ##########################################
# # we call noise.py 
# ##########################################
# rm -rf noise_output
# mkdir noise_output
# python noise.py lfw_aligned gauss 100 


./openface/demos/classifier.py train --classifier GridSearchSvm lfw_outer_gridsearch_features 

./openface/demos/classifier.py train --classifier GMM features/lfw_outer_gmm_features 
./openface/demos/classifier.py train --classifier RadialSvm features/lfw_outer_radial_features 
./openface/demos/classifier.py train --classifier GaussianNB features/lfw_outer_gaussian_features 
./openface/demos/classifier.py train --classifier DBN features/lfw_outer_dbn_features 

