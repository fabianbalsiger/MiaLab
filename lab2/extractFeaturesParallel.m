% takes images in path2Images and extracts features
% Images for feature extraction are encoded as image*.mhd while label
% images are encoded as labels*.mhd
%featureArray is an array with rows as observations and colums as feature
%variables

function [X,Y,procImages]=extractFeaturesParallel(path2Images,nimages,proportionSamples)

%% loop through each image and extract features
path2InputImages=strcat(path2Images,'image*.mhd');
path2LabelImages=strcat(path2Images,'labels*.mhd');

dirlist_InputImages = dir(path2InputImages);
dirlist_LabelImages = dir(path2LabelImages);

%read input and label images
%lenghty loop, adding a waitbar
h = waitbar(0,'...Initializing parallel computing, please wait...');
for i = 1:nimages 

    %strings pointing to each image
    path2Image=strcat(path2Images,dirlist_InputImages(i).name);
    path2LabelImage=strcat(path2Images,dirlist_LabelImages(i).name);
    
    %experimentng with parallel computing features of matlab. Extracting
    %features per image. Future element (matlab lingo for worker in
    %parallel computing), stores each result. Check parfeval doc for details on
    %arguments. 
    F(i) = parfeval(@extractFeaturesSingleImage,2,path2Image,path2LabelImage,proportionSamples);
    myImage=mha_read_volume(path2Image);
    %handler for processed images
    subplot(floor(sqrt(nimages)),ceil(nimages/(floor(sqrt(nimages)))),i);viewImage(myImage,[1,1,1]); % to fix hard-coded voxelSize! 

    waitbar(i/nimages,h,strcat('Processing image',num2str(i)));
    
end
disp('----fetching output');
[X,Y]=fetchOutputs(F); 

%delete(gcp);
disp('----done with feature extraction');

