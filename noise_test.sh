##########################################
# this part sets up the learning
##########################################

# first, preprocess (make the alignment)
rm -rf lfw_aligned
mkdir lfw_aligned
for N in {1..8}; do ./openface/util/align-dlib.py lfw/ align outerEyesAndNose lfw_aligned --size 96 & done

# make the feature directory
rm -rf feature_directory
mkdir feature_directory

./openface/batch-represent/main.lua -outDir feature_directory -data lfw_aligned 
./openface/demos/classifier.py train feature_directory

##########################################
# we call noise.py 
##########################################
rm -rf noise_output
mkdir noise_output
python noise.py lfw_aligned gauss
