function res = preprocessing(dataset, trial)
    load(dataset);

    if(trial == 1)
        set = trial_1;
    elseif(trial == 2)
        set = trial_2;
    elseif(trial == 3)
        set = trial_3;
    end
        
    room_noise = room_noise_generator(dataset, trial);
    % INSERT SPECTRUM SUBTRACTION METHOD HERE
    %filtered = band_pass_filter(dataset, trial);
    %equalized = equalize_length(filtered, Fs);
    filtered = matrix_spectral_subtraction(set, room_noise, Fs);
    filtered_set_size = size(filtered);
    set_size = size(set);
%     equalized = equalize_length(filtered, Fs);
    equalized = equalize_length(set, Fs);
    
    res = equalized; 
end