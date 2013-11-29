function h = hashKey(input)
% Generates a hash key from the input
%
%   h = hashKey(input)
%
% 'input' can be a cell array, numeric, logical, or string data type.
%
% See also:
%   getDataFromRenderingCache
%
% ----------
% Jean-Francois Lalonde

if iscell(input)
    % we're dealing with a cell array
    % hash each component independently, then combine the hashes
    hs = cellfun(@hashKey, input, 'UniformOutput', false);
    hs = cat(2, hs{:});
    
    h = hashKeyFromString(hs);
    
elseif isnumeric(input) || islogical(input)
    % just convert to string
    h = hashKeyFromString(num2str(row(input)));
    
elseif ischar(input)
    % we have a string already
    h = hashKeyFromString(input);
    
else
    % at this point, we don't support anything else
    error('Unsupported input type');
end


function h = hashKeyFromString(str)
% Helper: call md5 to generate a hash key from a string

[r,h] = system(sprintf('md5 -q -s ''%s''', str));

% strip trailing eol
h = h(1:end-1);

if r ~= 0
    error('hashKey:md5', 'Error running the md5 command');
end