---
title: Image Caption Generation
summary: Automatic Image Caption Generation model that uses a CNN to condition a LSTM based language model.
tags:
- Machine Learning
- Deep Learning
- Natural Language Processing
date: "2020-12-20"

# Optional external URL for project (replaces project detail page).
external_link: ""

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder. 
image:
  caption: "Image from paper [Show, Attend and Tell](https://arxiv.org/pdf/1502.03044.pdf)"
  focal_point: ""
  preview_only: false
  alt_text: "Image Caption Generation"

links:
url_code: https://github.com/juletx/image-caption-generation
url_pdf: "https://github.com/juletx/image-caption-generation/blob/main/report/Report_P71_Caption_Generation.pdf"
url_slides: "https://github.com/juletx/image-caption-generation/blob/main/slides/Slides_P71_Caption_Generation.pdf"
url_video: ""
---

# Project 71: Automatic Image Caption Generation

## Authors: Oihane Cantero and Julen Etxaniz

## Supervisors: Oier Lopez de Lacalle and Eneko Agirre

## Subject: Machine Learning and Neural Networks

## Date: 20-12-2020

## Objective: Implement a caption generation model that uses a CNN to condition a LSTM based language model.

## Contents:
### [1.Import Libraries](#1-import-libraries)
### [2.Get Dataset](#2-get-dataset)
### [3.Prepare Photo Data](#3-prepare-photo-data)
### [4.Prepare Text Data](#4-prepare-text-data)
### [5.Load Data](#5-load-data)
### [6.Encode Text Data](#6-encode-text-data)
### [7.Define Model](#7-define-model)
### [8.Fit Model](#8-fit-model)
### [9.Evaluate Model](#9-evaluate-model)
### [10.Generate Captions](#10-generate-captions)

## References
[1] https://arxiv.org/pdf/1411.4555.pdf

[2] https://machinelearningmastery.com/develop-a-deep-learning-caption-generation-model-in-python/

[3] https://github.com/dabasajay/Image-Caption-Generator

[4] https://github.com/yashk2810/Image-Captioning

# 1. Import Libraries


```python
# Prepare Photo Data
from os import listdir
from os.path import isfile
from pickle import dump
from tqdm import tqdm
from keras.models import Model
from keras.applications.vgg16 import VGG16
from keras.applications.inception_v3 import InceptionV3
from keras.preprocessing.image import load_img
from keras.preprocessing.image import img_to_array
import matplotlib.pyplot as plt

# Prepare Text Data
import string

# Load Data
from pickle import load

# Encode Text Data
from keras.preprocessing.text import Tokenizer

# Define Model
from keras.utils import plot_model
from keras.models import Model
from keras.models import load_model
from keras.layers import Input
from keras.layers import Dense
from keras.layers import LSTM
from keras.layers import Embedding
from keras.layers import Dropout
from keras.layers.merge import add
from keras.layers import RepeatVector, TimeDistributed, concatenate, Bidirectional

# Fit Model
import numpy as np
from keras.preprocessing.sequence import pad_sequences
from keras.utils import to_categorical

# Evaluate Model
from numpy import argmax, argsort
from nltk.translate.bleu_score import corpus_bleu, sentence_bleu, SmoothingFunction

# Generate Captions
from IPython.display import Image, display
```

# 2. Get Dataset

We decided to use Flickr8k Dataset. It can be downloaded from: https://github.com/jbrownlee/Datasets/releases/tag/Flickr8k

It has 8092 images and 5 captions for each image. Each image has 5 captions because obviously, there are different ways to caption an image. This dataset has predefined training, testing and evaluation subsets of 6000, 1000 and 1000 images respectively.

# 3. Prepare Photo Data
Two different models to extract image features: VGG16 and InceptionV3.


```python
# preprocess the image for the model
def preprocess_image(filename, image_size):
    image = load_img(filename, target_size=(image_size, image_size))
    # convert the image pixels to a numpy array
    image = img_to_array(image)
    # reshape data for the model
    image = image.reshape((1, image.shape[0], image.shape[1], image.shape[2]))
    # prepare the image for the model
    image = preprocess_input(image)
    return image
```


```python
# extract features from each photo in the directory
def extract_features(directory, model, image_size):
    # extract features from each photo
    features = dict()
    for name in tqdm(listdir(directory), position=0, leave=True):
        # load an image from file
        filename = directory + '/' + name
        # preprocess the image for the model
        image = preprocess_image(filename, image_size)
        # get features
        feature = model.predict(image, verbose=0)
        # get image id
        image_id = name.split('.')[0]
        # store feature
        features[image_id] = feature
    return features
```


```python
def plot(model, filename):
    plot_model(model, to_file=filename, show_shapes=True, show_layer_names=False)
    display(Image(filename))
```

## 3.1. VGG16 Model


```python
from keras.applications.vgg16 import preprocess_input
```


```python
# cnn VGG16 model
def cnn_vgg16():
    # load the model
    model = VGG16()
    # re-structure the model
    model = Model(inputs=model.inputs, outputs=model.layers[-2].output)
    # summarize
    print(model.summary())
    return model
```


```python
# get cnn vgg16 model
cnn_vgg16 = cnn_vgg16()
```

    Downloading data from https://storage.googleapis.com/tensorflow/keras-applications/vgg16/vgg16_weights_tf_dim_ordering_tf_kernels.h5
    553467904/553467096 [==============================] - 4s 0us/step
    Model: "model"
    _________________________________________________________________
    Layer (type)                 Output Shape              Param #   
    =================================================================
    input_1 (InputLayer)         [(None, 224, 224, 3)]     0         
    _________________________________________________________________
    block1_conv1 (Conv2D)        (None, 224, 224, 64)      1792      
    _________________________________________________________________
    block1_conv2 (Conv2D)        (None, 224, 224, 64)      36928     
    _________________________________________________________________
    block1_pool (MaxPooling2D)   (None, 112, 112, 64)      0         
    _________________________________________________________________
    block2_conv1 (Conv2D)        (None, 112, 112, 128)     73856     
    _________________________________________________________________
    block2_conv2 (Conv2D)        (None, 112, 112, 128)     147584    
    _________________________________________________________________
    block2_pool (MaxPooling2D)   (None, 56, 56, 128)       0         
    _________________________________________________________________
    block3_conv1 (Conv2D)        (None, 56, 56, 256)       295168    
    _________________________________________________________________
    block3_conv2 (Conv2D)        (None, 56, 56, 256)       590080    
    _________________________________________________________________
    block3_conv3 (Conv2D)        (None, 56, 56, 256)       590080    
    _________________________________________________________________
    block3_pool (MaxPooling2D)   (None, 28, 28, 256)       0         
    _________________________________________________________________
    block4_conv1 (Conv2D)        (None, 28, 28, 512)       1180160   
    _________________________________________________________________
    block4_conv2 (Conv2D)        (None, 28, 28, 512)       2359808   
    _________________________________________________________________
    block4_conv3 (Conv2D)        (None, 28, 28, 512)       2359808   
    _________________________________________________________________
    block4_pool (MaxPooling2D)   (None, 14, 14, 512)       0         
    _________________________________________________________________
    block5_conv1 (Conv2D)        (None, 14, 14, 512)       2359808   
    _________________________________________________________________
    block5_conv2 (Conv2D)        (None, 14, 14, 512)       2359808   
    _________________________________________________________________
    block5_conv3 (Conv2D)        (None, 14, 14, 512)       2359808   
    _________________________________________________________________
    block5_pool (MaxPooling2D)   (None, 7, 7, 512)         0         
    _________________________________________________________________
    flatten (Flatten)            (None, 25088)             0         
    _________________________________________________________________
    fc1 (Dense)                  (None, 4096)              102764544 
    _________________________________________________________________
    fc2 (Dense)                  (None, 4096)              16781312  
    =================================================================
    Total params: 134,260,544
    Trainable params: 134,260,544
    Non-trainable params: 0
    _________________________________________________________________
    None



```python
# plot model
filename = 'models/cnn_vgg16.png'
plot(cnn_vgg16, filename)
```


{{< figure src="images/output_13_0.png" alt="VGG16 Model" caption="VGG16 Model" numbered="true">}}


```python
filename = 'files/features_vgg16.pkl'
# only extract if file does not exist
if not isfile(filename):
    # extract features from all images
    directory = 'Flickr8k_Dataset'
    features = extract_features(directory, cnn_vgg16, 224)
    # save to file
    dump(features, open(filename, 'wb'))
```


```python
# display original and preprocessed image
example_image = "Flickr8k_Dataset/667626_18933d713e.jpg"
display(Image(example_image))
image = preprocess_image(example_image, 224)
plt.imshow(np.squeeze(image))
```

{{< figure src="images/output_15_0.jpeg" alt="Example image" caption="Example image" numbered="true">}}

{{< figure src="images/output_15_3.png" alt="Example image preprocessed for VGG16" caption="Example image preprocessed for VGG16" numbered="true">}}

## 3.2. InceptionV3 Model


```python
from keras.applications.inception_v3 import preprocess_input
```


```python
# cnn InceptionV3 model
def cnn_inceptionv3():
    # load the model
    model = InceptionV3(weights='imagenet')
    # re-structure the model
    model = Model(inputs=model.inputs, outputs=model.layers[-2].output)
    # summarize
    print(model.summary())
    return model
```


