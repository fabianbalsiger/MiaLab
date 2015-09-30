function [ avg ] = voxelAvg( I, x, y, z )
%VOXELAVG Computes the average of a 3x3x3 volume around a voxel.
%   VOXELAVG(I, x, y, z) computes the average of a 3x3x3 volume
%   around the voxel at position x, y, z.

    % can throw "Index exceeds matrix dimensions"
    A = I(x-1:x+1, y-1:y+1, z-1:z+1);
    
    avg = mean(mean(mean(A)));
end

