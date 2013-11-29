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
    % this may be big, so we'll first convert to string, then hash
    h = hashKey(hashKeyHelper(input));
    
elseif isnumeric(input) || islogical(input)
    % just convert to string
    h = hashKeyFromString(num2str(row(input)));
    
elseif ischar(input)
    % we have a string already
    h = hashKeyFromString(input);
    
elseif isstruct(input)
    if isempty(input)
        % Empty struct
        h = hashKey('empty.struct');
        
    elseif isfield(input, 'hashKey') && ~isempty(input.hashKey)
        % Check if there's already a hash key in there
        h = input.hashKey;
        
    else
        % Convert to string first, then call the hash key on it.
        h = hashKey(hashKeyHelper(input));
    end
    
else
    % at this point, we don't support anything else
    error('Unsupported input type');
end


function h = hashKeyFromString(str)
% Helper: call md5 to generate a hash key from a string

% if the string is too large, write it to a file otherwise it doesn't seem
% to work. What's the maximum string size though?
if length(str) > 1000
    tmpFilename = tempname;
    fid = fopen(tmpFilename, 'w');
    fprintf(fid, '%s', str);
    fclose(fid);
    
    [r,h] = system(sprintf('md5 -q %s', tmpFilename));

else
    [r,h] = system(sprintf('md5 -q -s ''%s''', str));
end

% strip trailing eol
h = h(1:end-1);

if r ~= 0
    error('hashKey:md5', 'Error running the md5 command');
end