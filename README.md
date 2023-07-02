# IAS_project
Final project for IAS class 

## Abstract:
This project is based on the extraction of features from audio 
data, their visualization and the training of kNN classifiers with such 
data.
Audio data has to be divided in training and testing sets, time and 
frequency domain features are extracted and the feature space is 
visualized. the kNN classifier is then trained on three groups of 
features and the optimal k is found. In the final stage the aim is 
optimization of the best performing classes.
Three classes of audio data where chosen. the classes are purposefully 
chosen with similar sounding sounds (Breathing, Sneezing and Snoring) and 
the recognition rate is expected not to be higher than 5% more than pure 
fortuity.
To approach this project i decided to only use the functions 
provided in the audioAnalysisLibrary so I had to make my own 
implementation of the windowize, extract_from_path, a function to extract 
all the audio features and one to train the kNN. I chose to do so to gain 
a deeper understanding of the matter..
Results show that:

- number of coefficients which explain 80% of variance is 10 and the most 
significant ones are frequency domain features.

- the best number for k is around 100 and works better with the third 
group (time and frequency together).

- winlength optimization improves recognition rates by 3,9351% with best winlength being: 50ms

## Introduction:
The extraction of features from audio data is a useful and 
powerfull tool for a lot of applications. It is a necessary step before 
any decision, interpretation or classification. These audio descriptors 
are low-level features and may not be meaningfull by themselves, 
manipulation and correlation is needed to make use of this short term 
data. Another advantage of feature extraction is the reduction of the volume of data. This is particularly usefull in real time systems, as 
audio streams can be very heavy.
Audio signals are divided in small blocks (frames) which can be 
overlapping and for each frame a set of features is computed. the result 
is a feature vector that can be used for analysis and processing 
purposes.
There are two main categories of audio features. Frequency and Time 
domain features.
Time domain features are calculated over time and are relevant to energy 
entropy and statistical aspects.
Energy, Energy Entropy and Zero Crossing Rate are computed and can be
particularly relevat in situation where temporal aspects are predominat 
rather than timbral/spectral.
Frequency domain features are based on the DFT of the audio signal and 
perform spectral analysis on the frames.

## Project:
The Dataset is composed of 40 .ogg audio tracks for each category (Breathing, Sneezing, Snoring). Each category is divided in a test and a train group.
The project is split in 4 scripts and three functions for extracting audio data.
it has been split like that to help during troubleshooting and debugging as the extraction of data is very time consuming.
keeping it isolated from the code that performs analisys speeds up the process.
script.m is tasked with the extraction of features from the train set.
script2.m performs and plots PCA in 3-D space.
script3.m extracts features from the test set.
script4.m performs kNN analysis of the three groups of features
script5.m optimizes the windowlength for the best performing group, the code is essentially all the above copied in a loop

## Results:
The dataset is extracted with a windowlength of 15 ms, and then normalized.
The extraction process is done both for Time-domain and Frequency-domain features.
next PCA is performed on the train set and graphically plottted.
the kNN classification is performed for three groups of features:
Time-Domain
Frequncy-Domain
Alltogheter
and for different values of k: 
k = 1,2,3,5,7,10,15,20,50,75,100,250.
the classification rates are plotted and windowlength optimization is performed for the best performing group of features.

The principal component analisys (PCA) doesn't really help much graphically in the understanding of the differences of the three principal components.

![image](/images/before.png)
![image](/images/after.png)

This is explained because the number of coeeficients required to explain 80% of variance is 10 which is relatively high.

![image](/images/coeffs.png)

Recognition rates for all the three groups at 15 ms are very poor and the best performing group is the Alltogether group  with the best recognition rate being 53.2871 with 100 nearest neighbors, and the worst being Time-Domain. the poor performance of Time-Domain features may be caused by the short windowlength.

![image](/images/kNNrates.png)


The best value for k for every group is 100 so windowlength optmization is performed with 100 nearest neighbors.
Windowlength optimization gives unexpected results as performance is increased to 57.2222 which is an imrovement of 3.9351% with a windowlength of 50 ms

![image](/images/winlenOpt.png)


