# Neural-Networks
Parameterized Neural Network Implementation

This project is a simple parameterized neural network implementation. I used this for my Machine Learning Class. 

## Usage 
- _mnist_loader.py_ is used for loading data.
- _test.py_ is used for a example for using NN class
- _NN.py_ is the class for Neural Networks.

In the report, you can find my comment and our results for this implementation.

## Imports

- You need to use numpy and matplotlib.pyplot

## Dataset
- MNIST dataset http://yann.lecun.com/exdb/mnist/ contains handwritten digits and corresponding labels. Dataset contains 60000 training and 10000 test images.
- Dataset and the code to load it are provided to you. You can donwload them from ftp://cs.hacettepe.edu.tr/pub/dersler/BBM4XX/BBM409_ML/Assignment_3/load/. The dataset is split into three sets: Training (50000 images), test (10000 images)and validation (10000 images). You can use validation set for training (50000+10000 images).
- When you load the dataset, you’ll see that every image is represented with [784x1] vector and has a label. You’ll use the given representation (do not have to extract new features).
