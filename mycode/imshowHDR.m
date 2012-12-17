function varargout = imshowHDR(img, varargin)
% Displays an image, with keyboard shortcuts to in(de)crease the exposure.
% 
%   <h> = imshowHDR(img)
% 
% Press:
%   cmd-] to increase the exposure
%   cmd-[ to decrease the exposure
%   cmd-0 to reset the exposure
%
% ----------
% Jean-Francois Lalonde


h = imshow(img, varargin{:});

if nargout == 1
    varargout{1} = h;
end

axesHandle = get(h, 'Parent');
figHandle = get(axesHandle, 'Parent');

% Store info in the axes 'UserData' field
axesData.imgScaleFactor = 1;
axesData.img = img;
axesData.imgHandle = h;
set(axesHandle, 'UserData', axesData);

set(figHandle, 'WindowKeyPressFcn', @keyPressFcn);

    function keyPressFcn(figHandle, event)
        if any(strcmp(event.Modifier, 'command'))
            % 'command' key is held down
            
            currAxes = get(figHandle, 'CurrentAxes');
            axesData = get(currAxes, 'UserData');
            
            if ~isempty(axesData)
                switch event.Character
                    case '['
                        % decrease exposure
                        axesData.imgScaleFactor = axesData.imgScaleFactor/1.5;
                        set(currAxes, 'UserData', axesData);
                        updateDisplay(axesData);
                        
                    case ']'
                        % increase exposure
                        axesData.imgScaleFactor = axesData.imgScaleFactor*1.5;
                        set(currAxes, 'UserData', axesData);
                        updateDisplay(axesData);
                        
                    case '0'
                        % reset exposure
                        axesData.imgScaleFactor = 1;
                        updateDisplay(axesData);
                end
            end
        end
    end

    function updateDisplay(axesData)
        set(axesData.imgHandle, ...
            'CData', min(max(axesData.img*axesData.imgScaleFactor, 0), 1));
    end

end
