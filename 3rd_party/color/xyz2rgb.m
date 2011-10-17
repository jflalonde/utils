%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function [R,G,B] = xyz2rgb(X,Y,Z)
%  Converts an image in XYZ format to the RGB format
% 
% Input parameters:
%
% Output parameters:
%   
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [R,G,B] = xyz2rgb(X,Y,Z)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Copyright 2006-2007 Jean-Francois Lalonde
% Carnegie Mellon University
% Do not distribute
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if (nargin == 1)
    X = im2double(X);
    
    Z = X(:,:,3);
    Y = X(:,:,2);
    X = X(:,:,1);
end

[m, n] = size(X);

M = [3.2404813 -1.5371515 -0.4985363; -0.9692549 1.8759900 0.0415559; 0.05564663 -0.20404133 1.0573110];
   
res = M * [X(:)'; Y(:)'; Z(:)'];

R = reshape(res(1,:), m, n);
G = reshape(res(2,:), m, n);
B = reshape(res(3,:), m, n);

if ((nargout == 1) || (nargout == 0))
    R = cat(3,R,G,B);
end