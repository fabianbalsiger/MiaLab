% 3D version (slice-wise) wiener filtering of volumetric image
function imOut=median3(image)
imOut=zeros(size(image));
for i=1:size(image,3)
    imOut(:,:,i)=medfilt2(image(:,:,i),[3 3]);   %median is an expensive operation
end
