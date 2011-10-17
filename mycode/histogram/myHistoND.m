%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function [hist, binInd] = myHistoND(vec, nbBins, varargin)
%  Computes the N-dimensional histogram of an input vector. 
%
% Input parameters:
%   - vec: the input vector (size MxN)
%   - nbBins: number of bins of the output histogram. MUST be the same in
%   each dimension
%   - varargin: Override the min and max with input values. Must be 1xN
%   vectors
%
% Output parameters:
%   
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [hist, binInd] = myHistoND(vec, nbBins, varargin) 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Copyright 2006-2007 Jean-Francois Lalonde
% Carnegie Mellon University
% Do not distribute
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% make sure varargin is well formatted
if ~isempty(varargin)
    if length(varargin) ~= 2
        error('Incorrect input arguments: must be [image, nbBins, min, max]')
    end
end

% override min/max with input arguments
if ~isempty(varargin)
    minVals = varargin{1};
    maxVals = varargin{2};
    
    minVals = minVals(:)';
    maxVals = maxVals(:)';
else
    minVals = min(vec);
    maxVals = max(vec);
end

nbDims = size(vec, 2);

% compute the edges in each dimension
span = maxVals - minVals;
step = repmat(span ./ nbBins, nbBins+1, 1);
edges = repmat((0:nbBins)', 1, nbDims) .* step + repmat(minVals, nbBins+1, 1);
edges(end,:) = edges(end,:) + eps;

c = mat2cell(edges, size(edges, 1), ones(1, nbDims));
[hist, binInd] = histnd(vec, c{:});

s = size(hist);
ind = cell(1,size(s,2));
for j=1:size(s, 2);
    ind{j} = 1:(s(j)-1);
end

if size(hist,2) == 1
    ind{2} = 1;
end

newInd = reshape(1:numel(hist), size(hist));
[r,c] = ind2sub(size(newInd), binInd);

hist = hist(ind{:});
newInd = newInd(ind{:});

if nargout > 1
    % compute new bin indices
    binIndT = arrayfun(@(x) find(newInd==x), binInd(~isnan(binInd)));
    binInd(~isnan(binInd)) = binIndT;
%     binInd = newInd(sub2ind(size(newInd), r, c));
end
