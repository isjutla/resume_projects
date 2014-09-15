% Helper function for 'fit', this code
% fits a single peak lorentzian using
% the lsqcurvefit and a predefined 
% lorentzian function
% input:  X contains all the X values
%         Y contains all the Y values
%         xu and yu are subsets of X and Y
%         5 FWHM around the peak
% output: 2 by 4 array,
%         first row being fitting constants
%         formated like X0 below (also lorn.m)
%         second row is Q value
% last updated: 8/1/2012

function [out] = onefit(X,Y,xu,yu)
Y = -Y; 
[minp,mind] = min(Y);
[maxp,maxd] = max(Y);
b = X(maxd);
c = minp;
w = (xu(end) - xu(1))/4;
A = (maxp - minp)/(1/(pi*w));
X0 = [A,b,w,c];
i = 400;
options = optimset('LevenbergMarquardt','on','Display','iter','TolFun',1e-30,'TolX',1e-30,'MaxFunEvals',i);

x = lsqcurvefit(@lorn,X0,xu,-yu,[],[],options);
x(1) = -x(1);
x(4) = -x(4);
A = x(1); %scale
b = x(2); %middle
w = x(3); %gamma
c = x(4); %offset
f = @(x,A,b,w,c) c + (2*A./pi).*(w./(4*(x-b).^2 + w.^2));
Y = -Y;
plot(X,f(X,x(1),x(2),x(3),x(4)),'r');
out = x;
Q = [x(2)/x(3)];
out(2,1) = Q;
end