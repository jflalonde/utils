function parseVarargin(varargin)
% Parse the list of "extra" arguments in pairs, resetting any valid variables
%
%   parseVarargin(<Name1, Val1>, <Name2, Val2>, ..., <NameN, ValN>);
%
% Usage:
% 
%   % declare list of variables and their defaults values
%   var1 = 1;
%   var2 = 'hello';
%
%   % parse varargin
%   parseVarargin(varargin{:});
%
%   % var1 and var2 now have the updated value passed in as (optional)
%   argument
%
% ----------
% Jean-Francois Lalonde

for i = 1:2:length(varargin)
    if ~evalin('caller', sprintf('exist(''%s'')', varargin{i}))
        error('Parameter "%s" not recognized.', varargin{i});
    end
    assignin('caller', varargin{i}, varargin{i+1});
end
