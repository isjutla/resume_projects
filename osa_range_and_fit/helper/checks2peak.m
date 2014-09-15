% helper function for fit function
% Checks if there is a possible peak to 
% the left or the the right of the main peak
% -input: n by 2 array of osa data
% -output: 
%     -osa, original osa for redundancy
%     -range, contains [base,depth]
%     -out, 3 by 2 array, left column corresponds to 
%         left peak and right column coresponds to 
%         right peak. The first row indicates if it
%         exists, second row is just the row of the
%         deepest peak in osa, third row is the row
%         of the possible 2nd peak in the osa array
% last updated 1/14/2013


function [out,range,osa] = checks2peak(osa)
%[osa, c, cplus] = scurv(osa);
c = curvepoints(osa);
K = c(:,4);
cplus = c(K==1,:); %all points of + curvature
cminus = c(K==-1,:); %all points of - curvature

[m,mi] = min(cplus(:,2));
mi = cplus(mi,3); %index (row) of first peak in osa array

base = max(osa(:,2)); %highest point
depth = base - m;
p = find(cplus(:,3) == mi); %1st peak in range of curvepoints

rightside = [0;mi;0];
leftside = [0;mi;0];
if right(cplus,p)
    l = p+1; %+ curvepoint immediately right of 1st peak
    [rm, rmi] = min(cplus(l:end,2));
    rmi = rmi + (l-1);
    if halfway(base,depth,rm)
        if minuspoint(c,p,rmi)
            between = minuspointvalue(c,p,rmi);
            if point93(between,base,rm)
                rightside = [1;mi;cplus(rmi,3)];
            end
        end
    end
end  

if left(cplus,p)
    l = p-1; %+ curvepoint immediately right of 1st peak
    [lm, lmi] = min(cplus(1:l,2));
    if halfway(base,depth,lm)
        if minuspoint(c,lmi,p)
            between = minuspointvalue(c,lmi,p);
            if point93(between,base,lm)
                leftside = [1;mi;cplus(lmi,3)];
            end
        end
    end
end  

out = [leftside,rightside];
range = [base,depth];
end

%points of + curvature to the right of 1st peak exists
function [out] = right(cplus,p) 
    if p < length(cplus(:,3))
        out = 1;
    else
        out = 0;
    end
end

%point of + curvature to the left of 1st peak exists
function [out] = left(cplus,p)
    if p > 1
        out = 1;
    else
        out = 0;
    end
end

%peak is at least halfway from base to 1st peak
function [out] = halfway(base,depth,m)
    if (base - m) >= depth/2;
        out = 1;
    else
        out = 0;
    end
end

%checks if point of - curvature exist between the 1st and
%supposed 2nd peak. 
%Note: the way 'curvepoints' is coded, it is very rare that
%a - curvature point does not exists between 2 + curvepoints
function [out] = minuspoint(c,mi,rmi)
    temp = 1:length(c);
    temp = temp(c(:,4)==1);
    between = c(temp(mi)+1:temp(rmi)-1,:);
    if isempty(between)
        out = 0;
    else
        K = between(:,4);
        between = between(K==-1,:);
        if isempty(between)
            out = 0;
        else
            out = 1;
        end
    end
end

function [out] = minuspointvalue(c,mi,rmi)
    temp = 1:length(c);
    temp = temp(c(:,4)==1);
    between = c(temp(mi)+1:temp(rmi)-1,:);
    K = between(:,4);
    between = between(K==-1,:);
    out = between;
end

%supposed peak is at least 0.96 away from the - curvature
%point between it and the 1st peak
function [out] = point93(between,base,m)
    minusmax = max(between(:,2));
    if (base - minusmax) < 0.93*(base - m)
        out = 1;
    else
        out = 0;
    end
end
            
            
            
            
    