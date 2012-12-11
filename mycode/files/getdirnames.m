function files = getdirnames(path, pattern, fullpath)
% Return cell array of directories matching the pattern at the specified path.
% 
%   files = getdirnames(basePath, pattern, fullpath)
%
%   'pattern': pattern to be matched. 
% 
%   'fullpath': boolean (defaults to false). When 'true', returns the full
%   path for each file.
%   
% 
% ----------
% Jean-Francois Lalonde

if nargin < 2
    pattern = '';
end

if nargin < 3
    fullpath = false;
end

files = dir(fullfile(path, pattern));
dirInd = [files(:).isdir];
files = {files(dirInd).name};

% remove hidden directories
hiddenFilesInd = cellfun(@(x) x(1)=='.', files);
files(hiddenFilesInd) = [];

% concatenate full path to each file
if fullpath
    files = fullfile(path, files);
end