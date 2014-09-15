% Used to pick out points where the slope
% changes sign (e.g. negative to positive)
% these points should include the peak. I will refer
% to these points as 'curvepoints'
% input: n by 2 array, e.g. something output by getData
% output: m by 4 array
% last updated: 1/14/2013

function [out] = curvepoints(osa)
t = osa;
x = []; %x position of point
y = []; %y posiiton of point
z = []; %index in the original array for the point
c = []; %whether it curves down or up (1 for down, -1 for up)

%if change in the sign of the slope occurs, it is marked
%x,y are the coordinates of the point, z is the element # in the array
for i = 2:(length(t(:,1))-1)
    s1 = (t(i,2) - t(i-1,2))/(t(i,1)-t(i-1,2));
    s2 = (t(i+1,2) - t(i,2))/(t(i+1,1)-t(i,2));
    if (s1 > 0 && s2 < 0) 
        x = [x,t(i,1)];
        y = [y,t(i,2)];
        z = [z,i];
        c = [c,-1];
    elseif (s1 <= 0 && s2 >= 0)
        x = [x,t(i,1)];
        y = [y,t(i,2)];
        z = [z,i];
        c = [c,1];
    end
end
out = [x',y',z',c'];
end

% fileList = dir('ScanSet');
% for ii = 3:numel(fileList)
% t = getData(strcat('ScanSet/',fileList(ii).name));
% hold off
% spanosa(t)
% pause
% end