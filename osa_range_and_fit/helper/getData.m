% Parses the data output by: 
% 'SDL_LaserScanWithPhaseAndErrorSignal_vsTime_2Detectors'
% Data is put into an n by 2 array. The first 
% column being the x values, wavelength
% and the second column being the intensity
% input: filename of the data
% output: n by 2 array of data as described
% last updated: 8/1/2012

function [out] = getData(file)
k = textread(file,'%s','delimiter',',');
m = [];
for i = 9:length(k)
    m = [m; str2num(cell2mat(k(i)))];
end
out = m(:,1:2);
end