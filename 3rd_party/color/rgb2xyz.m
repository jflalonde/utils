function [X,Y,Z] = rgb2xyz(R,G,B)
% Converts RGB to XYZ data.
%
%   xyz = rgb2xyz(rgb)
% 
% Converts between images.
%
%   [x, y, z] = rgb2xyz(r, g, b)
%
% Converts between individual channels.
%
% See http://en.wikipedia.org/wiki/CIE_1931_Color_Space
%
% ----------
% Jean-Francois Lalonde

if (nargin == 1)
    B = R(:,:,3);
    G = R(:,:,2);
    R = R(:,:,1);
end

[m, n] = size(R);

M = [0.412453 0.357580 0.180423; 0.212671 0.715160 0.072169; 0.019334 0.119193 0.950227];

res = M * [R(:)'; G(:)'; B(:)'];

X = reshape(res(1,:), m, n);
Y = reshape(res(2,:), m, n);
Z = reshape(res(3,:), m, n);

if ((nargout == 1) || (nargout == 0))
    X = cat(3,X,Y,Z);
end