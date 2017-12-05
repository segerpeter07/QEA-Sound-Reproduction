function ans = band_pass_filter(dataset, trial)
    load(dataset)
    
    if(trial == 1)
        set = trial_1;
    elseif(trial == 2)
        set = trial_2;
    elseif(trial == 3)
        set = trial_3;
    end
    
    filtered = [];
    
    for i = 1:size(set,2)
        filtered = [filtered filter_speech(set(:,i), Fs)];
    end
    
    ans = filtered;
end