function [ B ] = imgHist( A, xMin, xMax, yMin, yMax )
%IMGCROP Crop image.
%   IMGCROP(A, xMin, xMax, yMin, yMax) crops the image A
%   from xMin to xMax and yMin to yMax.
    
    B = A(xMin:xMax, yMin:yMax, :);
end

