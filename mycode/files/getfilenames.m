function files = getfilenames(path, pattern, fullpath)
% Return cell array of files matching the pattern at the specified path.
% 
%   files = getfilenames(basePath, pattern, fullpath)
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

% special case: when 'pattern' is 'images', look for all types of images
if strcmp(pattern, 'images')
    files = dir(fullfile(path));
    files = {files(:).name};
    
    % TODO: add more here, as needed!
    imgExt = {'.jpg', '.jpeg', '.tif', '.tiff', '.png'};
    
    validInd = false(size(files));
    for i_ext = 1:length(imgExt)
        validInd = validInd | ...
            ~cellfun(@isempty, strfind(lower(files), imgExt{i_ext}));
    end
    
    files = files(validInd);
    
else
    files = dir(fullfile(path, pattern));
    files = {files(:).name};
end


% remove hidden files
hiddenFilesInd = cellfun(@(x) x(1)==1, strfind(files, '.'));
files(hiddenFilesInd) = [];

% concatenate full path to each file
if fullpath
    files = fullfile(path, files);
end