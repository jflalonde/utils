function varargout = rgb2srgb(varargin)
% Converts RGB to sRGB data.
%
%   img = rgb2srgb(img)
%   vec = rgb2srgb(vec)
%   [r,g,b] = rgb2srgb(r, g, b)
%
% Takes in image, vector (3xN) or independent channels.
%
% See http://en.wikipedia.org/wiki/SRGB
%
% ----------
% Jean-Francois Lalonde

inputType = 0; 
if nargin == 1
    if ndims(varargin{1}) == 3
        % we're given an image
        R = varargin{1}(:,:,1);
        G = varargin{1}(:,:,2);
        B = varargin{1}(:,:,3);
        
        inputType = 1;
    elseif ismatrix(varargin{1})
        % we're given a 3xN array
        assert(size(varargin{1}, 1) == 3, ...
            'Input must be of size 3xN');
        
        R = varargin{1}(1,:);
        G = varargin{1}(2,:);
        B = varargin{1}(3,:);
        
        inputType = 2;
        
    else
        error('Input must have either 2 or 3 dimensions');
    end
    
elseif nargin == 3
    % we're given the 3 channels independently
    R = varargin{1};
    G = varargin{2};
    B = varargin{3};
    
    inputType = 3;
    
else
    error('Need either one or 3 inputs');
end

% apply the colorspace transformation
R = srgbTrans(R);
G = srgbTrans(G);
B = srgbTrans(B);

    function C = srgbTrans(C)
        t = 0.0031308;
        a = 0.055;

        C(C<=t) = 12.92.*C;
        C(C>t)  = (1+a).*C.^(1/2.4)-a;
    end

switch inputType
    case 1
        % image
        [nrows, ncols, nbands] = size(varargin{1});
        R = reshape(R, [nrows, ncols, nbands]);
        G = reshape(G, [nrows, ncols, nbands]);
        B = reshape(B, [nrows, ncols, nbands]);
        varargout{1} = cat(3, R, G, B);
        
    case 2
        % 3xN vector
        varargout{1} = cat(1, row(R), row(G), row(B));
        
    case 3
        % independent channels
        varargout{1} = reshape(R, size(varargin{1}));
        varargout{2} = reshape(G, size(varargin{2}));
        varargout{3} = reshape(B, size(varargin{3}));
end

end