function [ variance ] = voxelVar( I, x, y, z )
%VOXELVAR Computes the variance of a 3x3x3 volume around a voxel.
%   VOXELVAR(I, x, y, z) computes the variance of a 3x3x3 volume
%   around the voxel at position x, y, z.

    A = I(x-1:x+1, y-1:y+1, z-1:z+1);
    A = double(A);
    
    variance = var(var(var(A)));
end

