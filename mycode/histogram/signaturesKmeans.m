%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function weights = signaturesKmeans(data, nbClusters)
%  Computes signatures using k-means clustering, and return their weights (% of points belonging to
%  each cluster). Can be used in conjunction with EMD.
%
% Input parameters:
%   - data: input data NxD (N = nb points, D = dimensions)
%   - nbClusters: number of clusters to use
%
% Output parameters:
%   - centers: cluster centers (same dimension as input space)
%   - weights: weights of each cluster (% of points belonging to that cluster)
%   - inds: assignments for each point to a cluster center
%   
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [centers, weights, inds] = signaturesKmeans(data, nbClusters)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Copyright 2006-2007 Jean-Francois Lalonde
% Carnegie Mellon University
% Do not distribute
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% cluster the input data
centers = vgg_kmeans(data', nbClusters, 'maxiters', 500, 'mindelta', 1e-2);

% compute assignments
[inds, d2] = vgg_nearest_neighbour(data', centers);

% count number of points in each cluster
counts = histc(inds, 1:nbClusters);

% drop the centers which do not contain any weight
centers = centers';
centers = centers(counts > 0, :);
counts = counts(counts > 0);

% re-compute assignments
[inds, d2] = vgg_nearest_neighbour(data', centers');

% normalize and reshape
weights = counts ./ sum(counts(:));

