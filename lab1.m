% MIA Lab 1 2015 
% author: Mauricio Reyes


%% General parameters
clear all;
myImage_path='/Users/fabianbalsiger/Documents/biomedical engineering/3. Semester/Medical Image Analysis Lab/Data/image-001.mhd';
myImageLabel_path='/Users/fabianbalsiger/Documents/biomedical engineering/3. Semester/Medical Image Analysis Lab/Data/labels-001.mhd';
voxelSize=[1.2,1.2,1.2];
origin=[-37.888,-21.483,148.563];
%% Read image
myImage=mha_read_volume(myImage_path);
%% image visualization
[x,y,z] = meshgrid(1*voxelSize(1):voxelSize(2):size(myImage,2)*voxelSize(1),1*voxelSize(1):voxelSize(1):size(myImage,1)*voxelSize(1),1*voxelSize(3):voxelSize(3):size(myImage,3)*voxelSize(3));
xslice = []; yslice = []; zslice =[40];
h=slice(x,y,z,double(myImage),xslice,yslice,zslice);
set(h,'EdgeColor','none');
hold on;
zoom(1.5);view(2);axis equal;

%% Read segmentation, and visualize its mesh representation
myImageLabel=mha_read_volume(myImageLabel_path);
p=patch(isosurface(x,y,z,myImageLabel,0));
isonormals(x,y,z,myImageLabel,p);
set(p,'facecolor','red','edgecolor','none','FaceAlpha',0.5);
view(3); axis tight; grid on;
camlight;

%% End of Lab 1 session
% Homework:
% Code functions for
% Compute and visualize image histogram
% Image cropping
% Compute average and variance on a 3x3x3 area around a voxel
% 
