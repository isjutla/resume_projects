% Main function that finds the range around 
% either a single peak or double peak
% lorentzian. The range is 4 FWHM
% input: n by 2 array data, e.g. output of getData
% output: 1 by 2 array => [left cutoff, right cutoff]
% last updated: 8/1/2012
function [out] = spanosa(osa)
    addpath('helper')
    plot(osa(:,1),osa(:,2))
    hold on

    c = curvepoints(osa);
    plot(c(:,1),c(:,2),'r*')
    [m1, mi] = min(osa(:,2)); %%deepest peak
    base = max(osa(:,2)); %%highest point
    depth = base - m1;
    m1 = mi;
    
    p = find(c(:,3) == m1);
    if p < length(c(:,3)) %%peak right of m1 may exist
        l = c(p + 1,3);
        [tempm1, m1i] = min(osa(l:end,2)); %%peak right of m1
        m1i = m1i + (l - 1); 
        condition1 = (base - tempm1) >= depth/2 && ~isempty(find(c(:,3) == m1i));
    else
        condition1 = 0; 
    end
    
    if p > 1 %%peak left of m1 may exisit 
        r = c(p - 1,3);
        [tempm2, m2i] = min(osa(1:r,2)); %%peak left of m1
        condition2 = (base - tempm2) >= depth/2 && ~isempty(find(c(:,3) == m2i));
    else
        condition2 = 0;
    end
       
    if condition1 %%right peak exists
        m2 = m1i;
        a = findosa(osa(1:m1,1:2));
        a = 4*(osa(m1,1) - a);
        b = findosa(osa(m2:end,1:2));
        b = 4*(b - osa(m2,1));
        out = [osa(m1,1) - a, osa(m2,1) + b];
    elseif condition2 %%left peak exists
        m2 = m2i;
        a = findosa(osa(1:m2,1:2));
        a = 4*(osa(m2,1) - a);
        b = findosa(osa(m1:end, 1:2));
        b = 4*(b-osa(m1,1));
        out = [osa(m2,1) - a, osa(m1,1) + b];
    else %%only one peak
        a = findosa(osa(m1:end,1:2));
        b = findosa(osa(1:m1,1:2));
        span = a - b;
        span = (span*4)/2;
        out = [osa(m1,1) - span, osa(m1,1) + span];
    end
    if out(1) < osa(1,1)
       out(1) = osa(1,1);
    end
    if out(2) > osa(end,1)
        out(2) = osa(end,1);
    end
    plot([out(1),out(1)],[osa(m1,2),base]);
    plot([out(2),out(2)],[osa(m1,2),base]); %********
end
        