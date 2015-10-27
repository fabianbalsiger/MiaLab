myImage_path='../Data/';
nimages=5;
proportionSamples=0.05;

path2Images = myImage_path;

path2InputImages=strcat(path2Images,'image*.mhd');
path2LabelImages=strcat(path2Images,'labels*.mhd');

dirlist_InputImages = dir(path2InputImages);
dirlist_LabelImages = dir(path2LabelImages);

for i = 1:nimages 
    %strings pointing to each image
    path2Image=strcat(path2Images,dirlist_InputImages(i).name);
    path2LabelImage=strcat(path2Images,dirlist_LabelImages(i).name);
    
    %experimentng with parallel computing features of matlab. Extracting
    %features per image. Future element (matlab lingo for worker in
    %parallel computing), stores each result. Check parfeval doc for details on
    %arguments. 
    [X, Y] = extractFeaturesSingleImage(path2Image,path2LabelImage,proportionSamples);
    
    %F(i) = parfeval(@extractFeaturesSingleImage,2,path2Image,path2LabelImage,proportionSamples);
    %myImage=mha_read_volume(path2Image);
end