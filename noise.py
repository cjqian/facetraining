
import numpy as np
import os
import cv2
import sys


# Parameters
# ----------
# image : ndarray
#     Input image data. Will be converted to float.
# mode : str
#     One of the following strings, selecting the type of noise to add:

#     'gauss'     Gaussian-distributed additive noise.
#     'poisson'   Poisson-distributed noise generated from the data.
#     's&p'       Replaces random pixels with 0 or 1.
#     'speckle'   Multiplicative noise using out = image + n*image,where
#                 n is uniform noise with specified mean & variance.
# Adapted from http://stackoverflow.com/questions/22937589/how-to-add-noise-gaussian-salt-and-pepper-etc-to-image-in-python-with-opencv
def noisy(noise_typ,image):
  if noise_typ == "gauss":
      row,col,ch= image.shape
      mean = 1
      var = 100
      sigma = var**0.5
      gauss = np.random.normal(mean,sigma,(row,col,ch))
      gauss = gauss.reshape(row,col,ch)
      noisy = image + gauss
      return noisy
  elif noise_typ == "sp":
      row,col,ch = image.shape
      s_vs_p = 0.5
      amount = 0.004
      out = np.copy(image)
      # Salt mode
      num_salt = np.ceil(amount * image.size * s_vs_p)
      coords = [np.random.randint(0, i - 1, int(num_salt))
              for i in image.shape]
      out[coords] = 1

      # Pepper mode
      num_pepper = np.ceil(amount* image.size * (1. - s_vs_p))
      coords = [np.random.randint(0, i - 1, int(num_pepper))
              for i in image.shape]
      out[coords] = 0
      return out
  elif noise_typ == "poisson":
      vals = len(np.unique(image))
      vals = np.ceil(np.log2(vals))
      noisy = np.random.poisson(image * vals) / float(vals)
      return noisy
  elif noise_typ =="speckle":
      row,col,ch = image.shape
      gauss = np.random.randn(row,col,ch)
      gauss = gauss.reshape(row,col,ch)        
      noisy = image + image * gauss
      return noisy


# image_path = sys.argv[1]
# image = cv2.imread(image_path)

# noise_type = sys.argv[2]

# output_path = sys.argv[3]

# output_image = noisy(noise_type, image)
# cv2.imwrite(output_path, output_image)


# Parameters
# ___________
# input_dir: str
#   Input directory. Will recursively add noise to each image in the input directory.
# will write to directory noise_output
# mode

base_dir = "noise_output/"

def noisy_directory(input_dir, noise_typ):
  print "adding noise " + noise_typ + " to directory " + input_dir 
  subdirectories = [x[0] for x in os.walk(input_dir)][1:]
  for subdirectory in subdirectories:
      sub_dir = base_dir + subdirectory
      if not os.path.exists(sub_dir):
        os.makedirs(sub_dir)

      for item in os.listdir(subdirectory):
        item_path = subdirectory + "/" + item
        output_path = base_dir + item_path
        image = cv2.imread(item_path)
        output_image = noisy(noise_typ, image)
        cv2.imwrite(output_path, output_image)
  print "done"
noisy_directory(sys.argv[1], sys.argv[2])
