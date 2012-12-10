function s = struct2numeric(s)
% Converts all string fields in a struct to numeric values (when possible)
%
% ----------
% Jean-Francois Lalonde
    
for i_array = 1:numel(s)
    % get field names
    fNames = fieldnames(s(i_array));
    
    for i_field = 1:length(fNames)
        curField = fNames{i_field};
        if isstruct(s(i_array).(curField))
            s(i_array).(curField) = struct2numeric(s(i_array).(curField));
        else
            % try converting to numeric
            if ischar(s(i_array).(curField))
                [n,status] = str2num(s(i_array).(curField));
                if status
                    % this worked!
                    s(i_array).(curField) = n;
                end
            end
        end
    end
end
