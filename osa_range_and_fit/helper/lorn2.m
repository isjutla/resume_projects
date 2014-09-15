% Helper function for the curve fitting
% in twofit, superposition of two lorentzians
% last updated: 8/1/2012

function out = lorn2(t,X)

A = t(1); %scaling
b = t(2); %middle, min
w = t(3); %gamma
A2 = t(4);
b2 = t(5);
w2 = t(6);
c = t(7); %height, max, y offset
out = c + (2*A./pi).*(w./(4*(X-b).^2 + w.^2)) + (2*A2./pi).*(w2./(4*(X-b2).^2 + w2.^2));