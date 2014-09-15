% Main fitting code that figures 
% out the number of peaks and decides whether 
% to use onefit or twofit
% input: n by 2 array, e.g. something output by getData
% last updated: 1/14/2013

function [answer] = fit(osa)
    addpath('helper')
    plot(osa(:,1),osa(:,2))
    hold on

    condition3=0; %Added by AJG initialize noise condition to zero.
    answer(3,1)=1; %Added by AJG initialize min transmission to 1
    m1=1; %Added by AJG starting value
    
      while (m1 ==1) || (m1 >= length(osa(:,1))) 
        [m1, mi] = min(osa(:,2)); %%deepest peak
        base = max(osa(:,2)); %%highest point
        depth = base - m1;
        m1 = mi;
        if m1 == 1
            osa=osa(m1+1:end,1:2);
        elseif m1==length(osa(:,1))
            osa=osa(1:end-1,1:2);
        end
      end
     
    sub=osa;
    sub(m1,:)=[]; %Subarray with minimum point deleted.
    if (osa(m1,2)/mean(sub(:,2))) > 0.987 %Noise condition
        condition3=1;
    end
    
    [peakinfo, range, osa] = checks2peak(osa);
    right = peakinfo(:,2);
    left = peakinfo(:,1);
    %note right(2) = left(2) = index in osa of 1st peak
    
    onepeak = 0;
    if condition3 %Condition for just noise as input
        outorig=[osa(1,1),osa(end,1)];
        out = outorig;
    elseif left(1) && ~right(1) %%2nd peak to left
        leftp = left(3); %row in osa of left peak
        rightp = left(2); %row in osa of right peak
    elseif right(1) && ~left(1) %%2nd peak to right
        leftp = right(2);
        rightp = right(3);
    elseif right(1) && left(1) %%peaks on right and left (picks deeper one)
        if osa(right(3)) < osa(left(3))
            leftp = right(2);
            rightp = right(3);
        else
            leftp = left(3);
            rightp = left(2);
        end
    else
        onepeak = 1;
    end
    
    if onepeak && ~condition3
        a = findosa(osa(right(2):end,1:2));
        b = findosa(osa(1:right(2),1:2));
        span = a - b;
        span = (span*5)/2;
        outorig = [osa(right(2),1) - span, osa(right(2),1) + span];
        out=outorig;
    elseif ~condition3
        a = findosa(osa(1:leftp,1:2));
        a = 5*(osa(leftp,1) - a);
        b = findosa(osa(rightp:end,1:2));
        b = 5*(b - osa(rightp,1));
        outorig = [osa(leftp,1) - a, osa(rightp,1) + b];
        out=outorig;
    end
    
    %limit the range to points within osa 
    if out(1) < osa(1,1) 
        out(1) = osa(1,1);
    end
    if out(2) > osa(end,1)
        out(2) = osa(end,1);
    end
        
    temp = osa(osa(:,1) >= out(1),[1,2]);
    temp = temp(temp(:,1) <= out(2),[1,2]);
    
    if condition3
        answer=ones(3,7);
        answer(3,1)= osa(m1,2)/mean(sub(:,2));
    elseif onepeak
        answer = onefit(osa(:,1),osa(:,2),temp(:,1),temp(:,2));
        answer(3,1)=osa(m1,2)/answer(1,4);
    else
        answer = twofit(osa(:,1),osa(:,2),temp(:,1),temp(:,2),osa(rightp,2),osa(leftp,2));
        if leftp == left(2)
            answer = twofit(osa(:,1),osa(:,2),temp(:,1),temp(:,2),osa(left(2),2),osa(rightp,2));
        end
        answer(3,1) = osa(m1,2)/answer(1,7);
    end
    %AJG will likely need a condition when no peak found
    answer(2,3)=outorig(1); %Added by AJG New wavelength start
    answer(2,4)=outorig(2); %Added by AJG New wavelength stop
    answer
    plot(temp(:,1),temp(:,2))
    plot([out(1),out(1)],[osa(right(2),2),range(1)]);
    plot([out(2),out(2)],[osa(right(2),2),range(1)]); %********
    hold off
end
        