```python
# get cnn inceptionv3 model
cnn_inceptionv3 = cnn_inceptionv3()
```

    Downloading data from https://storage.googleapis.com/tensorflow/keras-applications/inception_v3/inception_v3_weights_tf_dim_ordering_tf_kernels.h5
    96116736/96112376 [==============================] - 0s 0us/step
    Model: "model"
    __________________________________________________________________________________________________
    Layer (type)                    Output Shape         Param #     Connected to                     
    ==================================================================================================
    input_1 (InputLayer)            [(None, 299, 299, 3) 0                                            
    __________________________________________________________________________________________________
    conv2d (Conv2D)                 (None, 149, 149, 32) 864         input_1[0][0]                    
    __________________________________________________________________________________________________
    batch_normalization (BatchNorma (None, 149, 149, 32) 96          conv2d[0][0]                     
    __________________________________________________________________________________________________
    activation (Activation)         (None, 149, 149, 32) 0           batch_normalization[0][0]        
    __________________________________________________________________________________________________
    conv2d_1 (Conv2D)               (None, 147, 147, 32) 9216        activation[0][0]                 
    __________________________________________________________________________________________________
    batch_normalization_1 (BatchNor (None, 147, 147, 32) 96          conv2d_1[0][0]                   
    __________________________________________________________________________________________________
    activation_1 (Activation)       (None, 147, 147, 32) 0           batch_normalization_1[0][0]      
    __________________________________________________________________________________________________
    conv2d_2 (Conv2D)               (None, 147, 147, 64) 18432       activation_1[0][0]               
    __________________________________________________________________________________________________
    batch_normalization_2 (BatchNor (None, 147, 147, 64) 192         conv2d_2[0][0]                   
    __________________________________________________________________________________________________
    activation_2 (Activation)       (None, 147, 147, 64) 0           batch_normalization_2[0][0]      
    __________________________________________________________________________________________________
    max_pooling2d (MaxPooling2D)    (None, 73, 73, 64)   0           activation_2[0][0]               
    __________________________________________________________________________________________________
    conv2d_3 (Conv2D)               (None, 73, 73, 80)   5120        max_pooling2d[0][0]              
    __________________________________________________________________________________________________
    batch_normalization_3 (BatchNor (None, 73, 73, 80)   240         conv2d_3[0][0]                   
    __________________________________________________________________________________________________
    activation_3 (Activation)       (None, 73, 73, 80)   0           batch_normalization_3[0][0]      
    __________________________________________________________________________________________________
    conv2d_4 (Conv2D)               (None, 71, 71, 192)  138240      activation_3[0][0]               
    __________________________________________________________________________________________________
    batch_normalization_4 (BatchNor (None, 71, 71, 192)  576         conv2d_4[0][0]                   
    __________________________________________________________________________________________________
    activation_4 (Activation)       (None, 71, 71, 192)  0           batch_normalization_4[0][0]      
    __________________________________________________________________________________________________
    max_pooling2d_1 (MaxPooling2D)  (None, 35, 35, 192)  0           activation_4[0][0]               
    __________________________________________________________________________________________________
    conv2d_8 (Conv2D)               (None, 35, 35, 64)   12288       max_pooling2d_1[0][0]            
    __________________________________________________________________________________________________
    batch_normalization_8 (BatchNor (None, 35, 35, 64)   192         conv2d_8[0][0]                   
    __________________________________________________________________________________________________
    activation_8 (Activation)       (None, 35, 35, 64)   0           batch_normalization_8[0][0]      
    __________________________________________________________________________________________________
    conv2d_6 (Conv2D)               (None, 35, 35, 48)   9216        max_pooling2d_1[0][0]            
    __________________________________________________________________________________________________
    conv2d_9 (Conv2D)               (None, 35, 35, 96)   55296       activation_8[0][0]               
    __________________________________________________________________________________________________
    batch_normalization_6 (BatchNor (None, 35, 35, 48)   144         conv2d_6[0][0]                   
    __________________________________________________________________________________________________
    batch_normalization_9 (BatchNor (None, 35, 35, 96)   288         conv2d_9[0][0]                   
    __________________________________________________________________________________________________
    activation_6 (Activation)       (None, 35, 35, 48)   0           batch_normalization_6[0][0]      
    __________________________________________________________________________________________________
    activation_9 (Activation)       (None, 35, 35, 96)   0           batch_normalization_9[0][0]      
    __________________________________________________________________________________________________
    average_pooling2d (AveragePooli (None, 35, 35, 192)  0           max_pooling2d_1[0][0]            
    __________________________________________________________________________________________________
    conv2d_5 (Conv2D)               (None, 35, 35, 64)   12288       max_pooling2d_1[0][0]            
    __________________________________________________________________________________________________
    conv2d_7 (Conv2D)               (None, 35, 35, 64)   76800       activation_6[0][0]               
    __________________________________________________________________________________________________
    conv2d_10 (Conv2D)              (None, 35, 35, 96)   82944       activation_9[0][0]               
    __________________________________________________________________________________________________
    conv2d_11 (Conv2D)              (None, 35, 35, 32)   6144        average_pooling2d[0][0]          
    __________________________________________________________________________________________________
    batch_normalization_5 (BatchNor (None, 35, 35, 64)   192         conv2d_5[0][0]                   
    __________________________________________________________________________________________________
    batch_normalization_7 (BatchNor (None, 35, 35, 64)   192         conv2d_7[0][0]                   
    __________________________________________________________________________________________________
    batch_normalization_10 (BatchNo (None, 35, 35, 96)   288         conv2d_10[0][0]                  
    __________________________________________________________________________________________________
    batch_normalization_11 (BatchNo (None, 35, 35, 32)   96          conv2d_11[0][0]                  
    __________________________________________________________________________________________________
    activation_5 (Activation)       (None, 35, 35, 64)   0           batch_normalization_5[0][0]      
    __________________________________________________________________________________________________
    activation_7 (Activation)       (None, 35, 35, 64)   0           batch_normalization_7[0][0]      
    __________________________________________________________________________________________________
    activation_10 (Activation)      (None, 35, 35, 96)   0           batch_normalization_10[0][0]     
    __________________________________________________________________________________________________
    activation_11 (Activation)      (None, 35, 35, 32)   0           batch_normalization_11[0][0]     
    __________________________________________________________________________________________________
    mixed0 (Concatenate)            (None, 35, 35, 256)  0           activation_5[0][0]               
                                                                     activation_7[0][0]               
                                                                     activation_10[0][0]              
                                                                     activation_11[0][0]              
    __________________________________________________________________________________________________
    conv2d_15 (Conv2D)              (None, 35, 35, 64)   16384       mixed0[0][0]                     
    __________________________________________________________________________________________________
    batch_normalization_15 (BatchNo (None, 35, 35, 64)   192         conv2d_15[0][0]                  
    __________________________________________________________________________________________________
    activation_15 (Activation)      (None, 35, 35, 64)   0           batch_normalization_15[0][0]     
    __________________________________________________________________________________________________
    conv2d_13 (Conv2D)              (None, 35, 35, 48)   12288       mixed0[0][0]                     
    __________________________________________________________________________________________________
    conv2d_16 (Conv2D)              (None, 35, 35, 96)   55296       activation_15[0][0]              
    __________________________________________________________________________________________________
    batch_normalization_13 (BatchNo (None, 35, 35, 48)   144         conv2d_13[0][0]                  
    __________________________________________________________________________________________________
    batch_normalization_16 (BatchNo (None, 35, 35, 96)   288         conv2d_16[0][0]                  
    __________________________________________________________________________________________________
    activation_13 (Activation)      (None, 35, 35, 48)   0           batch_normalization_13[0][0]     
    __________________________________________________________________________________________________
    activation_16 (Activation)      (None, 35, 35, 96)   0           batch_normalization_16[0][0]     
    __________________________________________________________________________________________________
    average_pooling2d_1 (AveragePoo (None, 35, 35, 256)  0           mixed0[0][0]                     
    __________________________________________________________________________________________________
    conv2d_12 (Conv2D)              (None, 35, 35, 64)   16384       mixed0[0][0]                     
    __________________________________________________________________________________________________
    conv2d_14 (Conv2D)              (None, 35, 35, 64)   76800       activation_13[0][0]              
    __________________________________________________________________________________________________
    conv2d_17 (Conv2D)              (None, 35, 35, 96)   82944       activation_16[0][0]              
    __________________________________________________________________________________________________
    conv2d_18 (Conv2D)              (None, 35, 35, 64)   16384       average_pooling2d_1[0][0]        
    __________________________________________________________________________________________________
    batch_normalization_12 (BatchNo (None, 35, 35, 64)   192         conv2d_12[0][0]                  
    __________________________________________________________________________________________________
    batch_normalization_14 (BatchNo (None, 35, 35, 64)   192         conv2d_14[0][0]                  
    __________________________________________________________________________________________________
    batch_normalization_17 (BatchNo (None, 35, 35, 96)   288         conv2d_17[0][0]                  
    __________________________________________________________________________________________________
    batch_normalization_18 (BatchNo (None, 35, 35, 64)   192         conv2d_18[0][0]                  
    __________________________________________________________________________________________________
    activation_12 (Activation)      (None, 35, 35, 64)   0           batch_normalization_12[0][0]     
    __________________________________________________________________________________________________
    activation_14 (Activation)      (None, 35, 35, 64)   0           batch_normalization_14[0][0]     
    __________________________________________________________________________________________________
    activation_17 (Activation)      (None, 35, 35, 96)   0           batch_normalization_17[0][0]     
    __________________________________________________________________________________________________
    activation_18 (Activation)      (None, 35, 35, 64)   0           batch_normalization_18[0][0]     
    __________________________________________________________________________________________________
    mixed1 (Concatenate)            (None, 35, 35, 288)  0           activation_12[0][0]              
                                                                     activation_14[0][0]              
                                                                     activation_17[0][0]              
                                                                     activation_18[0][0]              
    __________________________________________________________________________________________________
    conv2d_22 (Conv2D)              (None, 35, 35, 64)   18432       mixed1[0][0]                     
    __________________________________________________________________________________________________
    batch_normalization_22 (BatchNo (None, 35, 35, 64)   192         conv2d_22[0][0]                  
    __________________________________________________________________________________________________
    activation_22 (Activation)      (None, 35, 35, 64)   0           batch_normalization_22[0][0]     
    __________________________________________________________________________________________________
    conv2d_20 (Conv2D)              (None, 35, 35, 48)   13824       mixed1[0][0]                     
    __________________________________________________________________________________________________
    conv2d_23 (Conv2D)              (None, 35, 35, 96)   55296       activation_22[0][0]              
    __________________________________________________________________________________________________
    batch_normalization_20 (BatchNo (None, 35, 35, 48)   144         conv2d_20[0][0]                  
    __________________________________________________________________________________________________
    batch_normalization_23 (BatchNo (None, 35, 35, 96)   288         conv2d_23[0][0]                  
    __________________________________________________________________________________________________
    activation_20 (Activation)      (None, 35, 35, 48)   0           batch_normalization_20[0][0]     
    __________________________________________________________________________________________________
    activation_23 (Activation)      (None, 35, 35, 96)   0           batch_normalization_23[0][0]     
    __________________________________________________________________________________________________
    average_pooling2d_2 (AveragePoo (None, 35, 35, 288)  0           mixed1[0][0]                     
    __________________________________________________________________________________________________
    conv2d_19 (Conv2D)              (None, 35, 35, 64)   18432       mixed1[0][0]                     
    __________________________________________________________________________________________________
    conv2d_21 (Conv2D)              (None, 35, 35, 64)   76800       activation_20[0][0]              
    __________________________________________________________________________________________________
    conv2d_24 (Conv2D)              (None, 35, 35, 96)   82944       activation_23[0][0]              
    __________________________________________________________________________________________________
    conv2d_25 (Conv2D)              (None, 35, 35, 64)   18432       average_pooling2d_2[0][0]        
    __________________________________________________________________________________________________
    batch_normalization_19 (BatchNo (None, 35, 35, 64)   192         conv2d_19[0][0]                  
    __________________________________________________________________________________________________
    batch_normalization_21 (BatchNo (None, 35, 35, 64)   192         conv2d_21[0][0]                  
    __________________________________________________________________________________________________
    batch_normalization_24 (BatchNo (None, 35, 35, 96)   288         conv2d_24[0][0]                  
    __________________________________________________________________________________________________
    batch_normalization_25 (BatchNo (None, 35, 35, 64)   192         conv2d_25[0][0]                  
    __________________________________________________________________________________________________
    activation_19 (Activation)      (None, 35, 35, 64)   0           batch_normalization_19[0][0]     
    __________________________________________________________________________________________________
    activation_21 (Activation)      (None, 35, 35, 64)   0           batch_normalization_21[0][0]     
    __________________________________________________________________________________________________
    activation_24 (Activation)      (None, 35, 35, 96)   0           batch_normalization_24[0][0]     
    __________________________________________________________________________________________________
    activation_25 (Activation)      (None, 35, 35, 64)   0           batch_normalization_25[0][0]     
    __________________________________________________________________________________________________
    mixed2 (Concatenate)            (None, 35, 35, 288)  0           activation_19[0][0]              
                                                                     activation_21[0][0]              
                                                                     activation_24[0][0]              
                                                                     activation_25[0][0]              
    __________________________________________________________________________________________________
    conv2d_27 (Conv2D)              (None, 35, 35, 64)   18432       mixed2[0][0]                     
    __________________________________________________________________________________________________
    batch_normalization_27 (BatchNo (None, 35, 35, 64)   192         conv2d_27[0][0]                  
    __________________________________________________________________________________________________
    activation_27 (Activation)      (None, 35, 35, 64)   0           batch_normalization_27[0][0]     
    __________________________________________________________________________________________________
    conv2d_28 (Conv2D)              (None, 35, 35, 96)   55296       activation_27[0][0]              
    __________________________________________________________________________________________________
    batch_normalization_28 (BatchNo (None, 35, 35, 96)   288         conv2d_28[0][0]                  
    __________________________________________________________________________________________________
    activation_28 (Activation)      (None, 35, 35, 96)   0           batch_normalization_28[0][0]     
    __________________________________________________________________________________________________
    conv2d_26 (Conv2D)              (None, 17, 17, 384)  995328      mixed2[0][0]                     
    __________________________________________________________________________________________________
    conv2d_29 (Conv2D)              (None, 17, 17, 96)   82944       activation_28[0][0]              
    __________________________________________________________________________________________________
    batch_normalization_26 (BatchNo (None, 17, 17, 384)  1152        conv2d_26[0][0]                  
    __________________________________________________________________________________________________
    batch_normalization_29 (BatchNo (None, 17, 17, 96)   288         conv2d_29[0][0]                  
    __________________________________________________________________________________________________
    activation_26 (Activation)      (None, 17, 17, 384)  0           batch_normalization_26[0][0]     
    __________________________________________________________________________________________________
    activation_29 (Activation)      (None, 17, 17, 96)   0           batch_normalization_29[0][0]     
    __________________________________________________________________________________________________
    max_pooling2d_2 (MaxPooling2D)  (None, 17, 17, 288)  0           mixed2[0][0]                     
    __________________________________________________________________________________________________
    mixed3 (Concatenate)            (None, 17, 17, 768)  0           activation_26[0][0]              
                                                                     activation_29[0][0]              
                                                                     max_pooling2d_2[0][0]            
    __________________________________________________________________________________________________
    conv2d_34 (Conv2D)              (None, 17, 17, 128)  98304       mixed3[0][0]                     
    __________________________________________________________________________________________________
    batch_normalization_34 (BatchNo (None, 17, 17, 128)  384         conv2d_34[0][0]                  
    __________________________________________________________________________________________________
    activation_34 (Activation)      (None, 17, 17, 128)  0           batch_normalization_34[0][0]     
    __________________________________________________________________________________________________
    conv2d_35 (Conv2D)              (None, 17, 17, 128)  114688      activation_34[0][0]              
    __________________________________________________________________________________________________
    batch_normalization_35 (BatchNo (None, 17, 17, 128)  384         conv2d_35[0][0]                  
    __________________________________________________________________________________________________
    activation_35 (Activation)      (None, 17, 17, 128)  0           batch_normalization_35[0][0]     
    __________________________________________________________________________________________________
    conv2d_31 (Conv2D)              (None, 17, 17, 128)  98304       mixed3[0][0]                     
    __________________________________________________________________________________________________
    conv2d_36 (Conv2D)              (None, 17, 17, 128)  114688      activation_35[0][0]              
    __________________________________________________________________________________________________
    batch_normalization_31 (BatchNo (None, 17, 17, 128)  384         conv2d_31[0][0]                  
    __________________________________________________________________________________________________
    batch_normalization_36 (BatchNo (None, 17, 17, 128)  384         conv2d_36[0][0]                  
    __________________________________________________________________________________________________
    activation_31 (Activation)      (None, 17, 17, 128)  0           batch_normalization_31[0][0]     
    __________________________________________________________________________________________________
    activation_36 (Activation)      (None, 17, 17, 128)  0           batch_normalization_36[0][0]     
    __________________________________________________________________________________________________
    conv2d_32 (Conv2D)              (None, 17, 17, 128)  114688      activation_31[0][0]              
    __________________________________________________________________________________________________
    conv2d_37 (Conv2D)              (None, 17, 17, 128)  114688      activation_36[0][0]              
    __________________________________________________________________________________________________
    batch_normalization_32 (BatchNo (None, 17, 17, 128)  384         conv2d_32[0][0]                  
    __________________________________________________________________________________________________
    batch_normalization_37 (BatchNo (None, 17, 17, 128)  384         conv2d_37[0][0]                  
    __________________________________________________________________________________________________
    activation_32 (Activation)      (None, 17, 17, 128)  0           batch_normalization_32[0][0]     
    __________________________________________________________________________________________________
    activation_37 (Activation)      (None, 17, 17, 128)  0           batch_normalization_37[0][0]     
    __________________________________________________________________________________________________
    average_pooling2d_3 (AveragePoo (None, 17, 17, 768)  0           mixed3[0][0]                     
    __________________________________________________________________________________________________
    conv2d_30 (Conv2D)              (None, 17, 17, 192)  147456      mixed3[0][0]                     
    __________________________________________________________________________________________________
    conv2d_33 (Conv2D)              (None, 17, 17, 192)  172032      activation_32[0][0]              
    __________________________________________________________________________________________________
    conv2d_38 (Conv2D)              (None, 17, 17, 192)  172032      activation_37[0][0]              
    __________________________________________________________________________________________________
    conv2d_39 (Conv2D)              (None, 17, 17, 192)  147456      average_pooling2d_3[0][0]        
    __________________________________________________________________________________________________
    batch_normalization_30 (BatchNo (None, 17, 17, 192)  576         conv2d_30[0][0]                  
    __________________________________________________________________________________________________
    batch_normalization_33 (BatchNo (None, 17, 17, 192)  576         conv2d_33[0][0]                  
    __________________________________________________________________________________________________
    batch_normalization_38 (BatchNo (None, 17, 17, 192)  576         conv2d_38[0][0]                  
    __________________________________________________________________________________________________
    batch_normalization_39 (BatchNo (None, 17, 17, 192)  576         conv2d_39[0][0]                  
    __________________________________________________________________________________________________
    activation_30 (Activation)      (None, 17, 17, 192)  0           batch_normalization_30[0][0]     
    __________________________________________________________________________________________________
    activation_33 (Activation)      (None, 17, 17, 192)  0           batch_normalization_33[0][0]     
    __________________________________________________________________________________________________
    activation_38 (Activation)      (None, 17, 17, 192)  0           batch_normalization_38[0][0]     
    __________________________________________________________________________________________________
    activation_39 (Activation)      (None, 17, 17, 192)  0           batch_normalization_39[0][0]     
    __________________________________________________________________________________________________
    mixed4 (Concatenate)            (None, 17, 17, 768)  0           activation_30[0][0]              
                                                                     activation_33[0][0]              
                                                                     activation_38[0][0]              
                                                                     activation_39[0][0]              
    __________________________________________________________________________________________________
    conv2d_44 (Conv2D)              (None, 17, 17, 160)  122880      mixed4[0][0]                     
    __________________________________________________________________________________________________
    batch_normalization_44 (BatchNo (None, 17, 17, 160)  480         conv2d_44[0][0]                  
    __________________________________________________________________________________________________
    activation_44 (Activation)      (None, 17, 17, 160)  0           batch_normalization_44[0][0]     
    __________________________________________________________________________________________________
    conv2d_45 (Conv2D)              (None, 17, 17, 160)  179200      activation_44[0][0]              
    __________________________________________________________________________________________________
    batch_normalization_45 (BatchNo (None, 17, 17, 160)  480         conv2d_45[0][0]                  
    __________________________________________________________________________________________________
    activation_45 (Activation)      (None, 17, 17, 160)  0           batch_normalization_45[0][0]     
    __________________________________________________________________________________________________
    conv2d_41 (Conv2D)              (None, 17, 17, 160)  122880      mixed4[0][0]                     
    __________________________________________________________________________________________________
    conv2d_46 (Conv2D)              (None, 17, 17, 160)  179200      activation_45[0][0]              
    __________________________________________________________________________________________________
    batch_normalization_41 (BatchNo (None, 17, 17, 160)  480         conv2d_41[0][0]                  
    __________________________________________________________________________________________________
    batch_normalization_46 (BatchNo (None, 17, 17, 160)  480         conv2d_46[0][0]                  
    __________________________________________________________________________________________________
    activation_41 (Activation)      (None, 17, 17, 160)  0           batch_normalization_41[0][0]     
    __________________________________________________________________________________________________
    activation_46 (Activation)      (None, 17, 17, 160)  0           batch_normalization_46[0][0]     
    __________________________________________________________________________________________________
    conv2d_42 (Conv2D)              (None, 17, 17, 160)  179200      activation_41[0][0]              
    __________________________________________________________________________________________________
    conv2d_47 (Conv2D)              (None, 17, 17, 160)  179200      activation_46[0][0]              
    __________________________________________________________________________________________________
    batch_normalization_42 (BatchNo (None, 17, 17, 160)  480         conv2d_42[0][0]                  
    __________________________________________________________________________________________________
    batch_normalization_47 (BatchNo (None, 17, 17, 160)  480         conv2d_47[0][0]                  
    __________________________________________________________________________________________________
    activation_42 (Activation)      (None, 17, 17, 160)  0           batch_normalization_42[0][0]     
    __________________________________________________________________________________________________
    activation_47 (Activation)      (None, 17, 17, 160)  0           batch_normalization_47[0][0]     
    __________________________________________________________________________________________________
    average_pooling2d_4 (AveragePoo (None, 17, 17, 768)  0           mixed4[0][0]                     
    __________________________________________________________________________________________________
    conv2d_40 (Conv2D)              (None, 17, 17, 192)  147456      mixed4[0][0]                     
    __________________________________________________________________________________________________
    conv2d_43 (Conv2D)              (None, 17, 17, 192)  215040      activation_42[0][0]              
    __________________________________________________________________________________________________
    conv2d_48 (Conv2D)              (None, 17, 17, 192)  215040      activation_47[0][0]              
    __________________________________________________________________________________________________
    conv2d_49 (Conv2D)              (None, 17, 17, 192)  147456      average_pooling2d_4[0][0]        
    __________________________________________________________________________________________________
    batch_normalization_40 (BatchNo (None, 17, 17, 192)  576         conv2d_40[0][0]                  
    __________________________________________________________________________________________________
    batch_normalization_43 (BatchNo (None, 17, 17, 192)  576         conv2d_43[0][0]                  
    __________________________________________________________________________________________________
    batch_normalization_48 (BatchNo (None, 17, 17, 192)  576         conv2d_48[0][0]                  
    __________________________________________________________________________________________________
    batch_normalization_49 (BatchNo (None, 17, 17, 192)  576         conv2d_49[0][0]                  
    __________________________________________________________________________________________________
    activation_40 (Activation)      (None, 17, 17, 192)  0           batch_normalization_40[0][0]     
    __________________________________________________________________________________________________
    activation_43 (Activation)      (None, 17, 17, 192)  0           batch_normalization_43[0][0]     
    __________________________________________________________________________________________________
    activation_48 (Activation)      (None, 17, 17, 192)  0           batch_normalization_48[0][0]     
    __________________________________________________________________________________________________
    activation_49 (Activation)      (None, 17, 17, 192)  0           batch_normalization_49[0][0]     
    __________________________________________________________________________________________________
    mixed5 (Concatenate)            (None, 17, 17, 768)  0           activation_40[0][0]              
                                                                     activation_43[0][0]              
                                                                     activation_48[0][0]              
                                                                     activation_49[0][0]              
    __________________________________________________________________________________________________
    conv2d_54 (Conv2D)              (None, 17, 17, 160)  122880      mixed5[0][0]                     
    __________________________________________________________________________________________________
    batch_normalization_54 (BatchNo (None, 17, 17, 160)  480         conv2d_54[0][0]                  
    __________________________________________________________________________________________________
    activation_54 (Activation)      (None, 17, 17, 160)  0           batch_normalization_54[0][0]     
    __________________________________________________________________________________________________
    conv2d_55 (Conv2D)              (None, 17, 17, 160)  179200      activation_54[0][0]              
    __________________________________________________________________________________________________
    batch_normalization_55 (BatchNo (None, 17, 17, 160)  480         conv2d_55[0][0]                  
    __________________________________________________________________________________________________
    activation_55 (Activation)      (None, 17, 17, 160)  0           batch_normalization_55[0][0]     
    __________________________________________________________________________________________________
    conv2d_51 (Conv2D)              (None, 17, 17, 160)  122880      mixed5[0][0]                     
    __________________________________________________________________________________________________
    conv2d_56 (Conv2D)              (None, 17, 17, 160)  179200      activation_55[0][0]              
    __________________________________________________________________________________________________
    batch_normalization_51 (BatchNo (None, 17, 17, 160)  480         conv2d_51[0][0]                  
    __________________________________________________________________________________________________
    batch_normalization_56 (BatchNo (None, 17, 17, 160)  480         conv2d_56[0][0]                  
    __________________________________________________________________________________________________
    activation_51 (Activation)      (None, 17, 17, 160)  0           batch_normalization_51[0][0]     
    __________________________________________________________________________________________________
    activation_56 (Activation)      (None, 17, 17, 160)  0           batch_normalization_56[0][0]     
    __________________________________________________________________________________________________
    conv2d_52 (Conv2D)              (None, 17, 17, 160)  179200      activation_51[0][0]              
    __________________________________________________________________________________________________
    conv2d_57 (Conv2D)              (None, 17, 17, 160)  179200      activation_56[0][0]              
    __________________________________________________________________________________________________
    batch_normalization_52 (BatchNo (None, 17, 17, 160)  480         conv2d_52[0][0]                  
    __________________________________________________________________________________________________
    batch_normalization_57 (BatchNo (None, 17, 17, 160)  480         conv2d_57[0][0]                  
    __________________________________________________________________________________________________
    activation_52 (Activation)      (None, 17, 17, 160)  0           batch_normalization_52[0][0]     
    __________________________________________________________________________________________________
    activation_57 (Activation)      (None, 17, 17, 160)  0           batch_normalization_57[0][0]     
    __________________________________________________________________________________________________
    average_pooling2d_5 (AveragePoo (None, 17, 17, 768)  0           mixed5[0][0]                     
    __________________________________________________________________________________________________
    conv2d_50 (Conv2D)              (None, 17, 17, 192)  147456      mixed5[0][0]                     
    __________________________________________________________________________________________________
    conv2d_53 (Conv2D)              (None, 17, 17, 192)  215040      activation_52[0][0]              
    __________________________________________________________________________________________________
    conv2d_58 (Conv2D)              (None, 17, 17, 192)  215040      activation_57[0][0]              
    __________________________________________________________________________________________________
    conv2d_59 (Conv2D)              (None, 17, 17, 192)  147456      average_pooling2d_5[0][0]        
    __________________________________________________________________________________________________
    batch_normalization_50 (BatchNo (None, 17, 17, 192)  576         conv2d_50[0][0]                  
    __________________________________________________________________________________________________
    batch_normalization_53 (BatchNo (None, 17, 17, 192)  576         conv2d_53[0][0]                  
    __________________________________________________________________________________________________
    batch_normalization_58 (BatchNo (None, 17, 17, 192)  576         conv2d_58[0][0]                  
    __________________________________________________________________________________________________
    batch_normalization_59 (BatchNo (None, 17, 17, 192)  576         conv2d_59[0][0]                  
    __________________________________________________________________________________________________
    activation_50 (Activation)      (None, 17, 17, 192)  0           batch_normalization_50[0][0]     
    __________________________________________________________________________________________________
    activation_53 (Activation)      (None, 17, 17, 192)  0           batch_normalization_53[0][0]     
    __________________________________________________________________________________________________
    activation_58 (Activation)      (None, 17, 17, 192)  0           batch_normalization_58[0][0]     
    __________________________________________________________________________________________________
    activation_59 (Activation)      (None, 17, 17, 192)  0           batch_normalization_59[0][0]     
    __________________________________________________________________________________________________
    mixed6 (Concatenate)            (None, 17, 17, 768)  0           activation_50[0][0]              
                                                                     activation_53[0][0]              
                                                                     activation_58[0][0]              
                                                                     activation_59[0][0]              
    __________________________________________________________________________________________________
    conv2d_64 (Conv2D)              (None, 17, 17, 192)  147456      mixed6[0][0]                     
    __________________________________________________________________________________________________
    batch_normalization_64 (BatchNo (None, 17, 17, 192)  576         conv2d_64[0][0]                  
    __________________________________________________________________________________________________
    activation_64 (Activation)      (None, 17, 17, 192)  0           batch_normalization_64[0][0]     
    __________________________________________________________________________________________________
    conv2d_65 (Conv2D)              (None, 17, 17, 192)  258048      activation_64[0][0]              
    __________________________________________________________________________________________________
    batch_normalization_65 (BatchNo (None, 17, 17, 192)  576         conv2d_65[0][0]                  
    __________________________________________________________________________________________________
    activation_65 (Activation)      (None, 17, 17, 192)  0           batch_normalization_65[0][0]     
    __________________________________________________________________________________________________
    conv2d_61 (Conv2D)              (None, 17, 17, 192)  147456      mixed6[0][0]                     
    __________________________________________________________________________________________________
    conv2d_66 (Conv2D)              (None, 17, 17, 192)  258048      activation_65[0][0]              
    __________________________________________________________________________________________________
    batch_normalization_61 (BatchNo (None, 17, 17, 192)  576         conv2d_61[0][0]                  
    __________________________________________________________________________________________________
    batch_normalization_66 (BatchNo (None, 17, 17, 192)  576         conv2d_66[0][0]                  
    __________________________________________________________________________________________________
    activation_61 (Activation)      (None, 17, 17, 192)  0           batch_normalization_61[0][0]     
    __________________________________________________________________________________________________
    activation_66 (Activation)      (None, 17, 17, 192)  0           batch_normalization_66[0][0]     
    __________________________________________________________________________________________________
    conv2d_62 (Conv2D)              (None, 17, 17, 192)  258048      activation_61[0][0]              
    __________________________________________________________________________________________________
    conv2d_67 (Conv2D)              (None, 17, 17, 192)  258048      activation_66[0][0]              
    __________________________________________________________________________________________________
    batch_normalization_62 (BatchNo (None, 17, 17, 192)  576         conv2d_62[0][0]                  
    __________________________________________________________________________________________________
    batch_normalization_67 (BatchNo (None, 17, 17, 192)  576         conv2d_67[0][0]                  
    __________________________________________________________________________________________________
    activation_62 (Activation)      (None, 17, 17, 192)  0           batch_normalization_62[0][0]     
    __________________________________________________________________________________________________
    activation_67 (Activation)      (None, 17, 17, 192)  0           batch_normalization_67[0][0]     
    __________________________________________________________________________________________________
    average_pooling2d_6 (AveragePoo (None, 17, 17, 768)  0           mixed6[0][0]                     
    __________________________________________________________________________________________________
    conv2d_60 (Conv2D)              (None, 17, 17, 192)  147456      mixed6[0][0]                     
    __________________________________________________________________________________________________
    conv2d_63 (Conv2D)              (None, 17, 17, 192)  258048      activation_62[0][0]              
    __________________________________________________________________________________________________
    conv2d_68 (Conv2D)              (None, 17, 17, 192)  258048      activation_67[0][0]              
    __________________________________________________________________________________________________
    conv2d_69 (Conv2D)              (None, 17, 17, 192)  147456      average_pooling2d_6[0][0]        
    __________________________________________________________________________________________________
    batch_normalization_60 (BatchNo (None, 17, 17, 192)  576         conv2d_60[0][0]                  
    __________________________________________________________________________________________________
    batch_normalization_63 (BatchNo (None, 17, 17, 192)  576         conv2d_63[0][0]                  
    __________________________________________________________________________________________________
    batch_normalization_68 (BatchNo (None, 17, 17, 192)  576         conv2d_68[0][0]                  
    __________________________________________________________________________________________________
    batch_normalization_69 (BatchNo (None, 17, 17, 192)  576         conv2d_69[0][0]                  
    __________________________________________________________________________________________________
    activation_60 (Activation)      (None, 17, 17, 192)  0           batch_normalization_60[0][0]     
    __________________________________________________________________________________________________
    activation_63 (Activation)      (None, 17, 17, 192)  0           batch_normalization_63[0][0]     
    __________________________________________________________________________________________________
    activation_68 (Activation)      (None, 17, 17, 192)  0           batch_normalization_68[0][0]     
    __________________________________________________________________________________________________
    activation_69 (Activation)      (None, 17, 17, 192)  0           batch_normalization_69[0][0]     
    __________________________________________________________________________________________________
    mixed7 (Concatenate)            (None, 17, 17, 768)  0           activation_60[0][0]              
                                                                     activation_63[0][0]              
                                                                     activation_68[0][0]              
                                                                     activation_69[0][0]              
    __________________________________________________________________________________________________
    conv2d_72 (Conv2D)              (None, 17, 17, 192)  147456      mixed7[0][0]                     
    __________________________________________________________________________________________________
    batch_normalization_72 (BatchNo (None, 17, 17, 192)  576         conv2d_72[0][0]                  
    __________________________________________________________________________________________________
    activation_72 (Activation)      (None, 17, 17, 192)  0           batch_normalization_72[0][0]     
    __________________________________________________________________________________________________
    conv2d_73 (Conv2D)              (None, 17, 17, 192)  258048      activation_72[0][0]              
    __________________________________________________________________________________________________
    batch_normalization_73 (BatchNo (None, 17, 17, 192)  576         conv2d_73[0][0]                  
    __________________________________________________________________________________________________
    activation_73 (Activation)      (None, 17, 17, 192)  0           batch_normalization_73[0][0]     
    __________________________________________________________________________________________________
    conv2d_70 (Conv2D)              (None, 17, 17, 192)  147456      mixed7[0][0]                     
    __________________________________________________________________________________________________
    conv2d_74 (Conv2D)              (None, 17, 17, 192)  258048      activation_73[0][0]              
    __________________________________________________________________________________________________
    batch_normalization_70 (BatchNo (None, 17, 17, 192)  576         conv2d_70[0][0]                  
    __________________________________________________________________________________________________
    batch_normalization_74 (BatchNo (None, 17, 17, 192)  576         conv2d_74[0][0]                  
    __________________________________________________________________________________________________
    activation_70 (Activation)      (None, 17, 17, 192)  0           batch_normalization_70[0][0]     
    __________________________________________________________________________________________________
    activation_74 (Activation)      (None, 17, 17, 192)  0           batch_normalization_74[0][0]     
    __________________________________________________________________________________________________
    conv2d_71 (Conv2D)              (None, 8, 8, 320)    552960      activation_70[0][0]              
    __________________________________________________________________________________________________
    conv2d_75 (Conv2D)              (None, 8, 8, 192)    331776      activation_74[0][0]              
    __________________________________________________________________________________________________
    batch_normalization_71 (BatchNo (None, 8, 8, 320)    960         conv2d_71[0][0]                  
    __________________________________________________________________________________________________
    batch_normalization_75 (BatchNo (None, 8, 8, 192)    576         conv2d_75[0][0]                  
    __________________________________________________________________________________________________
    activation_71 (Activation)      (None, 8, 8, 320)    0           batch_normalization_71[0][0]     
    __________________________________________________________________________________________________
    activation_75 (Activation)      (None, 8, 8, 192)    0           batch_normalization_75[0][0]     
    __________________________________________________________________________________________________
    max_pooling2d_3 (MaxPooling2D)  (None, 8, 8, 768)    0           mixed7[0][0]                     
    __________________________________________________________________________________________________
    mixed8 (Concatenate)            (None, 8, 8, 1280)   0           activation_71[0][0]              
                                                                     activation_75[0][0]              
                                                                     max_pooling2d_3[0][0]            
    __________________________________________________________________________________________________
    conv2d_80 (Conv2D)              (None, 8, 8, 448)    573440      mixed8[0][0]                     
    __________________________________________________________________________________________________
    batch_normalization_80 (BatchNo (None, 8, 8, 448)    1344        conv2d_80[0][0]                  
    __________________________________________________________________________________________________
    activation_80 (Activation)      (None, 8, 8, 448)    0           batch_normalization_80[0][0]     
    __________________________________________________________________________________________________
    conv2d_77 (Conv2D)              (None, 8, 8, 384)    491520      mixed8[0][0]                     
    __________________________________________________________________________________________________
    conv2d_81 (Conv2D)              (None, 8, 8, 384)    1548288     activation_80[0][0]              
    __________________________________________________________________________________________________
    batch_normalization_77 (BatchNo (None, 8, 8, 384)    1152        conv2d_77[0][0]                  
    __________________________________________________________________________________________________
    batch_normalization_81 (BatchNo (None, 8, 8, 384)    1152        conv2d_81[0][0]                  
    __________________________________________________________________________________________________
    activation_77 (Activation)      (None, 8, 8, 384)    0           batch_normalization_77[0][0]     
    __________________________________________________________________________________________________
    activation_81 (Activation)      (None, 8, 8, 384)    0           batch_normalization_81[0][0]     
    __________________________________________________________________________________________________
    conv2d_78 (Conv2D)              (None, 8, 8, 384)    442368      activation_77[0][0]              
    __________________________________________________________________________________________________
    conv2d_79 (Conv2D)              (None, 8, 8, 384)    442368      activation_77[0][0]              
    __________________________________________________________________________________________________
    conv2d_82 (Conv2D)              (None, 8, 8, 384)    442368      activation_81[0][0]              
    __________________________________________________________________________________________________
    conv2d_83 (Conv2D)              (None, 8, 8, 384)    442368      activation_81[0][0]              
    __________________________________________________________________________________________________
    average_pooling2d_7 (AveragePoo (None, 8, 8, 1280)   0           mixed8[0][0]                     
    __________________________________________________________________________________________________
    conv2d_76 (Conv2D)              (None, 8, 8, 320)    409600      mixed8[0][0]                     
    __________________________________________________________________________________________________
    batch_normalization_78 (BatchNo (None, 8, 8, 384)    1152        conv2d_78[0][0]                  
    __________________________________________________________________________________________________
    batch_normalization_79 (BatchNo (None, 8, 8, 384)    1152        conv2d_79[0][0]                  
    __________________________________________________________________________________________________
    batch_normalization_82 (BatchNo (None, 8, 8, 384)    1152        conv2d_82[0][0]                  
    __________________________________________________________________________________________________
    batch_normalization_83 (BatchNo (None, 8, 8, 384)    1152        conv2d_83[0][0]                  
    __________________________________________________________________________________________________
    conv2d_84 (Conv2D)              (None, 8, 8, 192)    245760      average_pooling2d_7[0][0]        
    __________________________________________________________________________________________________
    batch_normalization_76 (BatchNo (None, 8, 8, 320)    960         conv2d_76[0][0]                  
    __________________________________________________________________________________________________
    activation_78 (Activation)      (None, 8, 8, 384)    0           batch_normalization_78[0][0]     
    __________________________________________________________________________________________________
    activation_79 (Activation)      (None, 8, 8, 384)    0           batch_normalization_79[0][0]     
    __________________________________________________________________________________________________
    activation_82 (Activation)      (None, 8, 8, 384)    0           batch_normalization_82[0][0]     
    __________________________________________________________________________________________________
    activation_83 (Activation)      (None, 8, 8, 384)    0           batch_normalization_83[0][0]     
    __________________________________________________________________________________________________
    batch_normalization_84 (BatchNo (None, 8, 8, 192)    576         conv2d_84[0][0]                  
    __________________________________________________________________________________________________
    activation_76 (Activation)      (None, 8, 8, 320)    0           batch_normalization_76[0][0]     
    __________________________________________________________________________________________________
    mixed9_0 (Concatenate)          (None, 8, 8, 768)    0           activation_78[0][0]              
                                                                     activation_79[0][0]              
    __________________________________________________________________________________________________
    concatenate (Concatenate)       (None, 8, 8, 768)    0           activation_82[0][0]              
                                                                     activation_83[0][0]              
    __________________________________________________________________________________________________
    activation_84 (Activation)      (None, 8, 8, 192)    0           batch_normalization_84[0][0]     
    __________________________________________________________________________________________________
    mixed9 (Concatenate)            (None, 8, 8, 2048)   0           activation_76[0][0]              
                                                                     mixed9_0[0][0]                   
                                                                     concatenate[0][0]                
                                                                     activation_84[0][0]              
    __________________________________________________________________________________________________
    conv2d_89 (Conv2D)              (None, 8, 8, 448)    917504      mixed9[0][0]                     
    __________________________________________________________________________________________________
    batch_normalization_89 (BatchNo (None, 8, 8, 448)    1344        conv2d_89[0][0]                  
    __________________________________________________________________________________________________
    activation_89 (Activation)      (None, 8, 8, 448)    0           batch_normalization_89[0][0]     
    __________________________________________________________________________________________________
    conv2d_86 (Conv2D)              (None, 8, 8, 384)    786432      mixed9[0][0]                     
    __________________________________________________________________________________________________
    conv2d_90 (Conv2D)              (None, 8, 8, 384)    1548288     activation_89[0][0]              
    __________________________________________________________________________________________________
    batch_normalization_86 (BatchNo (None, 8, 8, 384)    1152        conv2d_86[0][0]                  
    __________________________________________________________________________________________________
    batch_normalization_90 (BatchNo (None, 8, 8, 384)    1152        conv2d_90[0][0]                  
    __________________________________________________________________________________________________
    activation_86 (Activation)      (None, 8, 8, 384)    0           batch_normalization_86[0][0]     
    __________________________________________________________________________________________________
    activation_90 (Activation)      (None, 8, 8, 384)    0           batch_normalization_90[0][0]     
    __________________________________________________________________________________________________
    conv2d_87 (Conv2D)              (None, 8, 8, 384)    442368      activation_86[0][0]              
    __________________________________________________________________________________________________
    conv2d_88 (Conv2D)              (None, 8, 8, 384)    442368      activation_86[0][0]              
    __________________________________________________________________________________________________
    conv2d_91 (Conv2D)              (None, 8, 8, 384)    442368      activation_90[0][0]              
    __________________________________________________________________________________________________
    conv2d_92 (Conv2D)              (None, 8, 8, 384)    442368      activation_90[0][0]              
    __________________________________________________________________________________________________
    average_pooling2d_8 (AveragePoo (None, 8, 8, 2048)   0           mixed9[0][0]                     
    __________________________________________________________________________________________________
    conv2d_85 (Conv2D)              (None, 8, 8, 320)    655360      mixed9[0][0]                     
    __________________________________________________________________________________________________
    batch_normalization_87 (BatchNo (None, 8, 8, 384)    1152        conv2d_87[0][0]                  
    __________________________________________________________________________________________________
    batch_normalization_88 (BatchNo (None, 8, 8, 384)    1152        conv2d_88[0][0]                  
    __________________________________________________________________________________________________
    batch_normalization_91 (BatchNo (None, 8, 8, 384)    1152        conv2d_91[0][0]                  
    __________________________________________________________________________________________________
    batch_normalization_92 (BatchNo (None, 8, 8, 384)    1152        conv2d_92[0][0]                  
    __________________________________________________________________________________________________
    conv2d_93 (Conv2D)              (None, 8, 8, 192)    393216      average_pooling2d_8[0][0]        
    __________________________________________________________________________________________________
    batch_normalization_85 (BatchNo (None, 8, 8, 320)    960         conv2d_85[0][0]                  
    __________________________________________________________________________________________________
    activation_87 (Activation)      (None, 8, 8, 384)    0           batch_normalization_87[0][0]     
    __________________________________________________________________________________________________
    activation_88 (Activation)      (None, 8, 8, 384)    0           batch_normalization_88[0][0]     
    __________________________________________________________________________________________________
    activation_91 (Activation)      (None, 8, 8, 384)    0           batch_normalization_91[0][0]     
    __________________________________________________________________________________________________
    activation_92 (Activation)      (None, 8, 8, 384)    0           batch_normalization_92[0][0]     
    __________________________________________________________________________________________________
    batch_normalization_93 (BatchNo (None, 8, 8, 192)    576         conv2d_93[0][0]                  
    __________________________________________________________________________________________________
    activation_85 (Activation)      (None, 8, 8, 320)    0           batch_normalization_85[0][0]     
    __________________________________________________________________________________________________
    mixed9_1 (Concatenate)          (None, 8, 8, 768)    0           activation_87[0][0]              
                                                                     activation_88[0][0]              
    __________________________________________________________________________________________________
    concatenate_1 (Concatenate)     (None, 8, 8, 768)    0           activation_91[0][0]              
                                                                     activation_92[0][0]              
    __________________________________________________________________________________________________
    activation_93 (Activation)      (None, 8, 8, 192)    0           batch_normalization_93[0][0]     
    __________________________________________________________________________________________________
    mixed10 (Concatenate)           (None, 8, 8, 2048)   0           activation_85[0][0]              
                                                                     mixed9_1[0][0]                   
                                                                     concatenate_1[0][0]              
                                                                     activation_93[0][0]              
    __________________________________________________________________________________________________
    avg_pool (GlobalAveragePooling2 (None, 2048)         0           mixed10[0][0]                    
    ==================================================================================================
    Total params: 21,802,784
    Trainable params: 21,768,352
    Non-trainable params: 34,432
    __________________________________________________________________________________________________
    None



```python
# plot model
filename = 'models/cnn_inceptionv3.png'
plot(cnn_inceptionv3, filename)
```


    Output hidden; open in https://colab.research.google.com to view.



```python
filename = 'files/features_inceptionv3.pkl'
# only extract if file does not exist
if not isfile(filename):
    # extract features from all images
    directory = 'Flickr8k_Dataset'
    features = extract_features(directory, cnn_vgg16, 224)
    # save to file
    dump(features, open(filename, 'wb'))
```


```python
# display original and preprocessed image
example_image = "Flickr8k_Dataset/667626_18933d713e.jpg"
display(Image(example_image))
image = preprocess_image(example_image, 299)
plt.imshow(np.squeeze(image))
```

{{< figure src="images/output_15_0.jpeg" alt="Example image" caption="Example image" numbered="true">}}

{{< figure src="images/output_22_3.png" alt="Example image preprocessed for VGG16" caption="Example image preprocessed for InceptionV3" numbered="true">}}    

# 4. Prepare Text Data


```python
# load doc into memory
def load_doc(filename):
    # open the file as read only
    file = open(filename, 'r')
    # read all text
    text = file.read()
    # close the file
    file.close()
    return text
```


```python
# extract descriptions for images
def load_descriptions(doc):
    mapping = dict()
    # process lines
    for line in doc.split('\n'):
        # split line by white space
        tokens = line.split()
        if len(line) < 2:
            continue
        # take the first token as the image id, the rest as the description
        image_id, image_desc = tokens[0], tokens[1:]
        # remove filename from image id
        image_id = image_id.split('.')[0]
        # convert description tokens back to string
        image_desc = ' '.join(image_desc)
        # create the list if needed
        if image_id not in mapping:
            mapping[image_id] = list()
        # store description
        mapping[image_id].append(image_desc)
    return mapping
```


```python
def clean_descriptions(descriptions):
    # prepare translation table for removing punctuation
    table = str.maketrans('', '', string.punctuation)
    for key, desc_list in descriptions.items():
        for i in range(len(desc_list)):
            desc = desc_list[i]
            # tokenize
            desc = desc.split()
            # convert to lower case
            desc = [word.lower() for word in desc]
            # remove punctuation from each token
            desc = [w.translate(table) for w in desc]
            # remove hanging 's' and 'a'
            desc = [word for word in desc if len(word)>1]
            # remove tokens with numbers in them
            desc = [word for word in desc if word.isalpha()]
            # store as string
            desc_list[i] =  ' '.join(desc)
```


```python
# convert the loaded descriptions into a vocabulary of words
def to_vocabulary(descriptions):
    # build a list of all description strings
    all_desc = set()
    for key in descriptions.keys():
        [all_desc.update(d.split()) for d in descriptions[key]]
    return all_desc
```


```python
# save descriptions to file, one per line
def save_descriptions(descriptions, filename):
    lines = list()
    for key, desc_list in descriptions.items():
        for desc in desc_list:
            lines.append(key + ' ' + desc)
    data = '\n'.join(lines)
    file = open(filename, 'w')
    file.write(data)
    file.close()
```


```python
filename = 'Flickr8k_text/Flickr8k.token.txt'
# load descriptions
doc = load_doc(filename)
# parse descriptions
descriptions = load_descriptions(doc)
print('Loaded: %d ' % len(descriptions))
```

    Loaded: 8092 



```python
display(Image(example_image))
```


    
{{< figure src="images/output_15_0.jpeg" alt="Example image" caption="Example image" numbered="true">}}
    



```python
example_id = '667626_18933d713e'
descriptions[example_id]
```




    ['A girl is stretched out in shallow water',
     'A girl wearing a red and multi-colored bikini is laying on her back in shallow water .',
     'A little girl in a red swimsuit is laying on her back in shallow water .',
     'A young girl is lying in the sand , while ocean water is surrounding her .',
     'Girl wearing a bikini lying on her back in a shallow pool of clear blue water .']




```python
# clean descriptions
clean_descriptions(descriptions)
# summarize vocabulary
vocabulary = to_vocabulary(descriptions)
print('Vocabulary Size: %d' % len(vocabulary))
# save to file
save_descriptions(descriptions, 'files/descriptions.txt')
```

    Vocabulary Size: 8763



```python
descriptions[example_id]
```




    ['girl is stretched out in shallow water',
     'girl wearing red and multicolored bikini is laying on her back in shallow water',
     'little girl in red swimsuit is laying on her back in shallow water',
     'young girl is lying in the sand while ocean water is surrounding her',
     'girl wearing bikini lying on her back in shallow pool of clear blue water']



# 5. Load Data


```python
# load a pre-defined list of photo identifiers
def load_set(filename):
    doc = load_doc(filename)
    dataset = list()
    # process line by line
    for line in doc.split('\n'):
        # skip empty lines
        if len(line) < 1:
            continue
        # get the image identifier
        identifier = line.split('.')[0]
        dataset.append(identifier)
    return set(dataset)
```


```python
# load clean descriptions into memory
def load_clean_descriptions(filename, dataset):
    # load document
    doc = load_doc(filename)
    descriptions = dict()
    for line in doc.split('\n'):
        # split line by white space
        tokens = line.split()
        # split id from description
        image_id, image_desc = tokens[0], tokens[1:]
        # skip images not in the set
        if image_id in dataset:
            # create list
            if image_id not in descriptions:
                descriptions[image_id] = list()
            # wrap description in tokens
            desc = '<start> ' + ' '.join(image_desc) + ' <end>'
            # store
            descriptions[image_id].append(desc)
    return descriptions
```


```python
# load photo features
def load_photo_features(filename, dataset):
    # load all features
    all_features = load(open(filename, 'rb'))
    # filter features
    features = {k: all_features[k] for k in dataset}
    return features
```

## 5.1. Train Data


```python
# load training dataset (6K)
filename = 'Flickr8k_text/Flickr_8k.trainImages.txt'
train = load_set(filename)
print('Dataset: %d' % len(train))
# descriptions
train_descriptions = load_clean_descriptions('files/descriptions.txt', train)
print('Descriptions: train=%d' % len(train_descriptions))
# photo features
train_features = load_photo_features('files/features_vgg16.pkl', train) #files/features_inceptionv3 or files/features_vgg16
print('Photos: train=%d' % len(train_features))
```

    Dataset: 6000
    Descriptions: train=6000
    Photos: train=6000



```python
display(Image(example_image))
```


    
{{< figure src="images/output_15_0.jpeg" alt="Example image" caption="Example image" numbered="true">}}
    



```python
# <start> and <end> added
train_descriptions[example_id]
```




    ['<start> girl is stretched out in shallow water <end>',
     '<start> girl wearing red and multicolored bikini is laying on her back in shallow water <end>',
     '<start> little girl in red swimsuit is laying on her back in shallow water <end>',
     '<start> young girl is lying in the sand while ocean water is surrounding her <end>',
     '<start> girl wearing bikini lying on her back in shallow pool of clear blue water <end>']




```python
# features of previous image
train_features[example_id]
```




    array([[0.39258254, 0.17952543, 0.5020331 , ..., 0.31590924, 0.616592  ,
            0.37674323]], dtype=float32)



## 5.2. Validation Data


```python
# load val dataset
filename = 'Flickr8k_text/Flickr_8k.devImages.txt'
val = load_set(filename)
print('Dataset: %d' % len(val))
# descriptions
val_descriptions = load_clean_descriptions('files/descriptions.txt', val)
print('Descriptions: val=%d' % len(val_descriptions))
# photo features
val_features = load_photo_features('files/features_vgg16.pkl', val)#files/features_inceptionv3 or files/features_vgg16
print('Photos: val=%d' % len(val_features))
```

    Dataset: 1000
    Descriptions: val=1000
    Photos: val=1000


## 5.3. Test Data


```python
# load test set
filename = 'Flickr8k_text/Flickr_8k.testImages.txt'
test = load_set(filename)
print('Dataset: %d' % len(test))
# descriptions
test_descriptions = load_clean_descriptions('files/descriptions.txt', test)
print('Descriptions: test=%d' % len(test_descriptions))
# photo features
test_features = load_photo_features('files/features_vgg16.pkl', test)#files/features_inceptionv3 or files/features_vgg16
print('Photos: test=%d' % len(test_features))
```

    Dataset: 1000
    Descriptions: test=1000
    Photos: test=1000


# 6. Encode Text Data


```python
# covert a dictionary of clean descriptions to a list of descriptions
def to_lines(descriptions):
    all_desc = list()
    for key in descriptions.keys():
        [all_desc.append(d) for d in descriptions[key]]
    return all_desc
```


```python
# fit a tokenizer given caption descriptions
def create_tokenizer(descriptions):
    lines = to_lines(descriptions)
    tokenizer = Tokenizer(filters='!"#$%&()*+.,-/:;=?@[\]^_`{|}~ ')
    tokenizer.fit_on_texts(lines)
    return tokenizer
```


```python
# calculate the length of the description with the most words
def max_len(descriptions):
    lines = to_lines(descriptions)
    return max(len(d.split()) for d in lines)
```


```python
# prepare tokenizer
filename = 'files/tokenizer.pkl'
# only create tokenizer if it does not exist
if not isfile(filename):
    tokenizer = create_tokenizer(train_descriptions)
    # save the tokenizer
    dump(tokenizer, open(filename, 'wb'))
else:
    tokenizer = load(open(filename, 'rb'))
# define vocabulary size
vocab_size = len(tokenizer.word_index) + 1
print('Vocabulary Size: %d' % vocab_size)
# determine the maximum sequence length
max_length = max_len(train_descriptions)
print('Description Length: %d' % max_length)
```

    Vocabulary Size: 7579
    Description Length: 34



```python
# 10 most common words
list(tokenizer.word_index.items())[:10]
```




    [('<start>', 1),
     ('<end>', 2),
     ('in', 3),
     ('the', 4),
     ('on', 5),
     ('is', 6),
     ('and', 7),
     ('dog', 8),
     ('with', 9),
     ('man', 10)]




```python
# 10 least common words
list(tokenizer.word_index.items())[-10:]
```




    [('exotic', 7569),
     ('swatting', 7570),
     ('containig', 7571),
     ('rainstorm', 7572),
     ('breezeway', 7573),
     ('cocker', 7574),
     ('spaniels', 7575),
     ('majestically', 7576),
     ('scrolled', 7577),
     ('patterns', 7578)]



# 7. Define Model


```python
from keras.backend import clear_session
clear_session()
```

## 7.1. Model 1


```python
# define the captioning model
def rnn_model_1(vocab_size, max_length, embedding_size, units, input_size):
    # feature extractor model
    inputs1 = Input(shape=(input_size,))
    fe1 = Dropout(0.5)(inputs1)
    fe2 = Dense(embedding_size, activation='relu')(fe1)
    # sequence model
    inputs2 = Input(shape=(max_length,))
    se1 = Embedding(vocab_size, embedding_size, mask_zero=True)(inputs2)
    se2 = Dropout(0.5)(se1)
    se3 = LSTM(units)(se2)
    # decoder model
    decoder1 = add([fe2, se3])
    decoder2 = Dense(units, activation='relu')(decoder1)
    outputs = Dense(vocab_size, activation='softmax')(decoder2)
    # tie it together [image, seq] [word]
    model = Model(inputs=[inputs1, inputs2], outputs=outputs)
    model.compile(loss='categorical_crossentropy', optimizer='adam')
    # summarize model
    print(model.summary())
    return model
```

### 7.1.1. Model 1 VGG16


```python
# define the model
embedding_size = 256
units = 256
input_size = 4096
model = rnn_model_1(vocab_size, max_length, embedding_size, units, input_size)
```

    Model: "model"
    __________________________________________________________________________________________________
    Layer (type)                    Output Shape         Param #     Connected to                     
    ==================================================================================================
    input_2 (InputLayer)            [(None, 34)]         0                                            
    __________________________________________________________________________________________________
    input_1 (InputLayer)            [(None, 4096)]       0                                            
    __________________________________________________________________________________________________
    embedding (Embedding)           (None, 34, 256)      1940224     input_2[0][0]                    
    __________________________________________________________________________________________________
    dropout (Dropout)               (None, 4096)         0           input_1[0][0]                    
    __________________________________________________________________________________________________
    dropout_1 (Dropout)             (None, 34, 256)      0           embedding[0][0]                  
    __________________________________________________________________________________________________
    dense (Dense)                   (None, 256)          1048832     dropout[0][0]                    
    __________________________________________________________________________________________________
    lstm (LSTM)                     (None, 256)          525312      dropout_1[0][0]                  
    __________________________________________________________________________________________________
    add (Add)                       (None, 256)          0           dense[0][0]                      
                                                                     lstm[0][0]                       
    __________________________________________________________________________________________________
    dense_1 (Dense)                 (None, 256)          65792       add[0][0]                        
    __________________________________________________________________________________________________
    dense_2 (Dense)                 (None, 7579)         1947803     dense_1[0][0]                    
    ==================================================================================================
    Total params: 5,527,963
    Trainable params: 5,527,963
    Non-trainable params: 0
    __________________________________________________________________________________________________
    None



```python
# plot model
filename = 'models/rnn_model_1_vgg16.png'
plot(model, filename)
```


{{< figure src="images/output_60_0.png" alt="Model 1 VGG16" caption="Model 1 VGG16" numbered="true">}}    
    


### 7.1.2. Model 1 InceptionV3


```python
# define the model
embedding_size = 256
units = 256
input_size = 2048
model = rnn_model_1(vocab_size, max_length, embedding_size, units, input_size)
```

    Model: "model_1"
    __________________________________________________________________________________________________
    Layer (type)                    Output Shape         Param #     Connected to                     
    ==================================================================================================
    input_4 (InputLayer)            [(None, 34)]         0                                            
    __________________________________________________________________________________________________
    input_3 (InputLayer)            [(None, 2048)]       0                                            
    __________________________________________________________________________________________________
    embedding_1 (Embedding)         (None, 34, 256)      1940224     input_4[0][0]                    
    __________________________________________________________________________________________________
    dropout_2 (Dropout)             (None, 2048)         0           input_3[0][0]                    
    __________________________________________________________________________________________________
    dropout_3 (Dropout)             (None, 34, 256)      0           embedding_1[0][0]                
    __________________________________________________________________________________________________
    dense_3 (Dense)                 (None, 256)          524544      dropout_2[0][0]                  
    __________________________________________________________________________________________________
    lstm_1 (LSTM)                   (None, 256)          525312      dropout_3[0][0]                  
    __________________________________________________________________________________________________
    add_1 (Add)                     (None, 256)          0           dense_3[0][0]                    
                                                                     lstm_1[0][0]                     
    __________________________________________________________________________________________________
    dense_4 (Dense)                 (None, 256)          65792       add_1[0][0]                      
    __________________________________________________________________________________________________
    dense_5 (Dense)                 (None, 7579)         1947803     dense_4[0][0]                    
    ==================================================================================================
    Total params: 5,003,675
    Trainable params: 5,003,675
    Non-trainable params: 0
    __________________________________________________________________________________________________
    None



```python
# plot model
filename = 'models/rnn_model_1_inceptionv3.png'
plot(model, filename)
```


{{< figure src="images/output_63_0.png" alt="Model 1 InceptionV3" caption="Model 1 InceptionV3" numbered="true">}}
    


## 7.2. Model 2


```python
# define the captioning model
def rnn_model_2(vocab_size, max_length, embedding_size, units, input_size):
    image_input = Input(shape=(input_size,))
    image_model_1 = Dense(embedding_size, activation='relu')(image_input)
    image_model = RepeatVector(max_length)(image_model_1)

    caption_input = Input(shape=(max_length,))
    # mask_zero: We zero pad inputs to the same length, the zero mask ignores those inputs
    caption_model_1 = Embedding(vocab_size, embedding_size, mask_zero=True)(caption_input)
    # Since we are going to predict the next word using the previous words, we have to set return_sequences = True.
    caption_model_2 = LSTM(units, return_sequences=True)(caption_model_1)
    caption_model = TimeDistributed(Dense(embedding_size))(caption_model_2)

    # Merging the models and creating a softmax classifier
    final_model_1 = concatenate([image_model, caption_model])
    final_model_2 = Bidirectional(LSTM(units, return_sequences=False))(final_model_1)
    final_model_3 = Dense(units, activation='relu')(final_model_2)
    final_model = Dense(vocab_size, activation='softmax')(final_model_3)

    model = Model(inputs=[image_input, caption_input], outputs=final_model)
    model.compile(loss='categorical_crossentropy', optimizer='adam')
    # summarize model
    print(model.summary())
    return model
```

### 7.2.1. Model 2 VGG16


```python
# define the model
embedding_size = 256
units = 256
input_size = 4096
model = rnn_model_2(vocab_size, max_length, embedding_size, units, input_size)
```

    Model: "model_1"
    __________________________________________________________________________________________________
    Layer (type)                    Output Shape         Param #     Connected to                     
    ==================================================================================================
    input_3 (InputLayer)            [(None, 34)]         0                                            
    __________________________________________________________________________________________________
    input_2 (InputLayer)            [(None, 4096)]       0                                            
    __________________________________________________________________________________________________
    embedding (Embedding)           (None, 34, 256)      1940224     input_3[0][0]                    
    __________________________________________________________________________________________________
    dense (Dense)                   (None, 256)          1048832     input_2[0][0]                    
    __________________________________________________________________________________________________
    lstm (LSTM)                     (None, 34, 256)      525312      embedding[0][0]                  
    __________________________________________________________________________________________________
    repeat_vector (RepeatVector)    (None, 34, 256)      0           dense[0][0]                      
    __________________________________________________________________________________________________
    time_distributed (TimeDistribut (None, 34, 256)      65792       lstm[0][0]                       
    __________________________________________________________________________________________________
    concatenate (Concatenate)       (None, 34, 512)      0           repeat_vector[0][0]              
                                                                     time_distributed[0][0]           
    __________________________________________________________________________________________________
    bidirectional (Bidirectional)   (None, 512)          1574912     concatenate[0][0]                
    __________________________________________________________________________________________________
    dense_2 (Dense)                 (None, 256)          131328      bidirectional[0][0]              
    __________________________________________________________________________________________________
    dense_3 (Dense)                 (None, 7579)         1947803     dense_2[0][0]                    
    ==================================================================================================
    Total params: 7,234,203
    Trainable params: 7,234,203
    Non-trainable params: 0
    __________________________________________________________________________________________________
    None



```python
# plot model
filename = 'models/rnn_model_2_vgg16.png'
plot(model, filename)
```


    
{{< figure src="images/output_68_0.png" alt="Model 2 VGG16" caption="Model 2 VGG16" numbered="true" >}}
    


### 7.2.2. Model 2 InceptionV3


```python
# define the model
embedding_size = 256
units = 256
input_size = 2048
model = rnn_model_2(vocab_size, max_length, embedding_size, units, input_size)
```

    Model: "model_2"
    __________________________________________________________________________________________________
    Layer (type)                    Output Shape         Param #     Connected to                     
    ==================================================================================================
    input_5 (InputLayer)            [(None, 34)]         0                                            
    __________________________________________________________________________________________________
    input_4 (InputLayer)            [(None, 2048)]       0                                            
    __________________________________________________________________________________________________
    embedding_1 (Embedding)         (None, 34, 256)      1940224     input_5[0][0]                    
    __________________________________________________________________________________________________
    dense_4 (Dense)                 (None, 256)          524544      input_4[0][0]                    
    __________________________________________________________________________________________________
    lstm_2 (LSTM)                   (None, 34, 256)      525312      embedding_1[0][0]                
    __________________________________________________________________________________________________
    repeat_vector_1 (RepeatVector)  (None, 34, 256)      0           dense_4[0][0]                    
    __________________________________________________________________________________________________
    time_distributed_1 (TimeDistrib (None, 34, 256)      65792       lstm_2[0][0]                     
    __________________________________________________________________________________________________
    concatenate_1 (Concatenate)     (None, 34, 512)      0           repeat_vector_1[0][0]            
                                                                     time_distributed_1[0][0]         
    __________________________________________________________________________________________________
    bidirectional_1 (Bidirectional) (None, 512)          1574912     concatenate_1[0][0]              
    __________________________________________________________________________________________________
    dense_6 (Dense)                 (None, 256)          131328      bidirectional_1[0][0]            
    __________________________________________________________________________________________________
    dense_7 (Dense)                 (None, 7579)         1947803     dense_6[0][0]                    
    ==================================================================================================
    Total params: 6,709,915
    Trainable params: 6,709,915
    Non-trainable params: 0
    __________________________________________________________________________________________________
    None



```python
# plot model
filename = 'models/rnn_model_2_inceptionv3.png'
plot(model, filename)
```


{{< figure src="images/output_71_0.png" alt="Model 2 InceptionV3" caption="Model 2 InceptionV3" numbered="true" >}}
    


# 8. Fit Model


```python
# Create sequences of images, input sequences and output words for an image
def create_sequences(tokenizer, max_length, captions_list, image):
    # X1 : input for image features
    # X2 : input for text features
    # y  : output word
    X1, X2, y = list(), list(), list()
    vocab_size = len(tokenizer.word_index) + 1
    # Walk through each caption for the image
    for caption in captions_list:
        # Encode the sequence
        seq = tokenizer.texts_to_sequences([caption])[0]
        # Split one sequence into multiple X,y pairs
        for i in range(1, len(seq)):
            # Split into input and output pair
            in_seq, out_seq = seq[:i], seq[i]
            # Pad input sequence
            in_seq = pad_sequences([in_seq], maxlen=max_length)[0]
            # Encode output sequence
            out_seq = to_categorical([out_seq], num_classes=vocab_size)[0]
            # Store
            X1.append(image)
            X2.append(in_seq)
            y.append(out_seq)
    return X1, X2, y
```


```python
# Data generator, intended to be used in a call to model.fit()
def data_generator(images, captions, tokenizer, max_length, batch_size, random_seed):
    # Setting random seed for reproducibility of results
    random.seed(random_seed)
    # Image ids
    image_ids = list(captions.keys())
    _count=0
    while True:
        if _count >= len(image_ids):
            # Generator exceeded or reached the end so restart it
            _count = 0
        # Batch list to store data
        input_img_batch, input_sequence_batch, output_word_batch = list(), list(), list()
        for i in range(_count, min(len(image_ids), _count+batch_size)):
            # Retrieve the image id
            image_id = image_ids[i]
            # Retrieve the image features
            image = images[image_id][0]
            # Retrieve the captions list
            captions_list = captions[image_id]
            # Shuffle captions list
            random.shuffle(captions_list)
            input_img, input_sequence, output_word = create_sequences(tokenizer, max_length, captions_list, image)
            # Add to batch
            for j in range(len(input_img)):
                input_img_batch.append(input_img[j])
                input_sequence_batch.append(input_sequence[j])
                output_word_batch.append(output_word[j])
        _count = _count + batch_size
        yield ([np.array(input_img_batch), np.array(input_sequence_batch)], np.array(output_word_batch))
```


```python
# define parameters
num_of_epochs = 20
batch_size = 32
train_length = len(train_descriptions)
val_length = len(val_descriptions)
steps_train = train_length // batch_size
if train_length % batch_size != 0:
    steps_train = steps_train+1
steps_val = val_length // batch_size
if val_length % batch_size != 0:
    steps_val = steps_val+1
```


```python
import random
# Setting random seed for reproducibility of results
random.seed('1000')
# Shuffle train data
ids_train = list(train_descriptions.keys())
random.shuffle(ids_train)
train_descriptions = {_id: train_descriptions[_id] for _id in ids_train}
```


```python
# Create the train data generator
generator_train = data_generator(train_features, train_descriptions, tokenizer, max_length, batch_size, random_seed='1000')
# Create the validation data generator
generator_val = data_generator(val_features, val_descriptions, tokenizer, max_length, batch_size, random_seed='1000')
```


```python
from keras.callbacks import ModelCheckpoint
from keras.callbacks import EarlyStopping
# define checkpoint callback
filepath = 'models/rnn_model_2_vgg16.h5'
checkpoint = ModelCheckpoint(filepath, monitor='val_loss', verbose=1, save_best_only=True, mode='min')
# define early stopping callback
early = EarlyStopping(patience=1, verbose=1)
```


```python
# Fit
history = model.fit(generator_train,
            epochs=num_of_epochs,
            steps_per_epoch=steps_train,
            validation_data=generator_val,
            validation_steps=steps_val,
            callbacks=[checkpoint, early],
            verbose=1)
```

    Epoch 1/20
    188/188 [==============================] - 109s 527ms/step - loss: 6.2133 - val_loss: 5.3030
    
    Epoch 00001: val_loss improved from inf to 5.30304, saving model to models/rnn_model_2_vgg16.h5
    Epoch 2/20
    188/188 [==============================] - 97s 517ms/step - loss: 5.2260 - val_loss: 4.7302
    
    Epoch 00002: val_loss improved from 5.30304 to 4.73015, saving model to models/rnn_model_2_vgg16.h5
    Epoch 3/20
    188/188 [==============================] - 97s 514ms/step - loss: 4.6124 - val_loss: 4.2400
    
    Epoch 00003: val_loss improved from 4.73015 to 4.23999, saving model to models/rnn_model_2_vgg16.h5
    Epoch 4/20
    188/188 [==============================] - 97s 514ms/step - loss: 4.1185 - val_loss: 3.9822
    
    Epoch 00004: val_loss improved from 4.23999 to 3.98225, saving model to models/rnn_model_2_vgg16.h5
    Epoch 5/20
    188/188 [==============================] - 97s 516ms/step - loss: 3.7971 - val_loss: 3.8404
    
    Epoch 00005: val_loss improved from 3.98225 to 3.84040, saving model to models/rnn_model_2_vgg16.h5
    Epoch 6/20
    188/188 [==============================] - 97s 517ms/step - loss: 3.5635 - val_loss: 3.7861
    
    Epoch 00006: val_loss improved from 3.84040 to 3.78609, saving model to models/rnn_model_2_vgg16.h5
    Epoch 7/20
    188/188 [==============================] - 97s 516ms/step - loss: 3.3900 - val_loss: 3.7824
    
    Epoch 00007: val_loss improved from 3.78609 to 3.78237, saving model to models/rnn_model_2_vgg16.h5
    Epoch 8/20
    188/188 [==============================] - 96s 512ms/step - loss: 3.2455 - val_loss: 3.7692
    
    Epoch 00008: val_loss improved from 3.78237 to 3.76919, saving model to models/rnn_model_2_vgg16.h5
    Epoch 9/20
    188/188 [==============================] - 97s 516ms/step - loss: 3.1310 - val_loss: 3.7637
    
    Epoch 00009: val_loss improved from 3.76919 to 3.76373, saving model to models/rnn_model_2_vgg16.h5
    Epoch 10/20
    188/188 [==============================] - 97s 514ms/step - loss: 3.0311 - val_loss: 3.7709
    
    Epoch 00010: val_loss did not improve from 3.76373
    Epoch 00010: early stopping


## 8.1. Model 1 VGG16


```python
# using rnn_1 and vgg16
import matplotlib.pyplot as plt

for label in ["loss","val_loss"]:
    plt.plot(history.history[label],label=label)
plt.legend()
plt.xlabel("epochs")
plt.ylabel("loss")
plt.savefig('models/rnn_1_vgg16_loss.png')
plt.show()
```


{{< figure src="images/output_81_0.png" alt="Model 1 VGG16 Loss" caption="Model 1 VGG16 Loss" numbered="true" >}}
    


## 8.2. Model 1 InceptionV3


```python
# using rnn_1 and inceptionv3
import matplotlib.pyplot as plt

for label in ["loss","val_loss"]:
    plt.plot(history.history[label],label=label)
plt.legend()
plt.xlabel("epochs")
plt.ylabel("loss")
plt.savefig('models/rnn_1_inceptionv3_loss.png')
plt.show()
```


{{< figure src="images/output_83_0.png" alt="Model 1 InceptionV3 Loss" caption="Model 1 InceptionV3 Loss" numbered="true" >}}


## 8.3. Model 2 VGG16


```python
# using rnn_2 and vgg16
import matplotlib.pyplot as plt

for label in ["loss","val_loss"]:
    plt.plot(history.history[label],label=label)
plt.legend()
plt.xlabel("epochs")
plt.ylabel("loss")
plt.savefig('models/rnn_2_vgg16_loss.png')
plt.show()
```


{{< figure src="images/output_85_0.png" alt="Model 2 VGG16 Loss" caption="Model 2 VGG16 Loss" numbered="true" >}}
    


## 8.4. Model 2 InceptionV3


```python
# using rnn_2 and inceptionv3
import matplotlib.pyplot as plt

for label in ["loss","val_loss"]:
    plt.plot(history.history[label],label=label)
plt.legend()
plt.xlabel("epochs")
plt.ylabel("loss")
plt.savefig('models/rnn_2_inceptionv3_loss.png')
plt.show()
```


{{< figure src="images/output_87_0.png" alt="Model 2 InceptionV3 Loss" caption="Model 2 InceptionV3 Loss" numbered="true" >}}
    


# 9. Evaluate Model

## 9.1. Sampling


```python
# generate a description for an image
def generate_desc(model, tokenizer, photo, max_length):
    # seed the generation process
    in_text = '<start>'
    # iterate over the whole length of the sequence
    for i in range(max_length):
        # integer encode input sequence
        sequence = tokenizer.texts_to_sequences([in_text])[0]
        # pad input
        sequence = pad_sequences([sequence], maxlen=max_length)
        # predict next word
        yhat = model.predict([photo,sequence], verbose=0)
        # convert probability to integer
        yhat = argmax(yhat)
        # map integer to word
        word = tokenizer.index_word[yhat]
        # stop if we cannot map the word
        if word is None:
            break
        # append as input for generating the next word
        in_text += ' ' + word
        # stop if we predict the end of the sequence
        if word == '<end>':
            break
    return in_text
```

## 9.2. Beam Search


```python
# generate a description for an image using beam search
def generate_desc_beam_search(model, tokenizer, photo, max_length, beam_index=3):
    # seed the generation process
    in_text = [['<start>', 0.0]]
    # iterate over the whole length of the sequence
    for i in range(max_length):
        temp = []
        for s in in_text:
            # integer encode input sequence
            sequence = tokenizer.texts_to_sequences([s[0]])[0]
            # pad input
            sequence = pad_sequences([sequence], maxlen=max_length)
            # predict next words
            preds = model.predict([photo,sequence], verbose=0)
            word_preds = argsort(preds[0])[-beam_index:]
            # get top predictions
            for w in word_preds:
                next_cap, prob = s[0][:], s[1]
                # map integer to word
                word = tokenizer.index_word[w]
                next_cap += ' ' + word
                prob += preds[0][w]
                temp.append([next_cap, prob])

        in_text = temp
        # sorting according to the probabilities
        in_text = sorted(in_text, reverse=False, key=lambda l: l[1])
        # getting the top words
        in_text = in_text[-beam_index:]

    # get last (best) caption text
    in_text = in_text[-1][0]
    caption_list = []
    # remove leftover <end> 
    for w in in_text.split():
        caption_list.append(w)
        if w == '<end>':
            break
    # convert list to string
    caption = ' '.join(caption_list)
    return caption
```

## 9.3. BLEU


```python
def calculate_scores(actual, predicted):
    # calculate BLEU score
    smooth = SmoothingFunction().method4
    bleu1 = corpus_bleu(actual, predicted, weights=(1.0, 0, 0, 0), smoothing_function=smooth)*100
    bleu2 = corpus_bleu(actual, predicted, weights=(0.5, 0.5, 0, 0), smoothing_function=smooth)*100
    bleu3 = corpus_bleu(actual, predicted, weights=(0.3, 0.3, 0.3, 0), smoothing_function=smooth)*100
    bleu4 = corpus_bleu(actual, predicted, weights=(0.25, 0.25, 0.25, 0.25), smoothing_function=smooth)*100
    print('BLEU-1: %f' % bleu1)
    print('BLEU-2: %f' % bleu2)
    print('BLEU-3: %f' % bleu3)
    print('BLEU-4: %f' % bleu4)
```


```python
# evaluate the skill of the model
def evaluate_model(model, descriptions, features, tokenizer, max_length):
    actual, predicted = list(), list()
    # step over the whole set
    for key, desc_list in tqdm(descriptions.items(), position=0, leave=True):
        # generate description
        yhat = generate_desc(model, tokenizer, features[key], max_length)
        # store actual and predicted
        references = [d.split() for d in desc_list]
        actual.append(references)
        predicted.append(yhat.split())
    print('Sampling:')
    calculate_scores(actual, predicted)
```


```python
# evaluate the skill of the model
def evaluate_model_beam_search(model, descriptions, features, tokenizer, max_length, beam_index=3):
    actual, predicted = list(), list()
    # step over the whole set
    for key, desc_list in tqdm(descriptions.items(), position=0, leave=True):
        # generate description beam search
        yhat = generate_desc_beam_search(model, tokenizer, features[key], max_length, beam_index)
        # store actual and predicted
        references = [d.split() for d in desc_list]
        actual.append(references)
        predicted.append(yhat.split())
    print('Beam Search k=%d:' % beam_index)
    calculate_scores(actual, predicted)
```

### 9.3.1. Model 1 VGG16


```python
# load the model
filename = 'models/rnn_model_1_vgg16.h5'
model = load_model(filename)
```


```python
# evaluate model
evaluate_model(model, test_descriptions, test_features, tokenizer, max_length)
```

    100%|██████████| 1000/1000 [07:15<00:00,  2.30it/s]


    Sampling:
    BLEU-1: 54.114390
    BLEU-2: 33.489586
    BLEU-3: 24.785442
    BLEU-4: 13.031321


### 9.3.2. Model 1 InceptionV3


```python
# load the model
filename = 'models/rnn_model_1_inceptionv3.h5'
model = load_model(filename)
```


```python
# evaluate model
evaluate_model(model, test_descriptions, test_features, tokenizer, max_length)
```

    100%|██████████| 1000/1000 [06:48<00:00,  2.45it/s]


    Sampling:
    BLEU-1: 57.458612
    BLEU-2: 34.077377
    BLEU-3: 24.426512
    BLEU-4: 12.300981


### 9.3.3. Model 2 VGG16


```python
# load the model
filename = 'models/rnn_model_2_vgg16.h5'
model = load_model(filename)
```


```python
# evaluate model
evaluate_model(model, test_descriptions, test_features, tokenizer, max_length)
```

    Sampling:
    BLEU-1: 0.595796
    BLEU-2: 0.369997
    BLEU-3: 0.272431
    BLEU-4: 0.144684


### 9.3.4. Model 2 InceptionV3


```python
# load the model
filename = 'models/rnn_model_2_inceptionv3.h5'
model = load_model(filename)
```


```python
# evaluate model
evaluate_model(model, test_descriptions, test_features, tokenizer, max_length)
```

    100%|██████████| 1000/1000 [09:01<00:00,  1.85it/s]


    Sampling:
    BLEU-1: 0.587866
    BLEU-2: 0.366849
    BLEU-3: 0.270134
    BLEU-4: 0.144244



```python
# evaluate model beam_search
evaluate_model_beam_search(model, test_descriptions, test_features, tokenizer, max_length, beam_index=3)
```

     55%|█████▌    | 552/1000 [50:39<40:36,  5.44s/it]

# 10. Generate Captions


```python
def clean_caption(caption):
    # split caption words
    caption_list = caption.split()
    # remove <start> and <end>
    caption_list = caption_list[1:len(caption_list)-1]
    # convert list to string
    caption = ' '.join(caption_list)
    return caption
```


```python
def generate_captions(model, descriptions, features, image_size, count):
    c = 0
    for key, desc_list in descriptions.items():
        # load an image from file
        filename = 'Flickr8k_Dataset/' + key + '.jpg'
        #diplay image
        display(Image(filename))
        # print original descriptions
        for i, desc in enumerate(desc_list):
            print('Original ' + str(i+1) + ': ' + clean_caption(desc_list[i]))
        # generate descriptions
        desc = generate_desc(model, tokenizer, features[key], max_length)
        desc_beam_3 = generate_desc_beam_search(model, tokenizer, features[key], max_length, beam_index=3)
        desc_beam_5 = generate_desc_beam_search(model, tokenizer, features[key], max_length, beam_index=5)
        # calculate BLEU-1 scores
        references = [d.split() for d in desc_list]
        smooth = SmoothingFunction().method4
        desc_bleu = sentence_bleu(references, desc.split(), weights=(1.0, 0, 0, 0), smoothing_function=smooth)*100
        desc_beam_3_bleu = sentence_bleu(references, desc_beam_3.split(), weights=(1.0, 0, 0, 0), smoothing_function=smooth)*100
        desc_beam_5_bleu = sentence_bleu(references, desc_beam_5.split(), weights=(1.0, 0, 0, 0), smoothing_function=smooth)*100
        # print descriptions with scores
        print('Sampling (BLEU-1: %f): %s' % (desc_bleu, clean_caption(desc)))
        print('Beam Search k=3 (BLEU-1: %f): %s' % (desc_beam_3_bleu, clean_caption(desc_beam_3)))
        print('Beam Search k=5 (BLEU-1: %f): %s' % (desc_beam_5_bleu, clean_caption(desc_beam_5)))
        c += 1
        if c == count:
            break
```


```python
# load the tokenizer
tokenizer = load(open('files/tokenizer.pkl', 'rb'))
```

## 10.1. Model 1 VGG16


```python
# load the model
filename = 'models/rnn_model_1_vgg16.h5'
rnn_model = load_model(filename)
# using rnn_2 and vgg16 model
generate_captions(rnn_model, test_descriptions, test_features, 224, 10)
```


    
{{< figure src="images/output_115_0.jpeg" alt="blond woman in blue shirt appears to wait for ride" caption="blond woman in blue shirt appears to wait for ride" numbered="true" >}}
    


    Original 1: blond woman in blue shirt appears to wait for ride
    Original 2: blond woman is on the street hailing taxi
    Original 3: woman is signaling is to traffic as seen from behind
    Original 4: woman with blonde hair wearing blue tube top is waving on the side of the street
    Original 5: the woman in the blue dress is holding out her arm at oncoming traffic
    Sampling (BLEU-1: 69.230769): man in blue shirt and sunglasses is sitting on the street
    Beam Search k=3 (BLEU-1: 60.000000): man and woman are sitting on the street
    Beam Search k=5 (BLEU-1: 50.000000): man and woman are sitting on the middle of camera



    
{{< figure src="images/output_115_2.jpeg" alt="boy in his blue swim shorts at the beach" caption="boy in his blue swim shorts at the beach" numbered="true" >}}
    


    Original 1: boy in his blue swim shorts at the beach
    Original 2: boy smiles for the camera at beach
    Original 3: young boy in swimming trunks is walking with his arms outstretched on the beach
    Original 4: children playing on the beach
    Original 5: the boy is playing on the shore of an ocean
    Sampling (BLEU-1: 81.818182): boy in blue shirt is standing on the beach
    Beam Search k=3 (BLEU-1: 83.333333): little boy in blue shirt is walking on the beach
    Beam Search k=5 (BLEU-1: 83.333333): little boy in blue shirt is walking on the beach



    
{{< figure src="images/output_115_4.jpeg" alt="lady and man with no shirt sit on dock" caption="lady and man with no shirt sit on dock" numbered="true" >}}
    


    Original 1: lady and man with no shirt sit on dock
    Original 2: man and woman are sitting on dock together
    Original 3: man and woman sitting on dock
    Original 4: man and woman sitting on deck next to lake
    Original 5: shirtless man and woman sitting on dock
    Sampling (BLEU-1: 60.000000): man in blue shirt is sitting on bench
    Beam Search k=3 (BLEU-1: 36.363636): young boy is sitting on bench in the park
    Beam Search k=5 (BLEU-1: 41.666667): the man is sitting on bench in front of park



    
{{< figure src="images/output_115_6.jpeg" alt="closeup of white dog that is laying its head on its paws" caption="closeup of white dog that is laying its head on its paws" numbered="true" >}}
    


    Original 1: closeup of white dog that is laying its head on its paws
    Original 2: large white dog lying on the floor
    Original 3: white dog has its head on the ground
    Original 4: white dog is resting its head on tiled floor with its eyes open
    Original 5: white dog rests its head on the patio bricks
    Sampling (BLEU-1: 66.666667): white dog is running through the air
    Beam Search k=3 (BLEU-1: 42.736665): white and white and white dog is standing in its mouth
    Beam Search k=5 (BLEU-1: 42.736665): white and white and white dog is standing in its mouth



    
{{< figure src="images/output_115_8.jpeg" alt="boy with toy gun" caption="boy with toy gun" numbered="true" >}}
    


    Original 1: boy with toy gun
    Original 2: little boy in orange shorts playing with toy
    Original 3: young boy with his foot outstretched aims toy at the camera in front of fireplace
    Original 4: young child plays with his new lightup toy
    Original 5: boy with toy gun pointed at the camera
    Sampling (BLEU-1: 45.454545): boy in blue shirt is sitting on the ground
    Beam Search k=3 (BLEU-1: 50.000000): young boy in blue shirt is sitting on the water
    Beam Search k=5 (BLEU-1: 50.000000): little boy in blue shirt is sitting on the beach



    
{{< figure src="images/output_115_10.jpeg" alt="black dog jumping to catch rope toy" caption="black dog jumping to catch rope toy" numbered="true" >}}
    


    Original 1: black dog jumping to catch rope toy
    Original 2: black dog playing fetch with ball of rope
    Original 3: black dog pounces to get rope toy
    Original 4: black dog running after his rope toy
    Original 5: large black dog is playing in grassy yard
    Sampling (BLEU-1: 66.666667): black dog is running through the grass
    Beam Search k=3 (BLEU-1: 66.666667): black dog is running through the grass
    Beam Search k=5 (BLEU-1: 44.124845): black dog runs through the grass



    
{{< figure src="images/output_115_12.jpeg" alt="little tan dog with large ears running through the grass" caption="little tan dog with large ears running through the grass"  numbered="true" >}}
    


    Original 1: little tan dog with large ears running through the grass
    Original 2: playful dog is running through the grass
    Original 3: small dogs ears stick up as it runs in the grass
    Original 4: the small dog is running across the lawn
    Original 5: this is small beige dog running through grassy field
    Sampling (BLEU-1: 77.777778): two dogs are running in the grass
    Beam Search k=3 (BLEU-1: 66.187268): two dogs play in the grass
    Beam Search k=5 (BLEU-1: 70.000000): brown and white dog running through the grass



    
{{< figure src="images/output_115_14.jpeg" alt="baby in white garment holds flag with crescent moon and star" caption="baby in white garment holds flag with crescent moon and star" numbered="true" >}}
    


    Original 1: baby in white garment holds flag with crescent moon and star
    Original 2: baby is holding small black flag with moon and star on it
    Original 3: baby wearing white gown waves muslim flag
    Original 4: little toddler dressed in white is smiling while lady helps him wave flag
    Original 5: baby in white outfit holding black and white flag
    Sampling (BLEU-1: 33.333333): two children are sitting on the camera
    Beam Search k=3 (BLEU-1: 41.666667): young boy in blue shirt is sitting on the camera
    Beam Search k=5 (BLEU-1: 41.666667): young boy in blue shirt is sitting on the camera



    
{{< figure src="images/output_115_16.jpeg" alt="brown and white dog stands outside while it snows" caption="brown and white dog stands outside while it snows" numbered="true" >}}
    


    Original 1: brown and white dog stands outside while it snows
    Original 2: dog is looking at something near the water
    Original 3: furry dog attempts to dry itself by shaking the water off its coat
    Original 4: white and brown dog shaking its self dry
    Original 5: the large brown and white dog shakes off water
    Sampling (BLEU-1: 69.598614): white dog is running through the water
    Beam Search k=3 (BLEU-1: 11.428571): white and white and white and white and white and white and white and white and white and white and white and white and white and white and white and white and white
    Beam Search k=5 (BLEU-1: 11.428571): black and white and white and white and white and white and white and white and white and white and white and white and white and white and white and white and white



    
{{< figure src="images/output_115_18.jpeg" alt="boy is jumping on bed" caption="boy is jumping on bed" numbered="true" >}}
    


    Original 1: boy is jumping on bed
    Original 2: boy jumped up from the green bed
    Original 3: boy jumps from one bed to another
    Original 4: small child is jumping on bed
    Original 5: the boy in blue shorts is bouncing on the bed
    Sampling (BLEU-1: 75.000000): young boy in blue shirt is sitting on the bed
    Beam Search k=3 (BLEU-1: 77.777778): the little boy is sitting on bed
    Beam Search k=5 (BLEU-1: 75.000000): little boy is sitting on bed


## 10.2. Model 1 InceptionV3


```python
# load the model
filename = 'models/rnn_model_1_inceptionv3.h5'
rnn_model = load_model(filename)
# using rnn_2 and inceptionv3 model
generate_captions(rnn_model, test_descriptions, test_features, 299, 10)
```


    
{{< figure src="images/output_115_0.jpeg" alt="blond woman in blue shirt appears to wait for ride" caption="blond woman in blue shirt appears to wait for ride" numbered="true" >}}
    


    Original 1: blond woman in blue shirt appears to wait for ride
    Original 2: blond woman is on the street hailing taxi
    Original 3: woman is signaling is to traffic as seen from behind
    Original 4: woman with blonde hair wearing blue tube top is waving on the side of the street
    Original 5: the woman in the blue dress is holding out her arm at oncoming traffic
    Sampling (BLEU-1: 56.250000): man in blue jacket and blue hat is holding his head on the street
    Beam Search k=3 (BLEU-1: 62.500000): man in blue shirt and blue hat is holding his arms on the street
    Beam Search k=5 (BLEU-1: 58.333333): young boy in blue jacket is sitting on the beach



    
{{< figure src="images/output_115_2.jpeg" alt="boy in his blue swim shorts at the beach" caption="boy in his blue swim shorts at the beach" numbered="true" >}}
    


    Original 1: boy in his blue swim shorts at the beach
    Original 2: boy smiles for the camera at beach
    Original 3: young boy in swimming trunks is walking with his arms outstretched on the beach
    Original 4: children playing on the beach
    Original 5: the boy is playing on the shore of an ocean
    Sampling (BLEU-1: 56.130419): young boy in blue bathing suit is holding his head in the water
    Beam Search k=3 (BLEU-1: 61.538462): young boy in blue bathing suit is running in the water
    Beam Search k=5 (BLEU-1: 69.230769): young boy in blue bathing suit is playing in the water



    
{{< figure src="images/output_115_4.jpeg" alt="lady and man with no shirt sit on dock" caption="lady and man with no shirt sit on dock" numbered="true" >}}
    


    Original 1: lady and man with no shirt sit on dock
    Original 2: man and woman are sitting on dock together
    Original 3: man and woman sitting on dock
    Original 4: man and woman sitting on deck next to lake
    Original 5: shirtless man and woman sitting on dock
    Sampling (BLEU-1: 58.333333): man in blue shirt and jeans is sitting on bench
    Beam Search k=3 (BLEU-1: 38.461538): the man is sitting on bench in front of the ocean
    Beam Search k=5 (BLEU-1: 38.461538): the man is sitting on bench in front of white building



    
{{< figure src="images/output_115_6.jpeg" alt="closeup of white dog that is laying its head on its paws" caption="closeup of white dog that is laying its head on its paws" numbered="true" >}}
    


    Original 1: closeup of white dog that is laying its head on its paws
    Original 2: large white dog lying on the floor
    Original 3: white dog has its head on the ground
    Original 4: white dog is resting its head on tiled floor with its eyes open
    Original 5: white dog rests its head on the patio bricks
    Sampling (BLEU-1: 55.156056): dog is running through the air
    Beam Search k=3 (BLEU-1: 54.545455): white and white dog is running through the woods
    Beam Search k=5 (BLEU-1: 50.000000): white and white dog runs through the woods



    
{{< figure src="images/output_115_8.jpeg" alt="boy with toy gun" caption="boy with toy gun" numbered="true" >}}
    


    Original 1: boy with toy gun
    Original 2: little boy in orange shorts playing with toy
    Original 3: young boy with his foot outstretched aims toy at the camera in front of fireplace
    Original 4: young child plays with his new lightup toy
    Original 5: boy with toy gun pointed at the camera
    Sampling (BLEU-1: 29.411765): man in blue shirt is sitting on the edge of the edge of the water
    Beam Search k=3 (BLEU-1: 23.337955): the man is sitting on the edge of the edge of the water
    Beam Search k=5 (BLEU-1: 54.545455): young boy is sitting on the edge of water



    
{{< figure src="images/output_115_10.jpeg" alt="black dog jumping to catch rope toy" caption="black dog jumping to catch rope toy" numbered="true" >}}
    


    Original 1: black dog jumping to catch rope toy
    Original 2: black dog playing fetch with ball of rope
    Original 3: black dog pounces to get rope toy
    Original 4: black dog running after his rope toy
    Original 5: large black dog is playing in grassy yard
    Sampling (BLEU-1: 66.666667): black dog is running through the water
    Beam Search k=3 (BLEU-1: 55.156056): black dog running through the water
    Beam Search k=5 (BLEU-1: 44.124845): black dog runs through the water



    
{{< figure src="images/output_115_12.jpeg" alt="little tan dog with large ears running through the grass" caption="little tan dog with large ears running through the grass"  numbered="true" >}}
    


    Original 1: little tan dog with large ears running through the grass
    Original 2: playful dog is running through the grass
    Original 3: small dogs ears stick up as it runs in the grass
    Original 4: the small dog is running across the lawn
    Original 5: this is small beige dog running through grassy field
    Sampling (BLEU-1: 88.888889): white dog is running through the grass
    Beam Search k=3 (BLEU-1: 72.727273): brown and white dog is running through the grass
    Beam Search k=5 (BLEU-1: 70.000000): brown and white dog runs through the grass



    
{{< figure src="images/output_115_14.jpeg" alt="baby in white garment holds flag with crescent moon and star" caption="baby in white garment holds flag with crescent moon and star" numbered="true" >}}
    


    Original 1: baby in white garment holds flag with crescent moon and star
    Original 2: baby is holding small black flag with moon and star on it
    Original 3: baby wearing white gown waves muslim flag
    Original 4: little toddler dressed in white is smiling while lady helps him wave flag
    Original 5: baby in white outfit holding black and white flag
    Sampling (BLEU-1: 45.454545): man in blue shirt is sitting on the camera
    Beam Search k=3 (BLEU-1: 45.454545): young boy in blue shirt is sitting on bed
    Beam Search k=5 (BLEU-1: 45.454545): young boy in blue shirt is sitting on bed



    
{{< figure src="images/output_115_16.jpeg" alt="brown and white dog stands outside while it snows" caption="brown and white dog stands outside while it snows" numbered="true" >}}
    


    Original 1: brown and white dog stands outside while it snows
    Original 2: dog is looking at something near the water
    Original 3: furry dog attempts to dry itself by shaking the water off its coat
    Original 4: white and brown dog shaking its self dry
    Original 5: the large brown and white dog shakes off water
    Sampling (BLEU-1: 69.598614): white dog is swimming in the water
    Beam Search k=3 (BLEU-1: 80.000000): brown and white dog swims in the water
    Beam Search k=5 (BLEU-1: 80.000000): brown and white dog swims in the water



    
{{< figure src="images/output_115_18.jpeg" alt="boy is jumping on bed" caption="boy is jumping on bed" numbered="true" >}}
    


    Original 1: boy is jumping on bed
    Original 2: boy jumped up from the green bed
    Original 3: boy jumps from one bed to another
    Original 4: small child is jumping on bed
    Original 5: the boy in blue shorts is bouncing on the bed
    Sampling (BLEU-1: 70.000000): man in blue shirt is sitting on bed
    Beam Search k=3 (BLEU-1: 70.000000): man in blue shirt is sitting on bed
    Beam Search k=5 (BLEU-1: 62.500000): little girl is sitting on bed


## 10.3. Model 2 VGG16


```python
# load the model
filename = 'models/rnn_model_2_vgg16.h5'
rnn_model = load_model(filename)
# using rnn_2 and vgg16 model
generate_captions(rnn_model, test_descriptions, test_features, 224, 10)
```


    
{{< figure src="images/output_115_0.jpeg" alt="blond woman in blue shirt appears to wait for ride" caption="blond woman in blue shirt appears to wait for ride" numbered="true" >}}
    


    Original 1: blond woman in blue shirt appears to wait for ride
    Original 2: blond woman is on the street hailing taxi
    Original 3: woman is signaling is to traffic as seen from behind
    Original 4: woman with blonde hair wearing blue tube top is waving on the side of the street
    Original 5: the woman in the blue dress is holding out her arm at oncoming traffic
    Sampling (BLEU-1: 58.410059): man is sitting on the street
    Beam Search k=3 (BLEU-1: 69.598614): the man is sitting on the street
    Beam Search k=5 (BLEU-1: 69.598614): the man is sitting on the street



    
{{< figure src="images/output_115_2.jpeg" alt="boy in his blue swim shorts at the beach" caption="boy in his blue swim shorts at the beach" numbered="true" >}}
    


    Original 1: boy in his blue swim shorts at the beach
    Original 2: boy smiles for the camera at beach
    Original 3: young boy in swimming trunks is walking with his arms outstretched on the beach
    Original 4: children playing on the beach
    Original 5: the boy is playing on the shore of an ocean
    Sampling (BLEU-1: 85.714286): young boy in the sand
    Beam Search k=3 (BLEU-1: 85.714286): young boy in the sand
    Beam Search k=5 (BLEU-1: 85.714286): young boy in the sand



    
{{< figure src="images/output_115_4.jpeg" alt="lady and man with no shirt sit on dock" caption="lady and man with no shirt sit on dock" numbered="true" >}}
    


    Original 1: lady and man with no shirt sit on dock
    Original 2: man and woman are sitting on dock together
    Original 3: man and woman sitting on dock
    Original 4: man and woman sitting on deck next to lake
    Original 5: shirtless man and woman sitting on dock
    Sampling (BLEU-1: 37.500000): man is jumping off of skateboard
    Beam Search k=3 (BLEU-1: 37.151910): man jumps off of skateboard
    Beam Search k=5 (BLEU-1: 55.555556): man on skateboard is sitting on rail



    
{{< figure src="images/output_115_6.jpeg" alt="closeup of white dog that is laying its head on its paws" caption="closeup of white dog that is laying its head on its paws" numbered="true" >}}
    


    Original 1: closeup of white dog that is laying its head on its paws
    Original 2: large white dog lying on the floor
    Original 3: white dog has its head on the ground
    Original 4: white dog is resting its head on tiled floor with its eyes open
    Original 5: white dog rests its head on the patio bricks
    Sampling (BLEU-1: 33.333333): two dogs are playing in the grass
    Beam Search k=3 (BLEU-1: 55.156056): white dog looks at the steps
    Beam Search k=5 (BLEU-1: 66.187268): white dog looks at the ground



    
{{< figure src="images/output_115_8.jpeg" alt="boy with toy gun" caption="boy with toy gun" numbered="true" >}}
    


    Original 1: boy with toy gun
    Original 2: little boy in orange shorts playing with toy
    Original 3: young boy with his foot outstretched aims toy at the camera in front of fireplace
    Original 4: young child plays with his new lightup toy
    Original 5: boy with toy gun pointed at the camera
    Sampling (BLEU-1: 50.000000): the little boy is sitting on the floor
    Beam Search k=3 (BLEU-1: 60.000000): the little boy is sitting in the grass
    Beam Search k=5 (BLEU-1: 60.000000): the little boy is sitting in the grass



    
{{< figure src="images/output_115_10.jpeg" alt="black dog jumping to catch rope toy" caption="black dog jumping to catch rope toy" numbered="true" >}}
    


    Original 1: black dog jumping to catch rope toy
    Original 2: black dog playing fetch with ball of rope
    Original 3: black dog pounces to get rope toy
    Original 4: black dog running after his rope toy
    Original 5: large black dog is playing in grassy yard
    Sampling (BLEU-1: 66.666667): black dog is running on the grass
    Beam Search k=3 (BLEU-1: 70.000000): the black dog is running in the grass
    Beam Search k=5 (BLEU-1: 54.545455): black dog and black dog running in the grass



    
{{< figure src="images/output_115_12.jpeg" alt="little tan dog with large ears running through the grass" caption="little tan dog with large ears running through the grass"  numbered="true" >}}
    


    Original 1: little tan dog with large ears running through the grass
    Original 2: playful dog is running through the grass
    Original 3: small dogs ears stick up as it runs in the grass
    Original 4: the small dog is running across the lawn
    Original 5: this is small beige dog running through grassy field
    Sampling (BLEU-1: 44.124845): two dogs are playing with ball
    Beam Search k=3 (BLEU-1: 60.000000): two brown dogs are playing in the grass
    Beam Search k=5 (BLEU-1: 66.666667): brown dog is playing with tennis ball in the grass



    
{{< figure src="images/output_115_14.jpeg" alt="baby in white garment holds flag with crescent moon and star" caption="baby in white garment holds flag with crescent moon and star" numbered="true" >}}
    


    Original 1: baby in white garment holds flag with crescent moon and star
    Original 2: baby is holding small black flag with moon and star on it
    Original 3: baby wearing white gown waves muslim flag
    Original 4: little toddler dressed in white is smiling while lady helps him wave flag
    Original 5: baby in white outfit holding black and white flag
    Sampling (BLEU-1: 30.000000): two young girls are playing with each other
    Beam Search k=3 (BLEU-1: 30.000000): two young girls are sitting in the room
    Beam Search k=5 (BLEU-1: 22.222222): two young girls are posing for picture



    
{{< figure src="images/output_115_16.jpeg" alt="brown and white dog stands outside while it snows" caption="brown and white dog stands outside while it snows" numbered="true" >}}
    


    Original 1: brown and white dog stands outside while it snows
    Original 2: dog is looking at something near the water
    Original 3: furry dog attempts to dry itself by shaking the water off its coat
    Original 4: white and brown dog shaking its self dry
    Original 5: the large brown and white dog shakes off water
    Sampling (BLEU-1: 34.227808): dog with its mouth
    Beam Search k=3 (BLEU-1: 59.655954): black and white dog in the sand
    Beam Search k=5 (BLEU-1: 59.655954): black and white dog in the snow



    
{{< figure src="images/output_115_18.jpeg" alt="boy is jumping on bed" caption="boy is jumping on bed" numbered="true" >}}
    


    Original 1: boy is jumping on bed
    Original 2: boy jumped up from the green bed
    Original 3: boy jumps from one bed to another
    Original 4: small child is jumping on bed
    Original 5: the boy in blue shorts is bouncing on the bed
    Sampling (BLEU-1: 90.000000): the little boy is jumping on the bed
    Beam Search k=3 (BLEU-1: 77.777778): the little boy is in the tunnel
    Beam Search k=5 (BLEU-1: 77.777778): the little boy is in the air


## 10.4. Model 2 InceptionV3


```python
# load the model
filename = 'models/rnn_model_2_inceptionv3.h5'
rnn_model = load_model(filename)
# using rnn_2 and inceptionv3 model
generate_captions(rnn_model, test_descriptions, test_features, 299, 10)
```


    
{{< figure src="images/output_115_0.jpeg" alt="blond woman in blue shirt appears to wait for ride" caption="blond woman in blue shirt appears to wait for ride" numbered="true" >}}
    


    Original 1: blond woman in blue shirt appears to wait for ride
    Original 2: blond woman is on the street hailing taxi
    Original 3: woman is signaling is to traffic as seen from behind
    Original 4: woman with blonde hair wearing blue tube top is waving on the side of the street
    Original 5: the woman in the blue dress is holding out her arm at oncoming traffic
    Sampling (BLEU-1: 0.500000): the boy is wearing red hat and is wearing helmet
    Beam Search k=3 (BLEU-1: 0.600000): the boy is wearing red shirt and helmet
    Beam Search k=5 (BLEU-1: 0.500000): young boy wearing helmet and blue shirt is wearing helmet



    
{{< figure src="images/output_115_2.jpeg" alt="boy in his blue swim shorts at the beach" caption="boy in his blue swim shorts at the beach" numbered="true" >}}
    


    Original 1: boy in his blue swim shorts at the beach
    Original 2: boy smiles for the camera at beach
    Original 3: young boy in swimming trunks is walking with his arms outstretched on the beach
    Original 4: children playing on the beach
    Original 5: the boy is playing on the shore of an ocean
    Sampling (BLEU-1: 0.636364): boy in blue shirt is standing in the water
    Beam Search k=3 (BLEU-1: 0.714286): little boy in swimming pool
    Beam Search k=5 (BLEU-1: 0.857143): young boy in swimming pool



    
{{< figure src="images/output_115_4.jpeg" alt="lady and man with no shirt sit on dock" caption="lady and man with no shirt sit on dock" numbered="true" >}}
    


    Original 1: lady and man with no shirt sit on dock
    Original 2: man and woman are sitting on dock together
    Original 3: man and woman sitting on dock
    Original 4: man and woman sitting on deck next to lake
    Original 5: shirtless man and woman sitting on dock
    Sampling (BLEU-1: 0.600000): man in blue shirt is sitting on bench
    Beam Search k=3 (BLEU-1: 0.400000): the man in the blue shirt is sitting on the top of rock
    Beam Search k=5 (BLEU-1: 0.400000): the man in the blue shirt is sitting on the top of rock



    
{{< figure src="images/output_115_6.jpeg" alt="closeup of white dog that is laying its head on its paws" caption="closeup of white dog that is laying its head on its paws" numbered="true" >}}
    


    Original 1: closeup of white dog that is laying its head on its paws
    Original 2: large white dog lying on the floor
    Original 3: white dog has its head on the ground
    Original 4: white dog is resting its head on tiled floor with its eyes open
    Original 5: white dog rests its head on the patio bricks
    Sampling (BLEU-1: 0.500000): dog is jumping over log in the air
    Beam Search k=3 (BLEU-1: 0.600000): the white dog is running through the snow
    Beam Search k=5 (BLEU-1: 0.583333): the white dog is in the middle of the snow



    
{{< figure src="images/output_115_8.jpeg" alt="boy with toy gun" caption="boy with toy gun" numbered="true" >}}
    


    Original 1: boy with toy gun
    Original 2: little boy in orange shorts playing with toy
    Original 3: young boy with his foot outstretched aims toy at the camera in front of fireplace
    Original 4: young child plays with his new lightup toy
    Original 5: boy with toy gun pointed at the camera
    Sampling (BLEU-1: 0.298280): boy is holding baby on her face
    Beam Search k=3 (BLEU-1: 0.666667): the little boy is standing in front of some water
    Beam Search k=5 (BLEU-1: 0.461210): the little boy in the blue shirt is playing with brown dog



    
{{< figure src="images/output_115_10.jpeg" alt="black dog jumping to catch rope toy" caption="black dog jumping to catch rope toy" numbered="true" >}}
    


    Original 1: black dog jumping to catch rope toy
    Original 2: black dog playing fetch with ball of rope
    Original 3: black dog pounces to get rope toy
    Original 4: black dog running after his rope toy
    Original 5: large black dog is playing in grassy yard
    Sampling (BLEU-1: 0.666667): black dog is jumping into the air
    Beam Search k=3 (BLEU-1: 0.600000): the black dog is running through the grass
    Beam Search k=5 (BLEU-1: 0.600000): the black dog is running through the grass



    
{{< figure src="images/output_115_12.jpeg" alt="little tan dog with large ears running through the grass" caption="little tan dog with large ears running through the grass"  numbered="true" >}}
    


    Original 1: little tan dog with large ears running through the grass
    Original 2: playful dog is running through the grass
    Original 3: small dogs ears stick up as it runs in the grass
    Original 4: the small dog is running across the lawn
    Original 5: this is small beige dog running through grassy field
    Sampling (BLEU-1: 0.882497): dog is running through the grass
    Beam Search k=3 (BLEU-1: 0.666667): white dog is playing with green ball in the grass
    Beam Search k=5 (BLEU-1: 0.666667): white dog is playing with red ball in the grass



    
{{< figure src="images/output_115_14.jpeg" alt="baby in white garment holds flag with crescent moon and star" caption="baby in white garment holds flag with crescent moon and star" numbered="true" >}}
    


    Original 1: baby in white garment holds flag with crescent moon and star
    Original 2: baby is holding small black flag with moon and star on it
    Original 3: baby wearing white gown waves muslim flag
    Original 4: little toddler dressed in white is smiling while lady helps him wave flag
    Original 5: baby in white outfit holding black and white flag
    Sampling (BLEU-1: 0.454545): boy with his head is holding up his head
    Beam Search k=3 (BLEU-1: 0.416667): young boy is holding spoon in front of brick wall
    Beam Search k=5 (BLEU-1: 0.545455): little boy in blue shirt is playing with bubble



    
{{< figure src="images/output_115_16.jpeg" alt="brown and white dog stands outside while it snows" caption="brown and white dog stands outside while it snows" numbered="true" >}}
    


    Original 1: brown and white dog stands outside while it snows
    Original 2: dog is looking at something near the water
    Original 3: furry dog attempts to dry itself by shaking the water off its coat
    Original 4: white and brown dog shaking its self dry
    Original 5: the large brown and white dog shakes off water
    Sampling (BLEU-1: 0.584101): dog is swimming in the water
    Beam Search k=3 (BLEU-1: 0.727273): white and white dog is swimming in the water
    Beam Search k=5 (BLEU-1: 0.700000): brown and white dog swims in shallow water



    
{{< figure src="images/output_115_18.jpeg" alt="boy is jumping on bed" caption="boy is jumping on bed" numbered="true" >}}
    


    Original 1: boy is jumping on bed
    Original 2: boy jumped up from the green bed
    Original 3: boy jumps from one bed to another
    Original 4: small child is jumping on bed
    Original 5: the boy in blue shorts is bouncing on the bed
    Sampling (BLEU-1: 0.500000): two children are sitting on bed
    Beam Search k=3 (BLEU-1: 0.664073): young boy in blue shirt is sitting on bed
    Beam Search k=5 (BLEU-1: 0.664073): little boy in blue shirt is sitting on bed
