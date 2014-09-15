function [] = writefit(fit,wfile,num)
    num = num + 1;
    s = convertNum(num);
    sx = strcat(s,num2str(3));
    fit = fit(1,:);
    if length(fit) == 7
        if fit(2) < fit(5)
            fit = [fit(7); fit(2); fit(3); fit(1); fit(5); fit(6); fit(4)];
        else
            fit = [fit(7); fit(5); fit(6); fit(4); fit(2); fit(3); fit(1)];
        end
        ex = strcat(s,num2str(9));       
        xlswrite(wfile,fit,'Q_factor MultiDip',strcat(sx,':',ex))
    elseif length(fit) == 4
        fit = [fit(4);fit(2);fit(3);fit(1)];
        ex = strcat(s,num2str(6));  
        xlswrite(wfile,fit,'Q_factor',strcat(sx,':',ex))
    end
end