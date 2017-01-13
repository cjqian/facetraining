# python noise.py data/lfw_inner_aligned gauss lfw_inner_aligned_gauss100 100 
# python noise.py data/lfw_inner_aligned gauss lfw_inner_aligned_gauss500 500 
# python noise.py data/lfw_inner_aligned gauss lfw_inner_aligned_gauss1000 1000 
# python noise.py data/lfw_inner_aligned poisson lfw_inner_aligned_poisson 
# python noise.py data/lfw_inner_aligned speckle lfw_inner_aligned_speckle25 .25 
# python noise.py data/lfw_inner_aligned speckle lfw_inner_aligned_speckle50 .50  
# python noise.py data/lfw_inner_aligned speckle lfw_inner_aligned_speckle100 .100 
now=$(date +"%T")
echo "Current time : $now"
#linear
python eval.py features/lfw_inner_linear_features/classifier.pkl data/lfw_inner_aligned lfw_inner_aligned_gauss100 lfw_inner_linear_gauss100.out linear 
python eval.py features/lfw_inner_linear_features/classifier.pkl data/lfw_inner_aligned lfw_inner_aligned_gauss500 lfw_inner_linear_gauss500.out linear 
python eval.py features/lfw_inner_linear_features/classifier.pkl data/lfw_inner_aligned lfw_inner_aligned_gauss1000 lfw_inner_linear_gauss1000.out linear 
python eval.py features/lfw_inner_linear_features/classifier.pkl data/lfw_inner_aligned lfw_inner_aligned_poisson lfw_inner_linear_poisson.out linear 
python eval.py features/lfw_inner_linear_features/classifier.pkl data/lfw_inner_aligned lfw_inner_aligned_speckle25 lfw_inner_linear_speckle25.out linear 
python eval.py features/lfw_inner_linear_features/classifier.pkl data/lfw_inner_aligned lfw_inner_aligned_speckle100 lfw_inner_linear_speckle100.out linear 
python eval.py features/lfw_inner_linear_features/classifier.pkl data/lfw_inner_aligned lfw_inner_aligned_speckle50 lfw_inner_linear_speckle50.out linear 
end=$(date +"%T")
echo "Current time : $end"
# gmm
python eval.py features/lfw_inner_gmm_features/classifier.pkl data/lfw_inner_aligned lfw_inner_aligned_gauss100 lfw_inner_gmm_gauss100.out gmm 
python eval.py features/lfw_inner_gmm_features/classifier.pkl data/lfw_inner_aligned lfw_inner_aligned_gauss500 lfw_inner_gmm_gauss500.out gmm 
python eval.py features/lfw_inner_gmm_features/classifier.pkl data/lfw_inner_aligned lfw_inner_aligned_gauss1000 lfw_inner_gmm_gauss1000.out gmm 
python eval.py features/lfw_inner_gmm_features/classifier.pkl data/lfw_inner_aligned lfw_inner_aligned_poisson lfw_inner_gmm_poisson.out gmm 
python eval.py features/lfw_inner_gmm_features/classifier.pkl data/lfw_inner_aligned lfw_inner_aligned_speckle25 lfw_inner_gmm_speckle25.out gmm 
python eval.py features/lfw_inner_gmm_features/classifier.pkl data/lfw_inner_aligned lfw_inner_aligned_speckle100 lfw_inner_gmm_speckle100.out gmm 
python eval.py features/lfw_inner_gmm_features/classifier.pkl data/lfw_inner_aligned lfw_inner_aligned_speckle50 lfw_inner_gmm_speckle50.out gmm 
end2=$(date +"%T")
echo "Current time : $end2"
# radial
python eval.py features/lfw_inner_radial_features/classifier.pkl data/lfw_inner_aligned lfw_inner_aligned_gauss100 lfw_inner_radial_gauss100.out radial 
python eval.py features/lfw_inner_radial_features/classifier.pkl data/lfw_inner_aligned lfw_inner_aligned_gauss500 lfw_inner_radial_gauss500.out radial 
python eval.py features/lfw_inner_radial_features/classifier.pkl data/lfw_inner_aligned lfw_inner_aligned_gauss1000 lfw_inner_radial_gauss1000.out radial 
python eval.py features/lfw_inner_radial_features/classifier.pkl data/lfw_inner_aligned lfw_inner_aligned_poisson lfw_inner_radial_poisson.out radial 
python eval.py features/lfw_inner_radial_features/classifier.pkl data/lfw_inner_aligned lfw_inner_aligned_speckle25 lfw_inner_radial_speckle25.out radial 
python eval.py features/lfw_inner_radial_features/classifier.pkl data/lfw_inner_aligned lfw_inner_aligned_speckle100 lfw_inner_radial_speckle100.out radial 
python eval.py features/lfw_inner_radial_features/classifier.pkl data/lfw_inner_aligned lfw_inner_aligned_speckle50 lfw_inner_radial_speckle50.out radial 
end3=$(date +"%T")
echo "Current time : $end3"
# gaussian
python eval.py features/lfw_inner_gaussian_features/classifier.pkl data/lfw_inner_aligned lfw_inner_aligned_gauss100 lfw_inner_gaussian_gauss100.out gaussian 
python eval.py features/lfw_inner_gaussian_features/classifier.pkl data/lfw_inner_aligned lfw_inner_aligned_gauss500 lfw_inner_gaussian_gauss500.out gaussian 
python eval.py features/lfw_inner_gaussian_features/classifier.pkl data/lfw_inner_aligned lfw_inner_aligned_gauss1000 lfw_inner_gaussian_gauss1000.out gaussian 
python eval.py features/lfw_inner_gaussian_features/classifier.pkl data/lfw_inner_aligned lfw_inner_aligned_poisson lfw_inner_gaussian_poisson.out gaussian 
python eval.py features/lfw_inner_gaussian_features/classifier.pkl data/lfw_inner_aligned lfw_inner_aligned_speckle25 lfw_inner_gaussian_speckle25.out gaussian  
python eval.py features/lfw_inner_gaussian_features/classifier.pkl data/lfw_inner_aligned lfw_inner_aligned_speckle100 lfw_inner_gaussian_speckle100.out gaussian   
python eval.py features/lfw_inner_gaussian_features/classifier.pkl data/lfw_inner_aligned lfw_inner_aligned_speckle50 lfw_inner_gaussian_speckle50.out gaussian  
end4=$(date +"%T")
echo "Current time : $end4"
# decision tree
python eval.py features/lfw_inner_decisiontree_features/classifier.pkl data/lfw_inner_aligned lfw_inner_aligned_gauss100 lfw_inner_decisiontree_gauss100.out decisiontree 
python eval.py features/lfw_inner_decisiontree_features/classifier.pkl data/lfw_inner_aligned lfw_inner_aligned_gauss500 lfw_inner_decisiontree_gauss500.out decisiontree 
python eval.py features/lfw_inner_decisiontree_features/classifier.pkl data/lfw_inner_aligned lfw_inner_aligned_gauss1000 lfw_inner_decisiontree_gauss1000.out decisiontree 
python eval.py features/lfw_inner_decisiontree_features/classifier.pkl data/lfw_inner_aligned lfw_inner_aligned_poisson lfw_inner_decisiontree_poisson.out decisiontree 
python eval.py features/lfw_inner_decisiontree_features/classifier.pkl data/lfw_inner_aligned lfw_inner_aligned_speckle25 lfw_inner_decisiontree_speckle25.out decisiontree 
python eval.py features/lfw_inner_decisiontree_features/classifier.pkl data/lfw_inner_aligned lfw_inner_aligned_speckle100 lfw_inner_decisiontree_speckle100.out decisiontree 
python eval.py features/lfw_inner_decisiontree_features/classifier.pkl data/lfw_inner_aligned lfw_inner_aligned_speckle50 lfw_inner_decisiontree_speckle50.out decisiontree 
end6=$(date +"%T")
echo "Current time : $end6"
# dbn
python eval.py features/lfw_inner_dbn_features/classifier.pkl data/lfw_inner_aligned lfw_inner_aligned_gauss100 lfw_inner_dbn_gauss100.out dbn 
python eval.py features/lfw_inner_dbn_features/classifier.pkl data/lfw_inner_aligned lfw_inner_aligned_gauss500 lfw_inner_dbn_gauss500.out dbn 
python eval.py features/lfw_inner_dbn_features/classifier.pkl data/lfw_inner_aligned lfw_inner_aligned_gauss1000 lfw_inner_dbn_gauss1000.out dbn 
python eval.py features/lfw_inner_dbn_features/classifier.pkl data/lfw_inner_aligned lfw_inner_aligned_poisson lfw_inner_dbn_poisson.out dbn 
python eval.py features/lfw_inner_dbn_features/classifier.pkl data/lfw_inner_aligned lfw_inner_aligned_speckle25 lfw_inner_dbn_speckle25.out dbn 
python eval.py features/lfw_inner_dbn_features/classifier.pkl data/lfw_inner_aligned lfw_inner_aligned_speckle100 lfw_inner_dbn_speckle100.out dbn 
python eval.py features/lfw_inner_dbn_features/classifier.pkl data/lfw_inner_aligned lfw_inner_aligned_speckle50 lfw_inner_dbn_speckle50.out dbn 
end5=$(date +"%T")
echo "Current time : $end5"