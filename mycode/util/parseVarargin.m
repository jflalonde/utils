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
%   % parse input arguments
%   parseVarargin(varargin{:});
%
%   % var1 and var2 now have the updated value passed in as (optional)
%   argument
%
% ----------
% Jean-Francois Lalonde

if mod(nargin,2)==1
    % first argument will specify whether to display list or not when there
    % are no other arguments
    displayArgs = varargin{1};
    varargin = varargin(2:end);
else
    % defaults to displaying the arguments
    displayArgs = true;
end
    

narginCaller = evalin('caller', 'nargin');
if narginCaller == 0 && displayArgs
    % Display list of possible arguments and their types
    args = evalin('caller', 'whos');
    
    % TODO: parse the file and automatically retrieve the comments directly
    % above the line where the argument is declared. Output it below. 
    fprintf('Possible optional arguments: \n');
    for i_arg=1:length(args)
        % ignore 'varargin'
        if ~strcmp(args(i_arg).name, 'varargin')
            fprintf('  %s (%s)\n', args(i_arg).name, args(i_arg).class);
        end
    end
    
    error('parseVarargin:displayArgs', ...
        ['Call function again with valid parameters.' ...
        '\n (this error is normal -- blame Matlab''s inability to stop execution cleanly.)']);
end

for i = 1:2:length(varargin)
    if ~(evalin('caller', sprintf('exist(''%s'')', varargin{i}))==1)
        error('Parameter "%s" not recognized.', varargin{i});
    end
    assignin('caller', varargin{i}, varargin{i+1});
end
