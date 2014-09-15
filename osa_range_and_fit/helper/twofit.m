% Helper function for 'fit', this code
% fits a double peak lorentzian using
% the lsqcurvefit and a predefined 
% lorentzian function (sum of 2 different lorentzians)
% input:  -X contains all the X values
%         -Y contains all the Y values
%         -xu and yu are subsets of X and Y
%         5 FWHM around the two peaks
%         -min1 and min2 are the y values 
%         of the 2 peaks
% output: 2 by 7 array
%         first row being fitting variables
%         formated like X0 below (also lorn2.m)
%         second row is the Q values
%         in order of the x position (b)
%         of the fitting in the first row
% last updated: 8/1/2012

function [out] = twofit(X,Y,xu,yu,min1,min2)
Y = -Y; 
[minp,mind] = min(Y);

b = xu(find(yu == min1, 1, 'first'));
c = minp;
w = (xu(end) - xu(1))/10;
A = (-min1 - minp)/(1/(pi*w));

b2 = xu(find(yu == min2, 1, 'first'));
w2 = w;
A2 = (-min2 - minp)/(1/(pi*w2));

X0 = [A, b, w, A2, b2, w2, c]  %*******
i = 400;
options = optimset('LevenbergMarquardt','on','Display','iter','TolFun',1e-30,'TolX',1e-30,'MaxFunEvals',i);

x = lsqcurvefit(@lorn2,X0,xu,-yu,[],[],options);
% below values are negated
% because the fit is done with the y values
% flipped
x(1) = -x(1); 
x(4) = -x(4);
x(7) = -x(7);
A = x(1); %scale
b = x(2); %middle
w = x(3); %gamma
c = x(4); %offset
f = @(x,A,b,w,A2,b2,w2,c) c + (2*A./pi).*(w./(4*(x-b).^2 + w.^2)) + (2*A2./pi).*(w2./(4*(x-b2).^2 + w2.^2));
Y = -Y;
%plot(X,f(X,X0(1),X0(2),X0(3),X0(4),X0(5),X0(6),X0(7)),'g');
plot(X,f(X,x(1),x(2),x(3),x(4),x(5),x(6),x(7)),'r');
out = x;
Q = [x(2)/x(3), x(5)/x(6)];
out(2,1:2) = Q;
end