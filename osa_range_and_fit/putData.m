% fits all data in directory 'direct'
% and puts them in the appropriately 
% formatted excel file 'file'
% Note: order may be abritrary based on
% how you name the files

function [] = putData(direct,file)
    addpath('helper')
    fileList = dir(direct);
    direct = strcat(direct,'/');
    for ii = 3:numel(fileList)
        writeData(strcat(direct,fileList(ii).name),file,ii-2)
        t = getData(strcat(direct,fileList(ii).name));
        writefit(fit(t),file,ii-2)
        hold off
    end