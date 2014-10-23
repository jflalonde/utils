function varargout = cacheFunction(fnHandle, varargin)
% Main 'caching' function.
%
% [...] = cacheFunction(fnHandle, ...)
%
% [...] = cacheFunction(fnHandle, 'hashKey', hashKey, ...)
%
%   Over-ride hash key with input one. Use at your own risk!
%
% 
% ----------
% Jean-Francois Lalonde
%

% look for 'hashKey' in the inputs
indHashKey = find(strcmp(varargin, 'hashKey'));
if ~isempty(indHashKey)
    h = varargin{indHashKey+1};
    varargin(indHashKey:indHashKey+1) = [];
else
    h = hashKey(varargin{:});
end

cachePath = getPathName('results', 'cache');
cacheFile = fullfile(cachePath, func2str(fnHandle), [h '.mat']);

if exist(cacheFile, 'file')
    fprintf('Results of %s found in cache. Retrieving...\n', ...
        func2str(fnHandle)); tic;
    
    % has been cached already! just load from cache
    results = loadSorted(cacheFile);
    varargout = results.results(1:nargout);
else
    % has not yet been cached. compute (and store) it.
    fprintf('Not found in cache. Computing %s...', ...
        func2str(fnHandle)); tic;
    
    results = cell(1, nargout);
    [results{:}] = fnHandle(varargin{:});
    [~,~,~] = mkdir(fileparts(cacheFile));
    save(cacheFile, 'results');
    
    varargout = results;
    
    fprintf('done in %2.fs\n', toc);
end
    