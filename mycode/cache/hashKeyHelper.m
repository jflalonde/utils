function s = hashKeyHelper(input)
% Generates a string from the input
%
%   h = struct2str(input)
%
% 'input' can be a cell array, numeric, logical, or string data type.
%
% See also:
%   getDataFromRenderingCache
%
% ----------
% Jean-Francois Lalonde

if iscell(input)
    s = cellfun(@hashKeyHelper, input, 'UniformOutput', false);
    s = cat(2, s{:});

elseif isnumeric(input) || islogical(input)
    % just convert to string
    s = num2str(row(input));
    
elseif ischar(input)
    % we have a string already
    s = input;
    
elseif isstruct(input)
    if isempty(input)
        % Empty struct
        s = '';
        
    else
        % Recurse
        input = orderfields(input); % make field-order invariant
        s = hashKeyHelper({struct2cell(input), fieldnames(input)});
    end
    
else
    % at this point, we don't support anything else
    error('Unsupported input type');
end

