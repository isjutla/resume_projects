% number must in the form _ _p_ _
% as in, one or two digits before p and
% one or two digits after p. (no more, no less)

function [out] = findpiezo(n)
out = 0;
a = findstr(n,'piezo');
n = n(a:end);
b = findstr(n,'p');
b = b(2);
num1 = n(6:b-1)
num2 = n(b+1:b+2)
if isempty(str2num(n(b+2)))
    num2 = n(b+1);
    out = out + str2num(num2)/10;
else
    out = out + str2num(num2)/100;
end
out = out + str2num(num1);
end
    
