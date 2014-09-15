% Helper function for the curvefit
% for onefit, single peak lorentzian
% last updated: 8/1/2012

function out = lorn(t,X)

A = t(1); %scaling
b = t(2); %middle, min
w = t(3); %gamma
c = t(4); %height, max, y offset
out = c + (2*A./pi).*(w./(4*(X-b).^2 + w.^2));