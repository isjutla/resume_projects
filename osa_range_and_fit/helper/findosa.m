% Helper function for 'spanosa'
% This code computes the half with maximum
% assuming the minimum of the array given
% is the peak of the function (only works
% for a single peak
% output: x position of FWHM (either right
%         or left of peak depending on input)
% last updated: 1/14/2013

function [out] = findosa(osa)
a = min(osa(:,2)) + max(osa(:,2));

[~,lmin] = min(osa(:,2));
%%lmin = find(osa(:,2) == min(osa(:,2)),1,'first');
a = a/2; %%FWHM value
est = 100;
loc = 0;
for i = 1:length(osa(:,2)) %%finds point closest to FWHM
    if(abs(osa(i,2) - a) < est)
        est = abs(osa(i,2) - a);
        loc = i;
    end
end
out = osa(loc,2);
y1 = out;

%finds next point that creats a line crossing the FWHM
if (loc < lmin && out > a) || (loc > lmin && out < a) 
        x2 = loc + 1;
else
        x2 = loc - 1;
end

%finds slope
if loc==1 %AJG added these if statements to avoid accessing 0th or past the last elements.
        x2=loc+1;
elseif loc==length(osa(:,2))
        x2=loc-1;
end
y2 = osa(x2,2);
if x2 > loc
    m = (y2 - y1)/(osa(x2,1) - osa(loc,1));
else
    m = (y1 - y2)/(osa(loc,1) - osa(x2,1));
end

%linear interpolation to find 'exact' point of FWHM
b = y1 - m*osa(loc,1);
out = (a - b)/m;
plot(osa(:,1),osa(:,2))
hold on