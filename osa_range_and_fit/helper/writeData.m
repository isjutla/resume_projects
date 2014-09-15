function [] = writeData(file,wfile,num)
piezo = findpiezo(file);
sn = 4;
num = num-1;
pl = convertNum(num*5 + 2);
sl = convertNum(num*5 + 1);
el = convertNum(num*5 + 5);
k = textread(file,'%s','delimiter',',');
dat = char(k(1:8));
data1 = {strcat(dat(1,:),',',dat(2,:),',',dat(3,:))};
data2 = {strcat(dat(4,:),',',dat(5,:),',',dat(6,:),',',dat(7,:),',',dat(8,:))};
xlswrite(wfile,data1,'RawData',strcat(sl,num2str(sn),':',sl,num2str(sn)))
xlswrite(wfile,data2,'RawData',strcat(sl,num2str(sn+1),':',sl,num2str(sn+1)))
xlswrite(wfile,piezo,'RawData',strcat(pl,'2',':',pl,'2'))
m = [];
for i = 9:length(k)
    m = [m; str2num(cell2mat(k(i)))];
end
xlswrite(wfile,m,'RawData',strcat(sl,num2str(sn+2),':',el,num2str(sn+length(m)+1)))
end


% number must in the form _ _p_ _
% as in, one or two digits before p and
% one or two digits after p. (no more, no less)
function [out] = findpiezo(n)
out = 0;
a = findstr(n,'piezo');
n = n(a:end);
b = findstr(n,'p');
b = b(2);
num1 = n(6:b-1);
num2 = n(b+1:b+2);
if isempty(str2num(n(b+2)))
    num2 = n(b+1);
    out = out + str2num(num2)/10;
else
    out = out + str2num(num2)/100;
end
out = out + str2num(num1);
end

