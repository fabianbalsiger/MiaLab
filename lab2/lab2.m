% Lab 2
% author: Mauricio Reyes
%Objectives: perform pre-processing of the image, and construct Rf model
%for classification


%% General parameters
clear all;
% random select features that describe your segmentation
myImage_path='../Data/';
voxelSize=[1.2,1.2,1.2];
origin=[-37.888,-21.483,148.563];
proportionSamples=0.05; %proportion of samples used for creating the model
numTrees=2; % needs to be optimised!!! % overfitting -> numTrees = 1
nimages=5; %10; % use first n images to train the model, the rest will be used to test in Lab3.
%% Read images, preprocess and extract features
[X, Y]=extractFeaturesParallel(myImage_path,nimages,proportionSamples);
% X - features (intensities; corresponding output (segmentation, binary)?
% balance (nsamples), features are important
% feature upper part... spatial feature...?

% function viewImage?

%% Train a decision tree model
treeModel = TreeBagger(numTrees,X,Y,'OOBPred','On');
disp('---Model built');
%save model to file
%save(strcat('treeModelEntropy_ntrees',num2str(numTrees),'_nimages',num2str(nimages),'.mat'),'treeModel','-v7.3'); %v7.3 is to be able to save large variables
%% Check quality of model with a cross-evaluation
oobErrorBaggedEnsemble = oobError(treeModel);
plot(oobErrorBaggedEnsemble)
xlabel 'Number of grown trees';
ylabel 'Out-of-bag classification error';

% end of Lab 2
% Tasks:
% 1.- Study the effect of preprocessing on OOB error.
% 2.- Study the concept of overfitting and the effect of depth of the model ('MinLeafSize', 'NumTrees=1' vs NumTrees>100 or large number).
% 3.- Change the extractFeaturesSingleImage.m function to include skewness
% and entropy (check entropyfilt), check the matlab doc for these two. Analyze the effect of
% adding these two features to the OOB Error.

%% 



figure;
plot(oobErrorBaggedEnsemble)
xlabel 'Number of grown trees';
ylabel 'Out-of-bag classification error';
