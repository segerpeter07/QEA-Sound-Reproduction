function ans = equalize_length(data, fs)
    ans = [];
    
    for i = 1:size(data,2)
        j = 1;
        temp = data(:,i);   % Could be faster if temp isn't allocated?
        while j < size(temp,1)
            if(temp(j) > 0.1)
                break;
            else
                j = j+1;
            end
        end
        low = round(j-0.1*fs);
        if low < 0
            low = 1;
        end
        high = low+0.5*fs;

        if high > size(temp,1)
            high = size(temp,1)-1;
            low = high-0.6*fs;
        end
        ans = [ans temp(low:high)];
    end
end