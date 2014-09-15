function out = convertNum(c)
    ind = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    if c <= 26
        out = ind(c);
    else
        if (c - floor(c/26)*26) ~= 0
            out = strcat(ind(floor(c/26)),ind(c - floor(c/26)*26));
        else
            out = strcat(ind(floor((c-1)/26)),'Z');
        end
    end
end