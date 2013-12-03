function varargout = cacheFunction(fnHandle, varargin)
% Main 'caching' function.
%
%   [...] = cacheFunction(fnHandle, ...)
%
% 
% ----------
% Jean-Francois Lalonde
%

h = hashKey(varargin{:});

cachePath = getPathName('results', 'cache');
cacheFile = fullfile(cachePath, func2str(fnHandle), [h '.mat']);

if exist(cacheFile, 'file')
    fprintf('Found in cache. Retrieving...\n'); tic;
    
    % has been cached already! just load from cache
    results = loadSorted(cacheFile);
    varargout = results.results(1:nargout);
else
    % has not yet been cached. compute (and store) it.
    fprintf('Not found in cache. Computing...'); tic;
    
    results = cell(1, nargout);
    [results{:}] = fnHandle(varargin{:});
    [~,~,~] = mkdir(fileparts(cacheFile));
    save(cacheFile, 'results');
    
    varargout = results;
    
    fprintf('done in %2.fs\n', toc);
end
    